baltimoreNEI <- NEI[with(NEI, fips == 24510),]

png("plot3.png")

g <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type))

g  + geom_bar(stat = "identity") + facet_grid(.~type) + labs(x = "year", y = "Total PM-2.5 Emission (Tons)")  + labs(title = "PM-2.5 Emission, Baltimore City 1998 - 2008 by Source Type")

dev.off()