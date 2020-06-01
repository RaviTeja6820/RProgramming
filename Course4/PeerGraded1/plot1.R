#Obtain Data
epc <- fread(file = "./household_power_consumption.txt", header = TRUE, na.strings = "?")

#Filter data based in the date range
dtf <- with(epc, (dmy(Date) == ymd("2007-02-01")) | (dmy(Date) == ymd("2007-02-02")))
filepc <- epc[dtf]

#Assign size and Graphic display to png
png("plot1.png", width=480, height=480)

#Create Histogram
hist(as.numeric(filepc[, Global_active_power]), main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

#close png
dev.off()