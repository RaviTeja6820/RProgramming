#Obtain Data
epc <- fread(file = "./household_power_consumption.txt", header = TRUE, na.strings = "?")

#Filter data based in the date range
dtf <- with(epc, (dmy(Date) == ymd("2007-02-01")) | (dmy(Date) == ymd("2007-02-02")))
filepc <- epc[dtf]

#Assign size and Graphic display to png
png("plot4.png", width=480, height=480)

#create blocks in display
par(mfrow=c(2,2))

#create DateTime column to create graphs
filepc <- mutate(filepc, dateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))
filepc <- data.table(filepc)

# Plot graph

# Plot 1
plot(filepc[, dateTime], filepc[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(filepc[, dateTime],filepc[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(filepc[, dateTime], filepc[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(filepc[, dateTime], filepc[, Sub_metering_2], col = "red")
lines(filepc[, dateTime], filepc[, Sub_metering_3], col = "blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

#Plot4
plot(filepc[, dateTime], filepc[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

#close png
dev.off()