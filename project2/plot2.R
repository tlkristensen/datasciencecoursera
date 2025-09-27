NEI <- readRDS("summarySCC_PM25.rds")

baltimore <- subset(NEI, fips=="24510")
totals <- tapply(baltimore$Emissions, baltimore$year, sum)

png("plot2.png", width=480, height=480)
barplot(totals,
        names.arg=names(totals),
        col="red",
        main="PM2.5 Emissions in Baltimore City (1999–2008)",
        xlab="Year", ylab="Emissions (tons)")
dev.off()