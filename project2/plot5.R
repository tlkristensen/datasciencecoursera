library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

baltimoreVehicles <- subset(NEI, fips=="24510" & type=="ON-ROAD")

png("plot5.png", width=480, height=480)
ggplot(baltimoreVehicles, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity", fill="darkgreen") +
  labs(title="Motor Vehicle PM2.5 Emissions in Baltimore City",
       x="Year", y="Emissions (tons)") +
  theme_bw()
dev.off()