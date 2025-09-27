library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal <- grepl("Coal", SCC$EI.Sector, ignore.case=TRUE)
coalSCC <- SCC[coal, ]$SCC
coalNEI <- NEI[NEI$SCC %in% coalSCC, ]

png("plot4.png", width=480, height=480)
ggplot(coalNEI, aes(x=factor(year), y=Emissions/1000)) +
  geom_bar(stat="identity", fill="gray40") +
  labs(title="Emissions from Coal Combustion-related Sources (1999–2008)",
       x="Year", y="Emissions (thousand tons)") +
  theme_minimal()
dev.off()