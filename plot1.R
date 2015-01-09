# Exploratory Data Analysis Plot Assignment 1
# PLOT NUMBER 1

# Open the file
png(filename = "plot1.png", width=480, height=480)

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

# Global Active Power Histogram 
hist(plotdata$Global_active_power, xlab="Global Active Power (kilowatts)",
     col="red", main="Global Active Power", cex.lab=0.75, cex.axis=0.75)

# Close the device
dev.off()
