NEI <- readRDS("summarySCC_PM25.rds")

totals <- tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png", width=480, height=480)
barplot(totals/1e6,
        names.arg=names(totals),
        col="lightblue",
        main="Total PM2.5 Emissions in the US (1999–2008)",
        xlab="Year", ylab="Emissions (millions of tons)")
dev.off()