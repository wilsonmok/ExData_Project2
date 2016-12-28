# Create a plot to show the motor vehicle emissions changes between
#  Baltimore City and Los Aneles County between year 1999 and 2008.
# Which city has seen greater changes over time?

library(dplyr)
library(ggplot2)

plotfile <- "plot6.png"

nei <- readRDS("../data/summarySCC_PM25.rds")

# filter nei data to (Baltimore City or Los Angeles County) and type=="ON-ROAD"
# - Baltimore City (fips=="24510")
# - Los Angeles County (fips=="06037")

fips_county_df <- data_frame(fips=c("06037", "24510"), 
                           county=c("Los Angeles County", "Baltimore City"))

nei_vehical <- filter(nei, fips %in% fips_county_df$fips  & type=="ON-ROAD")

# Get annual emission for each location
nei_year_fips <- group_by(nei_vehical, year, fips)
total_emission <- summarise(nei_year_fips, emission = sum(Emissions))

total_emission_county <- inner_join(total_emission, fips_county_df, by="fips") %>%
    transform(year = as.factor(year)) %>%
    transform(county = as.factor(county))

png(plotfile, width=480, height=480, units = "px")

ggplot(total_emission_county, aes(x=year, y=emission, fill=county)) +
    facet_grid(county ~ ., scale="free") + 
    geom_bar(stat="identity") + 
    labs(x="Year", y="Emission", title="Annual motor vehicle emission between counties")

dev.off()