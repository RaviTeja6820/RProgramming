vehi <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehi, "SCC"]
vehiclesNEI <- NEI[NEI[, "SCC"] %in% vehiclesSCC,]

baltimoreVehiclesNEI <- vehiclesNEI[with(vehiclesNEI,fips=="24510"),]
baltimoreVehiclesNEI$city = "Baltimore"
LACVehiclesNEI <- vehiclesNEI[with(vehiclesNEI,fips=="06037"),]
LACVehiclesNEI$city = "Los Angeles"

bothNEI <- rbind(baltimoreVehiclesNEI,LACVehiclesNEI)

png("plot6.png")

g <- ggplot(bothNEI,aes(x = factor(year),y = Emissions, fill = city))

g  + geom_bar(aes(fill = year),stat = "identity") + facet_grid(.~city)+ labs(x = "year", y = "Total PM-2.5 Emission (Kilo-Tons)")  + labs(title = "PM-2.5 MotorVehicle Source Emissions in Baltimore and LA from 1999-2008")

dev.off()