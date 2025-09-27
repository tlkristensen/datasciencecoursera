library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips=="24510")

png("plot3.png", width=480, height=480)
ggplot(baltimore, aes(x=factor(year), y=Emissions, fill=type)) +
  geom_bar(stat="identity") +
  facet_wrap(~type, scales="free_y") +
  labs(title="PM2.5 Emissions in Baltimore by Source Type",
       x="Year", y="Total Emissions (tons)") +
  theme_bw()
dev.off()