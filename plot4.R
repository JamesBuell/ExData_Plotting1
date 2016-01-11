# this loads the dplyr library so that its functions can be used
library(dplyr)
# this reads the full contents of the "household_power_consumption.txt" file into 'data'
data <- read.table("household_power_consumption.txt",header=TRUE,sep=";", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),na.strings="?")

# filtering pulls out just those 2880 rows from Feb 1 and 2 2007 
subsetData <- filter(data,Date=="1/2/2007" | Date=="2/2/2007")

# this creates a 'cc' combined column variable with date and time values
subsetData$cc <- paste(as.Date(subsetData$Date, format="%d/%m/%Y"),subsetData$Time, sep = " ")
# this changes the variable type for to "POSIXlt" "POSIXt" so the graphs can get made
subsetData$cc <- as.POSIXct(subsetData$cc, format="%Y-%m-%d %H:%M:%S")

# code to create data plot 4 graphic
buildplot4 <- function() {
  par (mfrow=c(2,2))
  #1st plot
  plot(subsetData$cc,subsetData$Global_active_power,type="l", xlab="", ylab="Global Active Power")
  #2nd plot
  plot(subsetData$cc,subsetData$Voltage,type="l", xlab="datetime", ylab="Voltage")
  #3rd plot
  plot(subsetData$cc,subsetData$Sub_metering_1,type="l", xlab="", ylab="Energy sub metering")
  lines(subsetData$Sub_metering_2,col="red")
  lines(subsetData$Sub_metering_3,col="blue")
  legend("topright",col=c("black","red","blue"),c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=c(1,1),bty="n",cex=.5)
  #4th plot
  plot(subsetData$cc,subsetData$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
  dev.copy (png,file="plot4.png",width=480,height=480)
  dev.off()
}