# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

if(file.exists("summarySCC_PM25.rds")) {
    summary <- readRDS("summarySCC_PM25.rds")
} else {
    stop("summarySCC_PM25.rds does not exist")
}

summaryBaltimoreCity <- summary[summary$fips == "24510",]

byYear <- aggregate(summaryBaltimoreCity$Emissions, by=list(summaryBaltimoreCity$year), FUN=sum)
names(byYear) <- c("Year", "Total Emissions")

png("plot2.png", width = 480, height = 480, units = "px")
plot(byYear, type="l", main="Total PM2.5 emissions in Baltimore City between 1999 and 2008")
dev.off()
