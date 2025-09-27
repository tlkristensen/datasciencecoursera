#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "american-community-survey.csv")

table <- read.csv("american-community-survey.csv")
values <- table$VAL
values <- values[!is.na(values) ]

length(values[values == 24])

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "natural-gas.xlsx")
#library(xlsx)
data <- read.xlsx("natural-gas.xlsx", sheetIndex=1, header=TRUE)
dat <- read.xlsx("natural-gas.xlsx", sheetIndex=1, header=TRUE, rowIndex = 18:23, colIndex =  7:15)

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", "restaurants.xml")
#install.packages("XML") #, repos = "http://www.omegahat.net/R")
#library(XML)

doc <- XML::xmlTreeParse("restaurants.xml", useInternalNodes = TRUE)
rootNode <- XML::xmlRoot(doc)
zip <- XML::xpathSApply(rootNode,"//zipcode",XML::xmlValue)
length(zip[zip == 21231])


download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "housing.csv")
install.packages("data.table")
library(data.table)

DT <- data.table::fread("housing.csv")