#Sachleen Tuteja, February 17, 2022, creating a demographics table from pcor data
#Mar 7 - modified to ensure that subject_id isn't truncated 
#modified file - PCORDemographicsTableModified.R

#packages
require(table1)

#files
degr <- read.csv("/Users/sachleentuteja/Desktop/northwestern/rawfiles/
                 demographics/PCOR_demographics.csv", head = T)
pcor <- read.csv("/Users/sachleentuteja/Desktop/northwestern/rawfiles/
                 PCOR_raw_data.csv", head = T)

#merging pcor and degr (demographics) by subject_id
mergePD <- merge(pcor, degr, by = "subject_id")

label(mergePD$sex) <- "Sex"
label(mergePD$age_bin) <- "Age"
label(mergePD$cohort.y) <- "Group"
label(mergePD$race) <- "Race"
label(mergePD$ethnicity) <- "Ethnicity"
label(mergePD$attribute) <- "Attribute"
label(mergePD$type) <- "Code Type"
label(mergePD$date) <- "Date"

#Table 1: age, race, ethnicity of cases and control
table1(~ age_bin + race + ethnicity | cohort.y*sex, 
       data=mergePD, overall="Total")

#Table 1: age, race, ethnicity, diagnosis, and codes of cases and control
table1(~ age_bin + race + ethnicity + attribute + type | cohort.y*sex, 
       data=mergePD, overall=F)

#is there a way to put the date column into yearly bins and then add that data 
#to the table
table1(~ sex + race + ethnicity + attribute + type + date | cohort.y*age_bin, 
       data=mergePD, overall = "Total")
