library(dplyr)
library(ggplot2)

plotfile <- "plot5.png"

nei <- readRDS("../data/summarySCC_PM25.rds")

# filter to include Baltimore City (fips=="24510") and type=ON-ROAD
nei_vehical <- filter(nei, fips=="24510" & type=="ON-ROAD")

nei_year <- group_by(nei_vehical, year)
total_emission <- summarise(nei_year, emission = sum(Emissions))

png(plotfile, width=480, height=480, units = "px")

with(total_emission, qplot(year, emission, geom=c("point", "line"),
                                xlab="Year", ylab="Emissions", 
                                main="Annual motor vehicle emission in Baltimore City"))

dev.off()