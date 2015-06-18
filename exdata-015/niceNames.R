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
