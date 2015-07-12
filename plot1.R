fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./household.zip", method="curl")
dateDownloaded  <- date()
unzip("household.zip")

electricity <- read.table("household_power_consumption.txt", nrows=100000, header=T, sep=";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
electricity$D <- as.POSIXct(strptime(paste(electricity$Date, electricity$Time), "%d/%m/%Y %H:%M:%S"))

sub <- electricity[electricity$Date == "1/2/2007" | electricity$Date == "2/2/2007", ]

png(file="plot1.png", width = 480, height = 480)
hist(sub$Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()