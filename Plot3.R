# Zip file already downloaded into R working directory and unzipped

# Step 1: Load dplyr

library(dplyr)

# Step 2: Read in data from text file

epc <- read.table("household_power_consumption.txt", header= TRUE, na.strings= "?", sep= ";")

# Step 3: Create data subset based on two days data - 1/2/2007 and 2/2/2007

plot3data <- epc[(epc$Date=="1/2/2007" | epc$Date=="2/2/2007" ), ]

# Step 4: Format date column, combine with time to form 'datetime' value coerced into date format

plot3data$Date <- as.Date(plot3data$Date, format="%d/%m/%Y")
plot3datetime <- paste(plot3data$Date, plot3data$Time)
plot3data$plot3datetime <- as.POSIXct(plot3datetime)

# Step 5: Create three time series plot of Sub metering by datetime, with colours, title and axis labels as specified

with(plot3data, {
        plot(Sub_metering_1~plot3datetime, type="l", ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~plot3datetime, col='Red')
        lines(Sub_metering_3~plot3datetime, col='Blue')})

# Step 6: Add legend in top right corner
legend("topright",col=c("black","red","blue"),lty = 1, lwd = 1, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

# Step 7: Export to 480 x 480 .png file in working directory

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()