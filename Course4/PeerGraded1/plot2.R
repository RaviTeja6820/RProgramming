#Obtain Data
epc <- fread(file = "./household_power_consumption.txt", header = TRUE, na.strings = "?")

#Filter data based in the date range
dtf <- with(epc, (dmy(Date) == ymd("2007-02-01")) | (dmy(Date) == ymd("2007-02-02")))
filepc <- epc[dtf]

#Assign size and Graphic display to png
png("plot2.png", width=480, height=480)

#create DateTime column to create graphs
filepc <- mutate(filepc, dateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))
filepc <- data.table(filepc)

#plot graph
plot(x = filepc[, dateTime], y = filepc[, Global_active_power], xlab="", ylab="Global Active Power (kilowatts)", type = "l")

#close png
dev.off()