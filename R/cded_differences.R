

# 1. Load required packages and read csv files. ----------------------------------------------

library(data.table)
library(here)


# Read in all the raw csv files in a list:
elderly_data_list <-
  lapply(list.files(here("raw_csv_data"), full.names = T), fread, stringsAsFactors = F)



# 2. Overview of the contents of csv files ---------------------------------


# Overview of the 10 files and contents:
list.files(here("raw_csv_data"), full.names = F)


## elderly_data_list[[1]]: "GE-79_Data_Dictionary.csv":
# A dictionary detailing what each variable means, with examples of data from two subjects: S0434 & S0078

## elderly_data_list[[2]]: "GE-79_Files_and_Channels.csv":
# is an overview of what is done at each visit and where the data goes
# (well, it tries to provide an overview, but doesn't really help)

## elderly_data_list[[3]]: "GE-79_Files_per_subject.csv":
# Is a list of how much lab and ECG data is available for each individual

## elderly_data_list[[4]]: "GE-79_Summary_Table-Cognitive-Testing.csv"
# Is cognitive test results

## elderly_data_list[[5]]: "GE-79_Summary_Table-Demographics-MRI-Part1.csv"
# Is MR data, with a little extra data on group, race, BMI, and a little medical history

## elderly_data_list[[6]]: "GE-79_Summary_Table-Labs-BP-Ophthalmogic-Walk.csv"
# Is survey data, medication history, lab biomarkers, blood pressure, eye examination and gait test.

## elderly_data_list[[7:9]]: "GE-79_Summary_Table-MRI-Part[2-4].csv"
# These 3 files are all pure MRI data

## elderly_data_list[[10]]: "GE-79_Summary_Table-MRI-Part5-History.csv"
# Is also MRI data, but appears to hold some survey/medical history data as well


# The data in 10 appears to be a duplicate of 6, as the survey data in # 10 is the exact same data as #6):
identical(
  elderly_data_list[[6]]$`Numbness AUTONOMIC SYMPTOMS`,
  elderly_data_list[[10]]$`Numbness AUTONOMIC SYMPTOMS`
) # TRUE




# 3. Inspect data reported in appendix tables of https://doi.org/10.3390/s20174995 ----------------------------------------------

View(cbind(elderly_data_list[[6]][, c("patient ID",
                                      "HTN YRS PATIENT MEDICAL HISTORY",
                                      "DM PATIENT MEDICAL HISTORY")],
           elderly_data_list[[5]][, 1:11])
)



# Discrepancies between subject IDs not in the dataset, and in characteristics of the subject ID's in the dataset:

# In a sample of the first 10 subjects of Table A1:

head(cbind(elderly_data_list[[6]][, c("patient ID",
                                      "HTN YRS PATIENT MEDICAL HISTORY",
                                      "DM PATIENT MEDICAL HISTORY")],
           elderly_data_list[[5]][, 1:11]), 10)

# E.g. in table A1:
# Subject ID's S0030, S0064, S0068 and S0153 are in the dataset with the same race and height (approximately),
# but most are recorded as being heavier, and S0030 and S0064 as having HTN in medical records, which is not the case in the dataset.

# Subjects S0121, S0154, S0160, S0163, S0164, S0165 are not in the dataset at all.
