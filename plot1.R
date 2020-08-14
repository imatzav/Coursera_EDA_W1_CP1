install.packages("readr")
library(readr)
hpc <- read_delim("household_power_consumption.txt", 
                  ";", 
                  escape_double = FALSE, 
                  col_types = cols(Date = col_date(format = "%d/%m/%Y"), 
                                   Time = col_time(format = "%H:%M:%S")), 
                  trim_ws = TRUE)

head(hpc)

hpc2d <- hpc[which(hpc$Date=="2007-02-01" | hpc$Date=="2007-02-02"),]


# alternatively 
# hpc2d <- subset(hpc,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

hist(hpc2d$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency")

# Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
