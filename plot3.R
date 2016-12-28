# Construct a plot to show each type of emission source from 1999 to 2008
#  in Baltimore City.  The plot should show which emission type has increased
#  and which has decreased.

library(dplyr)
library(ggplot2)

plotfile <- "plot3.png"

nei <- readRDS("../data/summarySCC_PM25.rds")

# Baltimore City, Maryland
bc_nei <- filter(nei, fips == "24510")

# summarise the data by year and emission type
by_year_type <- group_by(bc_nei, year, type)
total_emission <- summarise(by_year_type, emission = sum(Emissions))

# Create the plot and output to png file
png(plotfile, width=480, height=480, units = "px")

with(total_emission, qplot(year, emission, geom=c("point", "line"), color=type, 
                           xlab="Year", ylab="Emissions", 
                           main="Annual emission by type in Baltimore City, Maryland"))

dev.off()