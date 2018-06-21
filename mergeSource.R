#read files in
library(readxl)
fn1 = file.choose()
#"\\MorphII_BIF_s7-37_g0.3_std_full.csv"
mrph.big = read.csv(fn1, header = FALSE)


fnbatch = file.choose()
#"\\S1_go_for_age.csv.xlsx"
batch = read_excel(fnbatch)


#pull the photo ID, gender, and race from batch of 10k# 
#column 12 is the photo ID, column 7 is the gender, column 6 is the race#
id.batch = cbind(sapply(batch[,11],substring,first = 8, last =50),batch[,5],batch[,6],batch[,13])


#check if any IDs are repeated#
table(duplicated(id.batch[,1]))

#change first column of data to "photo" for merging#
colnames(mrph.big)[1] = "photo"


#merge based on "photo column"
full.mrph.big = merge(id.batch,mrph.big,by = "photo")
View(full.mrph.big)
