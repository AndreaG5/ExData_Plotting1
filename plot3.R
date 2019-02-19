## Creating df
uci <- read.table("./household_power_consumption.txt", sep = ";", dec = ".", col.names = c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3"), skip = 1)

## Subset
uci2 <- subset(uci, uci$date == "1/2/2007" | uci$date == "2/2/2007")
uci2$global_active_power <- gsub(",", ".", uci2$global_active_power)

uci2$date <- as.Date(uci2$date, format = "%d/%m/%Y")
uci2$time <- strptime(uci2$time, format = "%H:%M:%S")

uci2[1:1440, "time"] <- format(uci2[1:1440, "time"], "2007-02-01 %H:%M:%S")
uci2[1441:2880, "time"] <- format(uci2[1441:2880, "time"], "2007-02-02 %H:%M:%S")



## Plotting
plot(uci2$time, as.numeric(as.character(uci2$sub_metering_1)), type = "l", ylab= "Energy sub metering", xlab= "")
with(uci2, lines(time, as.numeric(as.character(uci2$sub_metering_2)), type = "l", col = "red"))
with(uci2, lines(time, as.numeric(as.character(uci2$sub_metering_3)), type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("sub_metering1", "sub_metering2", "sub_metering3"))
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()
