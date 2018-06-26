sub1 = read.csv('C:/Users/gratt/Downloads/S1_go_for_age.csv')
sub2 = read.csv('C:/Users/gratt/Downloads/S2_go_for_age.csv')
subR = read.csv('C:/Users/gratt/Downloads/R_go_for_age.csv')

LBP.Subset <- function(fn, sub.ref){
  id.sub.ref = cbind(sapply(sub.ref[,12],substring,first = 8, last =50))
  colnames(id.sub.ref)[1] = "photo"
  sub.dat = merge(id.sub.ref,fn,by = "photo")
  return(sub.dat)
}

setwd("E:\\Features\\MorphII_full\\Merged LBP")
temp = list.files(pattern="*.csv")
list2env(
  lapply(setNames(temp, make.names(gsub("*.csv$", "", temp))), 
         read.csv,header=TRUE), envir = .GlobalEnv)

file.list = ls()[grepl("Morph",ls()) == TRUE]

for (i in 2:length(file.list)){
    S1 = LBP.Subset(get(file.list[i]),sub1)
    S1[,3] = as.character(S1[,3])
    S1[,4] = as.character(S1[,4])
    S1[(S1=="B")]=1
    S1[(S1=="W")]=0
    S1[(S1=="F")]=1
    S1[(S1=="M")]=0
    S2 = LBP.Subset(get(file.list[i]),sub2)
    S2[,3] = as.character(S2[,3])
    S2[,4] = as.character(S2[,4])
    S2[(S2=="B")]=1
    S2[(S2=="W")]=0
    S2[(S2=="F")]=1
    S2[(S2=="M")]=0
    SR = LBP.Subset(get(file.list[i]),subR)
    SR[,3] = as.character(SR[,3])
    SR[,4] = as.character(SR[,4])
    SR[(SR=="B")]=1
    SR[(SR=="W")]=0
    SR[(SR=="F")]=1
    SR[(SR=="M")]=0
    assign(paste(file.list[i],'S1', sep="_"),S1)
    assign(paste(file.list[i],'S2', sep="_"),S2)
    assign(paste(file.list[i],'SR', sep="_"),SR)
}
rm(list = file.list)

setwd("E:\\Features\\MorphII_full\\Subset LBP")

for (i in 1:length(ls())){
  if (grepl("Morph",ls()[i]) == TRUE) {
    write.csv(get(ls()[i]),paste(ls()[i],".csv",sep = ""))
  }
}
