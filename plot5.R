if(file.exists("Source_Classification_Code.rds")) {
    classificationCodes <- readRDS("Source_Classification_Code.rds")
} else {
    stop("Source_Classification_Code.rds does not exist")
}

if(file.exists("summarySCC_PM25.rds")) {
    summary <- readRDS("summarySCC_PM25.rds")
} else {
    stop("summarySCC_PM25.rds does not exist")
}

summaryBaltimoreCity <- summary[summary$fips == "24510",]
summaryWithNiceTypes <- merge(summaryBaltimoreCity, classificationCodes)

onlyMobileSources <- summaryWithNiceTypes[summaryWithNiceTypes$SCC.Level.One == "Mobile Sources",]


byYear <- aggregate(onlyMobileSources$Emissions, by=list(onlyMobileSources$year), FUN=sum)
names(byYear) <- c("Year", "Total Emissions")

png("plot5.png", width = 480, height = 480, units = "px")
plot(byYear, type="l", main="Total moter vechicle PM2.5 emissions in Baltimore City between 1999 and 2008")
dev.off()
