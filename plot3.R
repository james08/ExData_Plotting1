## This script assumes dataset file is in the current working directory.

library(lubridate)
library(dplyr)

## Read in data from file
consump <- read.csv("household_power_consumption.txt", sep = ";", 
                    stringsAsFactors = FALSE, as.is = c(3:9), na.strings = "?")

## Convert to tbl_df for dplyr and remove original
consum <- tbl_df(consump)
rm(consump)

## Add date_time column
consum1 <- mutate(consum, date_time = dmy_hms(paste(consum$Date, consum$Time)))
consum1 <- mutate(consum, date = dmy(consum$Date))
consum2 <- consum1[consum1$date == ymd("2007-02-01"),]
consum2 <- rbind(consum2, consum1[consum1$date == ymd("2007-02-02"),])
consum2 <- mutate(consum2, date_time = dmy_hms(paste(consum2$Date, consum2$Time)))

##plot3
png(filename = "plot3.png", width = 480, height = 480)
with(consum2, plot(date_time, Sub_metering_1, type = "l", 
                   xlab = "", ylab = "Energy sub metering"))
with(consum2, lines(date_time, Sub_metering_2, col="red"))
with(consum2, lines(date_time, Sub_metering_3, col="blue"))

legend("topright", lwd = 2, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
