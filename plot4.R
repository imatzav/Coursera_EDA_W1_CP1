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


par(mfcol=c(2,2), mar = c(4,4,2,2), oma = c(0,0,0,0), mgp=c(3, 1, 0))
with(hpc2d, {
  plot(Global_active_power ~ datetime, type="l", xlab="", ylab="Global Active Power")
  
  plot(Sub_metering_1 ~ datetime, type="l", xlab="", ylab="Energy sub metering")
  lines(hpc2d$Sub_metering_2 ~ datetime, col="red")
  lines(hpc2d$Sub_metering_3 ~ datetime, col="blue")
  legend(x=median(datetime)-40000, y=40, col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
  #abline(v=median(datetime))
  
  plot(Voltage ~ datetime, type="l", ylab="Voltage", xlab="datetime")
  
  plot(Global_reactive_power ~ datetime, type="l", xlab="datetime")
})

# Save file and close device
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
