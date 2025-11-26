import numpy as np
from skimage.registration import phase_cross_correlation
from skimage.io import imread
import cv2
import skimage as ski
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec

img_a = imread("image_1.png")
img_b = imread("image_2.png")

drift, _, _ = phase_cross_correlation(img_a, img_b, upsample_factor=10)

# test: if I manually translate img_b before phase_cross_correlation, the drift should be larger by the translation amounts

def shift(img: np.ndarray, right_pix: int, down_pix: int):
    M = np.float32([[1, 0, right_pix], [0, 1, down_pix]])
    return cv2.warpAffine(img, M, (img.shape[1], img.shape[0]), borderMode=cv2.BORDER_REPLICATE)

test_drift, _, _ = phase_cross_correlation(img_a, shift(img_b, -3, 5), upsample_factor=10)

print(test_drift)



diff_rotated = ski.util.compare_images(img_a, img_b, method='diff')


plt.imshow(diff_rotated)
plt.pause(100)
