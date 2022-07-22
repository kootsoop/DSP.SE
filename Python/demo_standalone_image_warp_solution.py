from dataclasses import dataclass
from typing import Optional

import cv2
import numpy as np

import tensorflow as tf


def tf_box_sum_image_from_padded_image(padded_image, width: int):
    integral_image = tf.cumsum(tf.cumsum(padded_image, axis=0), axis=1)
    return integral_image[width:, width:] \
           - integral_image[width:, :-width] \
           - integral_image[:-width, width:] \
           + integral_image[:-width, :-width]


@dataclass
class WarpingRenderer:
    """ Warp an image using a heatmap.  High-heat regions in the image are "inflated" - ie their pixels are pushed out. """
    warp_width: int  # Size of the box-filter kernel (note - effective kernel is n_iter times this)
    heatmap_power: int = 1  # Set to zero just to test edges
    n_iter: int = 2  # Number of box-filter iterations: 0=identity, 1=box-filter, 2=triangle-filter, 3-almost-gaussian
    heatmap_epsilon: float = 1e-9  # For numerical stability, we impose a minimum value on the heatmap

    _yx_grid: Optional['Tensor["H,W,2", float32]'] = None

    def render_heatmap(self, image: 'Tensor["H,W,3", uint3]', heatmap: 'Tensor["H,W", float32]') -> 'Tensor["H,W,3", uint3]':

        # Get the left/right pixel-padding margings
        prepad = (self.warp_width // 2 + 1) * self.n_iter
        postpad = (self.warp_width - (self.warp_width // 2 + 1)) * self.n_iter

        # Compute the pixel coordinate grid (including padding).  Cache result.
        if self._yx_grid is None:
            xrange = tf.range(-prepad, image.shape[1] + postpad, dtype=tf.float32)
            yrange = tf.range(-prepad, image.shape[0] + postpad, dtype=tf.float32)
            xs, ys = tf.meshgrid(xrange, yrange)
            self._yx_grid = tf.concat([ys[:, :, None], xs[:, :, None]], axis=2)

        # Run an iterative box filter over the weighted corrdinates and weights
        weights = (heatmap / tf.reduce_max(heatmap)) ** self.heatmap_power / self.warp_width ** 2 + self.heatmap_epsilon  # For numerical stability
        padded_weights = tf.pad(weights, paddings=[(prepad, postpad), (prepad, postpad)], mode='REFLECT')
        weighted_coords = self._yx_grid * padded_weights[:, :, None]
        for _ in range(self.n_iter):
            weighted_coords = tf_box_sum_image_from_padded_image(weighted_coords, width=self.warp_width)
            padded_weights = tf_box_sum_image_from_padded_image(padded_weights, width=self.warp_width)

        # Compute the new pixel coordinates (this is just nearest-neighbour interpolation)
        yx_prime = weighted_coords / padded_weights[:, :, None]
        yx_prime_rounded = tf.cast(yx_prime + 0.5, dtype=tf.int32)
        yx_prime_rounded = tf.clip_by_value(yx_prime_rounded, 0, tf.constant([image.shape[0] - 1, image.shape[1] - 1]))  # Only necessary due to numerical error

        # Take pixels from the old image at those coordinates.
        new_img = tf.reshape(tf.gather_nd(image, indices=tf.reshape(yx_prime_rounded, (-1, 2))), image.shape)
        return new_img


def demo_standalone_image_warp():
    image = cv2.imread(cv2.samples.findFile('lena.jpg'))

    image = cv2.resize(image, dsize=None, fx=0.5, fy=0.5)

    # Create heatmap from two superimposed gaussians
    h, w = image.shape[:2]
    xs, ys = np.meshgrid(np.arange(image.shape[1]), np.arange(image.shape[0]))
    xy_grid = np.concatenate([xs[:, :, None], ys[:, :, None]], axis=2)
    mu1 = 0.55 * w, 0.53 * h
    sig1 = 0.07 * w
    mu2 = 0.2 * w, 0.3 * h
    sig2 = 0.1 * w
    heatmap = np.exp(-((xy_grid - mu1) ** 2).sum(axis=2) / (2 * sig1 ** 2)) / sig1 ** 2 + np.exp(-((xy_grid - mu2) ** 2).sum(axis=2) / (2 * sig2 ** 2)) / sig2 ** 2

    # Compute the warped image
    distorted = WarpingRenderer(warp_width=40, n_iter=2, heatmap_epsilon=1e-6).render_heatmap(image, heatmap.astype(np.float32))

    # Display
    heatmap_image = np.repeat((heatmap / heatmap.max() * 255.).astype(np.uint8)[:, :, None], repeats=3, axis=2)
    display_image = np.hstack((image, heatmap_image, distorted))
    cv2.imshow('Warping', display_image)
    cv2.waitKey(10000)


if __name__ == "__main__":
    demo_standalone_image_warp()
