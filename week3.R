#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#download.file(url, destfile = "idaho.csv", method = "curl")
#housing <- read.csv("idaho.csv")

#agricultureLogical <- (housing$ACR == 3 & housing$AGS == 6)
#which(agricultureLogical)

#install.packages("jpeg")
#library(jpeg)

#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
#download.file(url, destfile = "jeff.jpg", mode = "wb")
#img <- readJPEG("jeff.jpg", native = TRUE)

#quantile(img, probs = c(0.3, 0.8))

# Load GDP data
#gdp <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
                #skip = 4, nrows = 190, stringsAsFactors = FALSE)

# Rename some columns for clarity
#gdp <- gdp %>%
#  select(CountryCode = X, Ranking = X.1, Economy = X.2, GDP = X.5)

# Load Education data
#edu <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

# Merge + clean
#merged <- inner_join(gdp, edu, by = "CountryCode")

# Count how many matches
#n_matches <- nrow(merged)

#result <- merged %>% arrange(desc(Ranking))           
                
# Arrange by GDP ranking (descending) and extract the 13th country
#result <- merged %>%
#  arrange(desc(as.numeric(Ranking))) 

#merged %>%
 # group_by(Income.Group) %>%
#  summarise(avg_rank = mean(as.numeric(Ranking), na.rm = TRUE)) %>%
 # filter(Income.Group %in% c("High income: OECD", "High income: nonOECD"))

merged <- merged %>%
  mutate(quantile = cut(as.numeric(Ranking),
                        breaks = quantile(as.numeric(Ranking), probs = seq(0, 1, 0.2), na.rm = TRUE),
                        include.lowest = TRUE))

table(merged$quantile, merged$Income.Group)