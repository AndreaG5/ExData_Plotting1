## Creating df
uci <- read.table("./household_power_consumption.txt", sep = ";", col.names = c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3"), skip = 1)

## Subset
uci2 <- subset(uci, uci$date == "1/2/2007" | uci$date == "2/2/2007")
uci2$global_active_power <- gsub(",", ".", uci2$global_active_power)

uci2$date <- as.Date(uci2$date, format = "%d/%m/%Y")
uci2$time <- strptime(uci2$time, format = "%H:%M:%S")

uci2[1:1440, "time"] <- format(uci2[1:1440, "time"], "2007-02-01 %H:%M:%S")
uci2[1441:2880, "time"] <- format(uci2[1441:2880, "time"], "2007-02-02 %H:%M:%S")

## Creating plot
plot(uci2$time, uci2$global_active_power, type = "l", ylab = "Global Active Power (Kilowatts)", xlab = "")
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()
