# Getting and Cleaning Data Quiz
# Week 4


# Q1

install.packages("data.table")
library(data.table)

acs <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
dim(acs)
colnames <- names(acs)

var <- strsplit(colnames, "wgtp")
var[123]

# Q2

gdp <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                         skip = 5,
                         nrows = 190,
                         select = c(1,2,4,5),
                         col.names = c("CountryCode", "Rank", "Country", "GDP"))

gdp[, mean(as.numeric(gsub(pattern = ",", replacement = "", x = GDP)))]

# Q3

grep("^United", gdp[, Country])
sum(grepl("^United", gdp[, Country]))
grep("^United", gdp[,Country], value = TRUE)
grep("United", gdp[,Country], value = TRUE)

# Q4

gdp <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                         skip = 5,
                         nrows = 190,
                         select = c(1,2,4,5),
                         col.names = c("CountryCode", "Rank", "Country", "GDP"))

edu <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")


mergedDT <- merge(gdp, edu, by = "CountryCode")

View(mergedDT)

mergedDT[grepl(pattern = "Fiscal year end: June 30;", mergedDT[, `Special Notes`]), .N]

# Q5

install.packages("quantmod")
library(quantmod)
amzn <- getSymbols("AMZN", auto.assign = FALSE)
head(amzn)
sampletimes <- index(amzn)
install.packages("lubridate")
library(lubridate)

sampletimes[1:4]

amzn2012 <- sampletimes[grep("^2012", sampletimes)]
length(amzn2012)
NROW(amzn2012)

length(amzn2012[weekdays(amzn2012) == "Monday"])

timeDT <- data.table::data.table(timeCol = sampletimes)

timeDT[(timeCol >= "2012-01-01") & (timeCol < "2013-01-01"), .N]

timeDT[(timeCol >= "2012-01-01") & (timeCol < "2013-01-01") & 
         (weekdays(timeCol) == "Monday"), .N]
