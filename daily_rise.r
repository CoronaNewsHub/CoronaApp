library(utils)

print("Running daily casesa dm deaths")

#read the Dataset sheet into “R”. The dataset will be called "data".
data <- read.csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", na.strings = "", fileEncoding = "UTF-8-BOM")

ned <- data[data$countriesAndTerritories %in% "Netherlands",]
write.table(ned, file="www/daily_rise.csv", sep=",", row.names = F)
