activityDT <- data.table::fread(input = "activity.csv")

total <- tapply(activityDT$steps, activityDT$date, sum)
date <- names(total)
steps <- data.frame(total)[[1]]
res <- data.frame(date, steps)
ggplot(res, aes(x = steps)) + geom_histogram(fill = "red", binwidth = 1000) + labs(title = "Steps per Day", x = "steps", y = "frequency")
mmi <- summary(res$steps, na.rm = TRUE)[c(3,4)]
mmi <- data.table(mmi[[1]], mmi[[2]])
colnames(mmi) <- c("Mean", "Median")

intervalDT <- activityDT[, lapply(.SD, mean, na.rm = TRUE), .SDcols = c("steps") ,by = .(interval)]
ggplot(intervalDT, aes(x = interval , y = steps)) + geom_line(color = "red", size = 0.2) + labs(title = "Average daily activity pattern", y = "Average Steps per Day")
intervalDT[steps == max(steps)]

activityDT[is.na(steps), .N]
med <- data.table(median(activityDT$steps, na.rm = TRUE))
colnames(med) <-c("steps")
activityDT[is.na(steps), "steps"] <- med
data.table::fwrite(activityDT, file = "cleanData.csv", quote = FALSE)

totalSteps <- activityDT[, lapply(.SD, sum), .SDcols = c("steps"), by = .(date)]
ggplot(totalSteps, aes(x = steps)) + geom_histogram(fill = "red", binwidth = 1000) + labs(title = "Steps per Day", x = "steps", y = "frequency")
mmf <- data.table(mean(totalSteps$steps), median(totalSteps$steps))
colnames(mmf) <- c("Mean", "Median")

activityDT$day <- weekdays(as.Date(activityDT$date, format = "%Y-%m-%d"))
activityDT$weekendorday <- "weekday"
activityDT[grep("Saturday|Sunday", activityDT$day)]$weekendorday <- "weekend"
activityDT$weekendorday <- as.factor(activityDT$weekendorday)

intervalDT <- activityDT[, lapply(.SD, mean, na.rm = TRUE), .SDcols = c("steps") ,by = .(interval, weekendorday)]
intervalDT[steps == max(steps)]ggplot(intervalDT, aes(x = interval , y = steps, col = weekendorday)) + geom_line(size = 0.05) + labs(title = "Average daily activity pattern by weekend or weekday", y = "Average Steps per Day") + facet_wrap(facets = .~weekendorday, ncol = 1)