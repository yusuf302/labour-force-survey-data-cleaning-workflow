############################################################
# 01_data_cleaning.R
# Author: Yusuf J.
# Purpose: Clean and prepare ILFS 2024 dataset for analysis
############################################################

# ===============================
# 1. Load Required Libraries
# ===============================
library(tidyverse)
library(haven)
library(labelled)

# ===============================
# 2. Import Data
# ===============================
# NOTE: Replace with your actual path
data_raw <- read_sav("ILFS2024-URT-FINAL.sav")

# Inspect structure
glimpse(data_raw)

# ===============================
# 3. Create Labour Force Participation Variable
# ===============================
data <- data_raw %>%
  mutate(
    lfp_binary = ifelse(ILO_LFS %in% c(1, 2), 1, 0)
  )

# ===============================
# 4. Filter Youth Sample (18–35)
# ===============================
data_youth <- data %>%
  filter(Q06B_MEM_AGE >= 18 & Q06B_MEM_AGE <= 35)

# ===============================
# 5. Create Key Variables
# ===============================

# Gender (1 = Male)
data_youth <- data_youth %>%
  mutate(
    male = ifelse(Q04_MEM_SEX == 1, 1, 0)
  )

# Age and Age squared
data_youth <- data_youth %>%
  mutate(
    age = Q06B_MEM_AGE,
    age2 = age^2
  )

# ===============================
# 6. Save Intermediate Dataset
# ===============================
write_csv(data_youth, "data/youth_cleaned.csv")

############################################################
# END OF SCRIPT
############################################################