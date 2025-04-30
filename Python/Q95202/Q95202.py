import numpy as np
 
 
rng = np.random.default_rng()
 
 
def get_noise_power(signal_power: float, snr_dB: float) -> float:
    """Returns the noise power given a signal power and a signal-to-noise ratio (SNR).
 
    Args:
        signal_power (float): power of the signal
        snr_dB (float): SNR in dB
 
    Returns:
        float: _description_
    """
    return signal_power * 10**(-snr_dB / 10)


print(get_noise_power(1,-15))
