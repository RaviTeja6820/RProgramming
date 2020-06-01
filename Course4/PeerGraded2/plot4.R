comb <- grep("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grep("coal", SCC$SCC.Level.Four, ignore.case=TRUE)
coalcombustionSCC <- SCC[c(coal, comb), "SCC"]
coalcombustionNEI <- NEI[NEI[, "SCC"] %in% coalcombustionSCC,]

png("plot4.png")

g <- ggplot(coalcombustionNEI,aes(x = factor(year),y = Emissions/10^5))

g  + geom_bar(stat = "identity", width = 0.5) + labs(x = "year", y = "Total PM-2.5 Emission (Tons)")  + labs(title = "PM-2.5 Coal Combustion Source Emissions Across US from 1999-2008")

dev.off()