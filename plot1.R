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

#  code to create data plot 1 graphic
buildplot1 <- function() {
  hist(subsetData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red",breaks=13,xlim=c(0,6),ylim=c(0,1200))
  dev.copy(png,file="plot1.png",width=480,height=480)
  dev.off()
}  
