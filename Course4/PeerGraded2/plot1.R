totalNEI <- tapply(NEI$Emissions, NEI$year, sum) 

png(filename='plot1.png')

barplot(totalNEI, names = names(totalNEI)
        , xlab = "Years", ylab = "Emissions"
       , main = "Emissions over the Years")

dev.off()