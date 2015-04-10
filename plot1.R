mydata <- "household_power_consumption.txt"
myfile <- file(mydata)
library(sqldf)

mydf <- sqldf("select * from myfile where Date in ('1/2/2007','2/2/2007')",
              file.format=list(header=TRUE, sep = ";"))
close(myfile)

mydf$DateTime <- paste(mydf$Date,mydf$Time)
mydf$DateTime <- strptime(mydf$DateTime,"%d/%m/%Y %H:%M:%S")

png(filename = "plot1.png", width = 480, height = 480, units = "px", 
    pointsize = 12,bg="white")

hist(mydf$Global_active_power, col="red",xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
