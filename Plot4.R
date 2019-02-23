# Zip file already downloaded into R working directory and unzipped

# Step 1: Load dplyr

library(dplyr)

# Step 2: Read in data from text file

epc <- read.table("household_power_consumption.txt", header= TRUE, na.strings= "?", sep= ";")

# Step 3: Create data subset based on two days data - 1/2/2007 and 2/2/2007

plot4data <- epc[(epc$Date=="1/2/2007" | epc$Date=="2/2/2007" ), ]

# Step 4: Format date column, combine with time to form 'datetime' value coerced into date format

plot4data$Date <- as.Date(plot4data$Date, format="%d/%m/%Y")
plot4datetime <- paste(plot4data$Date, plot4data$Time)
plot4data$plot4datetime <- as.POSIXct(plot4datetime)

# Step 4: Set up a 2x2 view of four graphs

par(mfrow = c(2,2))

# Step 5: Create top-left graph (same as plot 2, different ylab)

plot(plot4data$Global_active_power~plot4data$plot4datetime, type = "l", xlab = "", ylab = "Global Active Power")

# Step 6: Create top-right graph (similar to plot 2, but using voltage)

plot(plot4data$Voltage~plot4data$plot4datetime, type = "l", xlab = "datetime", ylab = "Voltage")

#Step 6: Create bottom-left graph (same as plot 3)

with(plot4data, {
        plot(Sub_metering_1~plot4datetime, type="l", ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~plot4datetime, col='Red')
        lines(Sub_metering_3~plot4datetime, col='Blue')
        legend("topright",col=c("black","red","blue"),lty = 1, lwd = 1, bty = "n", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), cex = 0.5)})

# Step 7: Create bottom-right graph (same as top-right, but with Global_reactive_power)

plot(plot4data$Global_reactive_power~plot4data$plot4datetime, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Step 8: Export to 480 x 480 .png file in working directory

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()