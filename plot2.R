# Construct a plot to show total emissions from PM2.5 decreased in US 
#  from 1999 to 2008 in Baltimore City, Maryland.

library(dplyr)

plotfile <- "plot2.png"

nei <- readRDS("../data/summarySCC_PM25.rds")

# Baltimore City (fips == "24510")
bc_nei <- subset(nei, fips == "24510")

year_emission <- with(bc_nei, tapply(Emissions, year, sum))

# Create the plot and output to png file
png(plotfile, width=480, height=480, units = "px")

plot(names(year_emission), log10(year_emission), pch=20, xlab="Year", ylab="Total Emissions (log10)", main="Total Emissions for PM2.5 in Baltimore City, Maryland")
lines(names(year_emission), log10(year_emission), type="l")

dev.off()