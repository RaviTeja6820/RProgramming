vehi <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehi, "SCC"]
vehiclesNEI <- NEI[NEI[, "SCC"] %in% vehiclesSCC,]

baltimoreVehiclesNEI <- vehiclesNEI[with(vehiclesNEI,fips=="24510", na.rm = TRUE),]

png("plot5.png")

g <- ggplot(baltimoreVehiclesNEI,aes(x = factor(year),y = Emissions))

g  + geom_bar(stat = "identity", width = 0.75) + labs(x = "year", y = "Total PM-2.5 Emission (Tons)")  + labs(title = "PM-2.5 MotorVehicle Source Emissions in Baltimore from 1999-2008")

dev.off()