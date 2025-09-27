#housing <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
#names(housing)
#s <- strsplit(names(housing), "wgtp")
#s[[123]]

gdp <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
                skip = 4, nrows = 190, stringsAsFactors = FALSE)
gdp_vals <- as.numeric(gsub(",", "", gdp$X.4))
mean(gdp_vals, na.rm = TRUE)

countryNames <- gdp$X.3 
grep("^United", countryNames)

gdp <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
                skip = 4, nrows = 190, stringsAsFactors = FALSE)

gdp <- gdp %>%
  select(CountryCode = X, Ranking = X.1, Economy = X.2, GDP = X.5)

# Load Education data
edu <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

# Merge
merged <- inner_join(gdp, edu, by = "CountryCode")

# Search for fiscal year ending in June
sum(grepl("June", merged$Special.Notes, ignore.case = TRUE))

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

sum(format(sampleTimes, "%Y") == "2012")

# Values collected on Mondays in 2012
sum(format(sampleTimes, "%Y") == "2012" & weekdays(sampleTimes) == "Monday")