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

“Threshold_computation_UKB_issues.m” file in the repository used to compute threshold values for high voltage or low voltage or high mean frequency-based artifacts and then to choose threshold value for ECG with lead reversal.

Then, “plot_non_physiological_ECGs_wrt_computed_Thresholds.m” File in the repository plots non-physiological ECG artifacts (high voltage, low voltage, high mean frequency-based outliers) and then ECGs with lead reversal by using threshold values computed in "Threshold_computation_UKB_issues.m" file.


**Test files**

18 different test files (having 12 lead ECGs in each file) with sampling rate 500Hz.
