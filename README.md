# ECG-quality-control

Automated Detection of Non-physiological Artifacts on ECG Signal


**Table of Content**

•	MATLAB Code

•	Test file


**Authors**

•	Hassaan A. Bukhari, PhD bukhars7@ccf.org	

•	Shivangi Kewalramani

•	Jafar Pourbemany

•	Natalia Amadio

•	Luke Witzigreuter

•	Prof. Larisa G. Tereshchenko tereshl@ccf.org	          


**MATLAB Code**

“Threshold_computation_UKB_issues.m” file in the repository used to compute threshold values for high voltage or low voltage or high mean frequency-based artifacts and then to choose threshold value for ECG with lead reversal. Here, we modified the already existing criteria, proposed by Grubbs as described in [1] and implemented in [2] to identify outliers. For identifying lead reversal issues, we modified Kors et al. approach [3].

Then, “plot_non_physiological_ECGs_wrt_computed_Thresholds.m” File in the repository plots non-physiological ECG artifacts (high voltage, low voltage, high mean frequency-based outliers) and then ECGs with lead reversal by using threshold values computed in "Threshold_computation_UKB_issues.m" file.


**Test files**

18 different test files (having 12 lead ECGs in each file) with sampling rate 500Hz.


**References**

[1]Grubbs, Frank E. “Procedures for Detecting Outlying Observations in Samples.” Technometrics, vol. 11, no. 1, 1969, pp. 1–21. JSTOR, https://doi.org/10.2307/1266761.

[2]Brett Shoelson (2024). deleteoutliers (https://www.mathworks.com/matlabcentral/fileexchange/3961-deleteoutliers), MATLAB Central File Exchange. Retrieved April 17, 2024.

[3]Jan A Kors, Gerard van Herpen, Accurate automatic detection of electrode interchange in the electrocardiogram, The American Journal of Cardiology, Vol. 88, no. 4,
2001, pp. 396-399, https://doi.org/10.1016/S0002-9149(01)01686-1.
