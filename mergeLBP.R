library(readxl)

#read in cleaned data
cleaned = read_excel("D:\\Downloads\\morphII_cleaned_v2.xlsx")

#establish function
LBP.Merge <- function(fn, cln.dat){
  id.cln.dat = cbind(sapply(cln.dat[,11],substring,first = 8, last =50),cln.dat[,5],cln.dat[,6],cln.dat[,13])
  table(duplicated(id.cln.dat[,1]))
  colnames(fn)[1] = "photo"
  merg.dat = merge(id.cln.dat,fn,by = "photo")
  return(merg.dat)
}

#set working directory to where the feature files are
setwd("E:\\Features\\MorphII_full\\LBP")

#grab a list of all csv files in folder
temp = list.files(pattern="*.csv")

#read in all data in as a seperate object
list2env(
  lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv,header=FALSE), envir = .GlobalEnv)

oldsize = NULL
for (i in 1:length(ls())) {
  oldsize = rbind(oldsize,c(ls()[i],dim(get(ls()[i]))))
}

#run the merge function on all data
#worked for about half then crashed
for (i in 1:length(ls())){
  if (grepl("Morph",ls()[i]) == TRUE) {
    merg.dat = LBP.Merge(get(ls()[i]),cleaned)
    assign(ls()[i],merg.dat)
  }
}

newsize = NULL
for (i in 1:length(ls())) {
  newsize = rbind(newsize,c(ls()[i],dim(get(ls()[i]))))
}

#verify 3 added variables
as.numeric(newsize[5:22,3])-as.numeric(oldsize[5:22,3])


setwd("E:\\Features\\MorphII_full\\Merged LBP")

for (i in 1:length(ls())){
  if (grepl("Morph",ls()[i]) == TRUE) {
    write.csv(get(ls()[i]),paste(ls()[i],".csv",sep = ""))
  }
}
