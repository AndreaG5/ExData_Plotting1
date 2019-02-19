filename <- "exdata_data.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
    fileURL <- " https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip "
    download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI Dataset")) { 
    unzip(filename) 
}

## Creating df
uci <- read.table("./household_power_consumption.txt", sep = ";", col.names = c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3"), skip = 1)

## Subset
uci2 <- subset(uci, uci$date == "1/2/2007" | uci$date == "2/2/2007")
uci2$global_active_power <- gsub(",", ".", uci2$global_active_power)

## Creating plot
hist(as.numeric(uci2$global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()
