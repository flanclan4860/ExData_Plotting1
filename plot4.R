# Exploratory Data Analysis Plot Assignment 1
# PLOT NUMBER 4

# Open the file
png(filename = "plot4.png", width=480, height=480)

# Read first 5 rows of file to get colClasses
first5rows <- read.table("household_power_consumption.txt", header = TRUE, sep=";", 
                         nrows = 5)
classes <- sapply(first5rows, class)

# Read the file
DT <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                 na.strings = "?", colClasses=classes)

# Convert date, time to POSIXlt
DT$DateTime <- paste(DT$Date, DT$Time)
DT$DateTime <- strptime(DT$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Subset for 2 day period 2/1 -2/2/2007
date1 <- strptime("2007-02-01", "%Y-%m-%d")
date2 <- strptime("2007-02-03", "%Y-%m-%d")
plotdata <- na.omit(DT[(DT$DateTime >= date1) & (DT$DateTime < date2), ])

# Set up for 4 plots, 2 rows, 2columns
par(mfrow = c(2,2))

# Global Active Power Line Plot
plot(x=plotdata$DateTime, y=plotdata$Global_active_power, type="l", 
     ylab="Global Active Power", xlab="")

# Voltage Line Plot
plot(x=plotdata$DateTime, y=plotdata$Voltage, type="l", 
     ylab="Voltage", xlab="datetime")

# Sub-metering 1, 2, and 3 Line Plots with a legend
plot(x=plotdata$DateTime, y=plotdata$Sub_metering_1, type="l", 
     ylab="Energy Sub Metering", xlab="", cex.lab=0.75)

lines(x=plotdata$DateTime, y=plotdata$Sub_metering_2, col="red")
lines(x=plotdata$DateTime, y=plotdata$Sub_metering_3, col="blue")

legend("topright", lty=c(1, 1, 1), col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n")

# Global Reactive Power Line Plot
plot(x=plotdata$DateTime, y=plotdata$Global_reactive_power, type="l", 
     ylab="Global_reactive_power", xlab="datetime")

# Close plot device
dev.off()
