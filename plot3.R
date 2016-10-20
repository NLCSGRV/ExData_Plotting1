## Set some options
options(scipen = 10)

## Save the working directory and set a new one

oldwd <- getwd()
wd <- "/Volumes/Main/github/ExData_Plotting1/" ## replace with your preferred working directory
setwd(wd) 

## Download the zipped data to the working directory and unzip

url <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
zipfile <- paste(wd,basename(url),sep="/")
if(!file.exists(zipfile)) {
   download.file(url, zipfile)
}

## Read the data from the zip file 
power_data <- read.table(
   unz(zipfile,filename="household_power_consumption.txt"), 
   header=TRUE, 
   sep=";", 
   dec=".",
   na.strings = "?",
   colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
)

## Combine date/time and subset data
power_data$Datetime <- strptime(paste(power_data$Date, power_data$Time), format="%d/%m/%Y %H:%M:%S")
power_data <- na.omit(
   power_data[power_data$Datetime >= "2007-02-01 00:00:00" & power_data$Datetime <= "2007-02-02 23:59:59",
   c("Datetime","Sub_metering_1","Sub_metering_2","Sub_metering_3")]
)

## Generate plot
with(power_data, {
   plot(Datetime,Sub_metering_1,type="l", xlab="",ylab="Energy sub metering")
   lines(Datetime,Sub_metering_2, col="red")
   lines(Datetime,Sub_metering_3, col="blue")
   legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","blue","red"),lwd=1)
})
## Save the plot, using default 480px width and height
dev.copy(png,"plot3.png")
dev.off()

## Remove the data and variables from the workspace
rm(list=c("power_data","url","wd","zipfile"))

## Set the working directory back to its previous path
setwd(oldwd)
rm(oldwd)
