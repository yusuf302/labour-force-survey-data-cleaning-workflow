*******************************************************
* 03_model_estimation.do
* Author: Yusuf J.
* Purpose: Estimate labour force participation models
*******************************************************

clear all
set more off

use "data/final_analysis.dta", clear

*******************************************************
* 1. Logit Model
*******************************************************
logit lfp_binary male age age2 educ_cat urban hhsize trained cohabiting_d prev_married_d, vce(robust)

estimates store logit_model

*******************************************************
* 2. Probit Model
*******************************************************
probit lfp_binary male age age2 educ_cat urban hhsize trained cohabiting_d prev_married_d, vce(robust)

estimates store probit_model

*******************************************************
* 3. Marginal Effects
*******************************************************
margins, dydx(*)

*******************************************************
* 4. Save Results
*******************************************************
esttab logit_model probit_model using "output/results.rtf", replace se star(* 0.10 ** 0.05 *** 0.01)

*******************************************************
* END
*******************************************************