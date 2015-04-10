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

png(filename = "plot2.png", width = 480, height = 480, units = "px", 
    pointsize = 12,bg="white")

# Plot the graph as required
plot(mydf$DateTime, mydf$Global_active_power, xlab = "", 
     ylab = "Global Active Power (kilowatts)", type = "l")

# Close the device/ file
dev.off()
