# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

if(file.exists("summarySCC_PM25.rds")) {
    summary <- readRDS("summarySCC_PM25.rds")
} else {
    stop("summarySCC_PM25.rds does not exist")
}
byYear <- aggregate(summary$Emissions, by=list(summary$year), FUN=sum)
names(byYear) <- c("Year", "Total Emissions")

png("plot1.png", width = 480, height = 480, units = "px")
plot(byYear, type="l", main="Total PM2.5 emissions in USA between 1999 and 2008")
dev.off()
