library(readxl)
#replace with path to your cleaned data file
cleaned = read_excel("C:\\Users\\Austin\\Downloads\\morphII_cleaned_v2.csv.xlsx")

features = read.csv("D:\\Features\\MorphII_full\\BIF\\MorphII_BIF_s7-37_g0.1_max_full.csv")

fn = features
cln.dat = cleaned

#inputs are features and cleaned data respectively
BIF.Merge <- function(fn, cln.dat){
  
  #extract photo ID
  id.cln.dat = cbind(sapply(cln.dat[,11],substring,first = 8, last =50),cln.dat[,5],cln.dat[,6],cln.dat[,13])
  
  #check if any IDs are repeated#
  table(duplicated(id.cln.dat[,1]))
  
  #change first column of data to "photo" for merging#
  colnames(fn)[1] = "photo"
  
  
  #merge based on "photo column"
  merg.dat = merge(id.cln.dat,fn,by = "photo")
  return(merg.dat)
}
#test1 = BIF.Merge(features,cleaned)
#table(duplicated(cleaned$age_dec))

setwd("D:\\Features\\MorphII_full\\BIF")

temp = list.files(pattern="*.csv")

list2env(
  lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv,header=FALSE), envir = .GlobalEnv)

for (i in 1:length(ls())){
  if (grepl("Morph",ls()[i]) == TRUE) {
  merg.dat = BIF.Merge(get(ls()[i]),cleaned)
  assign(ls()[i],merg.dat)
  }
}

