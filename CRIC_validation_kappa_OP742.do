***validation of algorithm for manuscript OP742
***STATA code written and STATA analyses conducted by Larisa Tereshchenko <tereshl@ccf.org>
***version STATANOW 18.5 MP
***August 2024

use "CRIC_validation_manual_auto.xls"
***variable "manual" coded as 1 = artifacts present; 0 = no artifacts (good quality). Results of manual ECG review.
***variable "auto" coded as 1 = artifacts present; 0 = no artifacts (good quality). Results of automated algorithm by H.Bukhari.


kap manual auto , tab
diagt manual auto , tab

use "CRIC_EPICARE_Tereshchenko.xls"
***EPICARE ground truth is defined as noise level 5 or electrode misplacement
gen EPICARE=1 if QC5==1 | ECG_LEADSWP==1

kap Tereshchenko EPICARE , tab
diagt Tereshchenko EPICARE, tab
   
