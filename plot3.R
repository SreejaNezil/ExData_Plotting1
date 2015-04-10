# Read only the required data from the file
# First create a handle to the file and this can be used with sqldf-
# - in order to select only the required data

mydata <- "household_power_consumption.txt"
myfile <- file(mydata)
library(sqldf)

mydf <- sqldf("select * from myfile where Date in ('1/2/2007','2/2/2007')",
              file.format=list(header=TRUE, sep = ";"))
close(myfile)

# Create a new column in the data frame that combines both Date and Time 
# Then covert the new column to Date format using strptime

mydf$DateTime <- paste(mydf$Date,mydf$Time)
mydf$DateTime <- strptime(mydf$DateTime,"%d/%m/%Y %H:%M:%S")

#Create the file for plotting and set the size
png(filename = "plot3.png", width = 480, height = 480, units = "px", 
    pointsize = 12,bg="white")

# Format the plot area with only the axes
plot(x = mydf$DateTime, y= mydf$Sub_metering_1, type ="n", 
     xlab = "", ylab = "Energy sub metering")

# Add the legend to the plot area
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2" , "Sub_metering_3"),
       lty =1, col = c("black", "red", "blue"))

# Add 3 line grpahs for 3 columns of the data frame
with(mydf, lines(x = mydf$DateTime, y = mydf$Sub_metering_1, col ="black"))
with(mydf, lines(x = mydf$DateTime, y = mydf$Sub_metering_2, col ="red"))
with(mydf, lines(x = mydf$DateTime, y = mydf$Sub_metering_3, col ="blue"))

dev.off()
