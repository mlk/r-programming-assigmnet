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

summaryWithNiceTypes <- merge(summary, classificationCodes)

onlyCoal <- summaryWithNiceTypes[grep("Coal", summaryWithNiceTypes$Short.Name),]


byYear <- aggregate(onlyCoal$Emissions, by=list(onlyCoal$year), FUN=sum)
names(byYear) <- c("Year", "Total Emissions")

png("plot4.png", width = 480, height = 480, units = "px")
plot(byYear, type="l", main="Total Coal PM2.5 emissions in USA between 1999 and 2008")
dev.off()
