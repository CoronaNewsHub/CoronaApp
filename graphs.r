#library(ggplot2)
#library(gridExtra)
#library(reshape2)
#library(RColorBrewer)


#f1 <- read.table("www/cases.txt", sep="\t", stringsAsFactors=F, header=T)
#f2 <- read.table("www/pro_mun.txt", sep="\t", stringsAsFactors=F, header=T)

#f <- merge(f2, f1, by="Municipality", all.x=TRUE)

#ff <- aggregate(f$Cases, by=list(f$Province), FUN=sum, na.rm=TRUE)
#colnames(ff) <- c("Provinces", "Cases")
#write.table(ff,"www/MunicipalityCases.csv",sep=",",row.names=FALSE)

# Also add this part to create a csv file for the numbers
#numbers=read.delim("www/numbers.txt",sep="\t",stringsAsFactors=FALSE,header=TRUE)
#write.table(numbers,"www/numbers.csv",sep=',',row.names=FALSE)

# read the cases file
cases=read.delim("www/cases.csv",header=TRUE,stringsAsFactors=FALSE)
casesTowrite=cases[,c("Municipality","Cases","Hospitalization","Deaths","Cases per 100k","Hospitalization per 100k","Deaths per 100k")]
write.table(casesTowrite,"www/new_cases.csv",sep=",",row.names=FALSE)