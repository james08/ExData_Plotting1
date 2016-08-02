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

## plot 2
png(filename = "plot2.png", width = 480, height = 480)
with(consum2, plot(date_time, Global_active_power, type = "l", 
                   xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
