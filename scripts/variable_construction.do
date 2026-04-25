*******************************************************
* 02_variable_construction.do
* Author: Yusuf J.
* Purpose: Construct variables for econometric analysis
*******************************************************

clear all
set more off

* Load cleaned data
import delimited "data/youth_cleaned.csv", clear

*******************************************************
* 1. Education Categories
*******************************************************
gen educ_cat = .

replace educ_cat = 1 if Q11D <= 7
replace educ_cat = 2 if inrange(Q11D, 11, 17)
replace educ_cat = 3 if Q11D >= 18

*******************************************************
* 2. Marital Status Variables
*******************************************************
gen cohabiting_d = (Q09_MARSTAT == 3)
gen prev_married_d = inlist(Q09_MARSTAT, 4,5,6)

*******************************************************
* 3. Training Variable
*******************************************************
gen trained = (Q11G != 1)

*******************************************************
* 4. Household Size
*******************************************************
bysort EA HHNUMBER: gen hhsize = _N

*******************************************************
* 5. Urban Variable
*******************************************************
gen urban = (Q10B1 == 7 | Q10B1 == 53)

*******************************************************
* 6. Final Dataset
*******************************************************
keep lfp_binary male age age2 educ_cat urban hhsize trained cohabiting_d prev_married_d

drop if missing(lfp_binary, male, age, educ_cat)

save "data/final_analysis.dta", replace

*******************************************************
* END
*******************************************************