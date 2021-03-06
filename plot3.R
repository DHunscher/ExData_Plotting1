##
### Exploratory Data Analysis
#
# Project 1
#
# Plot #3
#
# Assumes data set is in the folder specified in the argument to doPlot3(),
# the argument being the working directory for the program run. The output
# file, plot3.png, will be found in that directory when the run is complete.

# turn off advisory warning message for use of POSIX datetimes in data.tables

options(warn=-1)

library(data.table)
library(dplyr)


doPlot3 <- function (workingDirectory = "~/Box Sync/Coursera-data-science/datasciencecoursera/Exploratory_Data_Analysis/Project1") {
        if (file_test("-d", workingDirectory) != TRUE) {
                stop(sprintf("%s is not accessible as a directory.", workingDirectory))
        }
        # constant(s)
        fmt = "%d/%m/%Y %H:%M:%S"

        # set working directory
        setwd(workingDirectory)
        if ( file_test("-f","household_power_consumption.txt") != TRUE) {
                stop(sprintf("household_power_consumption.txt is not present in %s",getwd()))
        }
        # load the data
        dt <- data.table(read.table("household_power_consumption.txt",
                                    na.strings=c("?"),
                                    colClasses=c("character","character","numeric",
                                                 "numeric","numeric","numeric",
                                                 "numeric","numeric","numeric"),
                                    header=TRUE,
                                    sep=";"))
        # subset to the required days
        dt <- subset(dt, Date == "1/2/2007" | Date == "2/2/2007")
        posixDTs <- paste(dt$Date,dt$Time)
        posixDTs <- strptime(posixDTs, fmt)
        dt2 <- transform(dt, DateTime = posixDTs)
        # open the png device
        png("plot3.png")
        # draw the plot
        plot(dt2$DateTime, 
             dt2$Sub_metering_1,
             type="l",
             xlab="",
             ylab="Energy sub metering")
        points(dt2$DateTime, 
             dt2$Sub_metering_2,
             type="l",
             col="red")
        points(dt2$DateTime, 
             dt2$Sub_metering_3,
             type="l",
             col="blue")
        legend("topright",
               legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               col=c("black","blue","red"),
               lwd=1,
               cex=0.8)

        # close device
        dev.off()
        # return a message
        return("operation complete!")
}
