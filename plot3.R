library(dplyr)
library(ggplot2)

source("readData.R")

plotfile <- "plot3.png"

nei <- readNEIData()

# Baltimore City, Maryland
bc_nei <- filter(nei, fips == "24510")

by_year_type <- group_by(bc_nei, year, type)
total_emission <- summarise(by_year_type, emission = sum(Emissions))

# Create the plot and output to png file
png(plotfile, width=480, height=480, units = "px")

with(total_emission, qplot(year, emission, geom=c("point", "line"), color=type, 
                           xlab="Year", ylab="Emissions", 
                           main="Annual emission by type in Baltimore City, Maryland"))

dev.off()