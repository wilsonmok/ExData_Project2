# Create a plot to show coal combustion-related emission have changes in US
#  from 1999-2008

library(dplyr)
library(ggplot2)

plotfile <- "plot4.png"

nei <- readRDS("../data/summarySCC_PM25.rds")
scc <- readRDS("../data/Source_Classification_Code.rds")

# filter to include coal combustion-related SCC
scc_comb_coal <- filter(scc,grepl("Comb.+Coal", EI.Sector))

nei_comb_coal <- filter(nei, SCC %in% scc_comb_coal$SCC)

nei_year_type <- group_by(nei_comb_coal, year, type)
total_coal_emission <- summarise(nei_year_type, emission = sum(Emissions))
total_coal_emission <- transform(total_coal_emission, type = as.factor(type))

png(plotfile, width=480, height=480, units = "px")

with(total_coal_emission, qplot(year, log10(emission), geom=c("point", "line"),
                                color=type, xlab="Year", ylab="Emissions (log10)", 
                                main="Annual coal combustion-related emission"))

dev.off()