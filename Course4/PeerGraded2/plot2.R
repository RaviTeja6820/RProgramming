totalNEI <- tapply(NEI[with(NEI, fips == 24510),]$Emissions, NEI[with(NEI, fips == 24510),]$year, sum)

png(filename='plot2.png')

barplot(totalNEI, names = names(totalNEI)
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()