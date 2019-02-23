# Zip file already downloaded into R working directory and unzipped

# Step 1: Load dplyr

library(dplyr)

# Step 2: Read in data from text file

epc <- read.table("household_power_consumption.txt", header= TRUE, na.strings= "?", sep= ";")

# Step 3: Create data subset based on two days data - 1/2/2007 and 2/2/2007

plot2data <- epc[(epc$Date=="1/2/2007" | epc$Date=="2/2/2007" ), ]

# Step 4: Format date column, combine with time to form 'datetime' value coerced into date format

plot2data$Date <- as.Date(plot2data$Date, format="%d/%m/%Y")
plot2datetime <- paste(plot2data$Date, plot2data$Time)
plot2data$plot2datetime <- as.POSIXct(plot2datetime)

# Step 5: Create time series plot of Global_active_power by datetime, with title and axis labels as specified

plot(plot2data$Global_active_power~plot2data$plot2datetime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Step 6: Export to 480 x 480 .png file in working directory

dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()