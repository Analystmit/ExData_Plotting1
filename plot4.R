fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./household.zip", method="curl")
dateDownloaded  <- date()
unzip("household.zip")
electricity <- read.table("household_power_consumption.txt", nrows=100000, header=T, sep=";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
electricity$D <- as.POSIXct(strptime(paste(electricity$Date, electricity$Time), "%d/%m/%Y %H:%M:%S"))
sub <- electricity[electricity$Date == "1/2/2007" | electricity$Date == "2/2/2007", ]

png(file="plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))
#Plot1
plot(sub$D, sub$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Plot 2
plot(sub$D, sub$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Plot 3
plot(sub$D, sub$Sub_metering_1,type="l", xlab="", ylab="Energy Sub Metering")
lines(sub$D, sub$Sub_metering_2, col="red")
lines(sub$D, sub$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=1:3, bty = "n", lty=1)

#Plot 4
plot(sub$D, sub$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
