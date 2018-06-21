library(readxl)

#read in cleaned data
cleaned = read_excel("C:\\Users\\Austin\\Downloads\\morphII_cleaned_v2.csv.xlsx")

#establish function
BIF.Merge <- function(fn, cln.dat){
  id.cln.dat = cbind(sapply(cln.dat[,11],substring,first = 8, last =50),cln.dat[,5],cln.dat[,6],cln.dat[,13])
  table(duplicated(id.cln.dat[,1]))
  colnames(fn)[1] = "photo"
  merg.dat = merge(id.cln.dat,fn,by = "photo")
  return(merg.dat)
}

#set working directory to where the feature files are
setwd("D:\\Features\\MorphII_full\\BIF")

#grab a list of all csv files in folder
temp = list.files(pattern="*.csv")

#read in all data in as a seperate object
list2env(
  lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv,header=FALSE), envir = .GlobalEnv)

#run the merge function on all data
for (i in 1:length(ls())){
  if (grepl("Morph",ls()[i]) == TRUE) {
    merg.dat = BIF.Merge(get(ls()[i]),cleaned)
    assign(ls()[i],merg.dat)
  }
}

