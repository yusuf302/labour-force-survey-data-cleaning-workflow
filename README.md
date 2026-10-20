# Youth Labour Force Participation: Data Workflow

**Labour economics · R · Stata · Survey-data preparation**

An illustrative workflow for preparing Tanzania ILFS 2024 data, constructing variables and estimating youth labour force participation models for ages 18–35.

[Browse scripts](scripts/) · [View the HTML presentation source](index.html)

## Workflow

| Step | Script | Input → output |
|---|---|---|
| 1. Clean and select youth | [data_cleaning.R](scripts/data_cleaning.R) | `ILFS2024-URT-FINAL.sav` → `data/youth_cleaned.csv` |
| 2. Construct analysis variables | [variable_construction.do](scripts/variable_construction.do) | Cleaned CSV → `data/final_analysis.dta` |
| 3. Estimate participation models | [model_estimation.do](scripts/model_estimation.do) | Analysis dataset → `output/results.rtf` |

The R script creates participation, sex, age and age-squared variables. Stata scripts add education, marital-status, training, household and urban variables, then fit logit and probit models with robust standard errors. The final `margins` call applies to the most recently fitted model, probit.

## Requirements & execution

- R with `tidyverse`, `haven` and `labelled`.
- Stata with `estout` installed for `esttab`.
- Authorized access to the source ILFS microdata; the source SPSS file is not included.

Run from the repository root, create `data/` and `output/` if needed, supply the SPSS file at the path expected in the R script, then run the three scripts in the order above. HTML files are presentation artifacts; GitHub's file viewer displays their source.

## Validation status

This is an illustrative research workflow, **not a validated survey-analysis pipeline**. Before using it for substantive findings:

- Verify all questionnaire codes, particularly education, urban status, training and participation, against the source codebook.
- Review missing-value treatment. Comparisons such as `Q11D >= 18` and `Q11G != 1` can classify Stata numeric missing values as valid categories. R participation coding also needs an explicit missing-status policy.
- Construct household size from the full household roster. The current script counts rows after selecting youth, which counts retained youth rather than all household members.
- Confirm the education specification: the current models enter `educ_cat` numerically rather than as categorical indicators.
- Specify survey weights, strata and clusters where appropriate. The current models use robust standard errors but do not declare the complex survey design.
- Verify CSV variable-name casing after import and confirm the intended geographic sample; the current R script does not explicitly restrict Mainland Tanzania.

No estimates are advertised here until these issues and replication have been checked. This repository represents an earlier participation workflow and should not be read as the complete, updated dissertation pseudo-panel implementation.

## Data access

Obtain microdata through the appropriate authorized source and follow its access conditions. Do not commit restricted microdata or personal records. This documentation change does not add datasets.

## Author

[Yusuf Abdallah Jongo](https://yusuf-jongo.vercel.app/) — Economist, Data Analyst & AI and Digital Solutions Builder.

