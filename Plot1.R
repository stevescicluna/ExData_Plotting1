# Zip file already downloaded into R working directory and unzipped

# Step 1: Load dplyr

library(dplyr)

# Step 2: Read in data from text file

epc <- read.table("household_power_consumption.txt", header= TRUE, na.strings= "?", sep= ";")

# Step 3: Create data subset based on two days data - 1/2/2007 and 2/2/2007

plot1data <- epc[(epc$Date=="1/2/2007" | epc$Date=="2/2/2007" ), ]

# Step 4: Create red histrogram of Global_active_power, with title and axis labels as specified

hist(plot1data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Step 5: Export to 480 x 480 .png file in working directory

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()