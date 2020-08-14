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

datetime <- paste(hpc2d$Date, hpc2d$Time)
datetime <- as.POSIXct(datetime)
hpc2d <- cbind(hpc2d, datetime)

# The plot goes here.....

# Save file and close device
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

