##
### Exploratory Data Analysis
#
# Project 1
#
# Plot #1
#
# Assumes data set is in the folder specified in the argument to doPlot1(),
# the argument being the working directory for the program run. The output
# file, plot1.png, will be found in that directory when the run is complete.

# turn off advisory warning message for use of POSIX datetimes in data.tables

options(warn=-1)

library(data.table)
library(dplyr)


doPlot1 <- function (workingDirectory = "~/Box Sync/Coursera-data-science/datasciencecoursera/Exploratory_Data_Analysis/Project1") {
        if (file_test("-d", workingDirectory) != TRUE) {
                stop(sprintf("%s is not accessible as a directory.", workingDirectory))
        }
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
        # open the png device
        png("plot1.png")
        # draw the histogram
        hist(dt$Global_active_power,
             breaks=12,
             col="red",
             main="Global Active Power",
             xlab="Global Active Power (kilowatts)")
        # close device
        dev.off()
        # return a message
        return("operation complete!")
}
