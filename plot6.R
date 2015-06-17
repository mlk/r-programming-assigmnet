library(ggplot2)

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
summaryOfBCWithNiceTypes <- merge(summaryBaltimoreCity, classificationCodes)
onlyMobileSourcesOfBC <- summaryOfBCWithNiceTypes[summaryOfBCWithNiceTypes$SCC.Level.One == "Mobile Sources",]
byYearForBc <- aggregate(onlyMobileSourcesOfBC$Emissions, by=list(onlyMobileSourcesOfBC$year), FUN=sum)
names(byYearForBc) <- c("Year", "TotalEmissions")

summaryLosAngeles <- summary[summary$fips == "06037",]
summaryOfLosAngelesWithNiceTypes <- merge(summaryLosAngeles, classificationCodes)
onlyMobileSourcesOfLA <- summaryOfLosAngelesWithNiceTypes[summaryOfLosAngelesWithNiceTypes$SCC.Level.One == "Mobile Sources",]
byYearForLA <- aggregate(onlyMobileSourcesOfLA$Emissions, by=list(onlyMobileSourcesOfLA$year), FUN=sum)
names(byYearForLA) <- c("Year", "TotalEmissions")

byYearForBc$Location <- "Baltimore City"
byYearForLA$Location <- "Los Angeles County"

byYear = rbind(byYearForBc, byYearForLA)

png("plot5.png", width = 480, height = 480, units = "px")
ggplot(byYear, aes(x=Year, y=TotalEmissions, col=Location)) + geom_line()
dev.off()