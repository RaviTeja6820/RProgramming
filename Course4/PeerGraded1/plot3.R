#Obtain Data
epc <- fread(file = "./household_power_consumption.txt", header = TRUE, na.strings = "?")

#Filter data based in the date range
dtf <- with(epc, (dmy(Date) == ymd("2007-02-01")) | (dmy(Date) == ymd("2007-02-02")))
filepc <- epc[dtf]

#Assign size and Graphic display to png
png("plot3.png", width=480, height=480)

#create DateTime column to create graphs
filepc <- mutate(filepc, dateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))
filepc <- data.table(filepc)

#plot graph
plot(filepc[, dateTime], filepc[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(filepc[, dateTime], filepc[, Sub_metering_2], col = "red")
lines(filepc[, dateTime], filepc[, Sub_metering_3], col = "blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

#close png
dev.off()