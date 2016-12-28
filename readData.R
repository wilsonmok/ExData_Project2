#ReadNEIData
readNEIData <- function() {
    readRDS("../data/summarySCC_PM25.rds")
}

readSCCData <- function() {
    readRDS("../data/Source_Classification_Code.rds")
}