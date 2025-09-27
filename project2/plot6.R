library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

compare <- subset(NEI, type=="ON-ROAD" & fips %in% c("24510","06037"))
compare$fips <- factor(compare$fips, 
                       levels=c("24510","06037"),
                       labels=c("Baltimore","Los Angeles"))

png("plot6.png", width=480, height=480)
ggplot(compare, aes(x=factor(year), y=Emissions, fill=fips)) +
  geom_bar(stat="identity", position="dodge") +
  labs(title="Motor Vehicle Emissions: Baltimore vs Los Angeles",
       x="Year", y="Emissions (tons)", fill="City") +
  theme_bw()
dev.off()