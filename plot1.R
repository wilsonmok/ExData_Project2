# Construct a plot to show total emissions from PM2.5 decreased in US 
#  from 1999 to 2008.

library(dplyr)

plotfile <- "plot1.png"

nei <- readRDS("../data/summarySCC_PM25.rds")

year_emission <- with(nei, tapply(Emissions, year, sum))

# Create the plot and output to png file
png(plotfile, width=480, height=480, units = "px")

plot(names(year_emission), log10(year_emission), pch=20, xlab="Year", ylab="Total Emissions (log10)", main="Total Emissions for PM2.5")
lines(names(year_emission), log10(year_emission), type="l")


dev.off()