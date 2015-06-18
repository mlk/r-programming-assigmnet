# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

if(file.exists("summarySCC_PM25.rds")) {
    summary <- readRDS("summarySCC_PM25.rds")
} else {
    stop("summarySCC_PM25.rds does not exist")
}

summaryBaltimoreCity <- summary[summary$fips == "24510",]
byYearByType <- aggregate(summaryBaltimoreCity$Emissions, by=list(summaryBaltimoreCity$year, summaryBaltimoreCity$type), FUN=sum)
names(byYearByType) <- c("Year", "Type", "TotalEmissions")

png("plot3.png", width = 480, height = 480, units = "px")
ggplot(byYearByType, aes(x=Year, y=TotalEmissions, col=Type)) + geom_line()
dev.off()
