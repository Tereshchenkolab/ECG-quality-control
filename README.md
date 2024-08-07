# ECG-quality-control

Automated Detection of Non-physiological Artifacts on ECG Signal


**Table of Content**

•	MATLAB Code

•	Test file


**Authors**

•	Hassaan A. Bukhari, bukhars7@ccf.org	

•	Shivangi Kewalramani

•	Luke Witzigreuter

•	Jafar Pourbemany

•	Natalia Amadio

•	Hernan Rincon-Choles

•	Panduranga Rao

•	 Zeenat Bhat

•	Elsayed Z. Soliman

•	Larisa G. Tereshchenko, tereshl@ccf.org	          


**MATLAB Code**

“Threshold_computation_UKB_issues.m” file in the repository used to compute threshold values for high voltage or low voltage or high mean frequency-based artifacts and then to choose threshold value for ECG with lead reversal. Here, we modified the already existing criteria, proposed by Grubbs as described in [1] and implemented in [2] to identify outliers. For identifying lead reversal issues, we modified Kors et al. approach [3].

Then, “plot_non_physiological_ECGs_wrt_computed_Thresholds.m” File in the repository plots non-physiological ECG artifacts (high voltage, low voltage, high mean frequency-based outliers) and then ECGs with lead reversal by using threshold values computed in "Threshold_computation_UKB_issues.m" file.

Please Note: If someone want to directly validate our algorithm on CRIC data (by having complete CRIC dataset) using UKB thresholds then please use following code (which is exactly similar to the above shown code file i.e. “plot_non_physiological_ECGs_wrt_computed_Thresholds.m” but by using UKB thresholds (the ones shown in Table I, III, and V of manuscript). For Table I and V: Threshold are shown in 'mV' unit so we used it in samples and then multiplied it with 5 because UKB has amplitude resolution of 5uV and CRIC has 1uV. 
For example, threshold for 'lead I' in Table I is 4.62mV (equal to 923.36 in samples) and then if we multiplied 923.6 with 5 (amp resolution in UKB) then we will get 4616.8 (~4617) so we used 4617 (similarly for other leads).

"plot_non_physiological_ECGs_wrt_computed_Thresholds_for_CRIC.m" File plots non-physiological CRIC-based ECG artifacts (high voltage, low voltage, high mean frequency-based outliers) and then non-physiological CRIC-based ECGs with lead reversal by using UKB thresholds

**Test files**

18 different test files (having 12 lead ECGs in each file) with sampling rate 500Hz.




**References**

[1]Grubbs, Frank E. “Procedures for Detecting Outlying Observations in Samples.” Technometrics, vol. 11, no. 1, 1969, pp. 1–21. JSTOR, https://doi.org/10.2307/1266761.

[2]Brett Shoelson (2024). deleteoutliers (https://www.mathworks.com/matlabcentral/fileexchange/3961-deleteoutliers), MATLAB Central File Exchange. Retrieved April 17, 2024.

[3]Jan A Kors, Gerard van Herpen, Accurate automatic detection of electrode interchange in the electrocardiogram, The American Journal of Cardiology, Vol. 88, no. 4,
2001, pp. 396-399, https://doi.org/10.1016/S0002-9149(01)01686-1.
