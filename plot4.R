
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


## Set plotting environment to do 2 x 2 plots

par(mfrow=c(2,2))

## Generate plot 1

plot_data <- na.omit(
   power_data[power_data$Datetime >= "2007-02-01 00:00:00" & power_data$Datetime <= "2007-02-02 23:59:59",
              c("Datetime","Global_active_power")]
)

plot(plot_data$Datetime,plot_data$Global_active_power,type="l", xlab="",ylab="Global Active Power")

## Generate plot 2

plot_data <- na.omit(
   power_data[power_data$Datetime >= "2007-02-01 00:00:00" & power_data$Datetime <= "2007-02-02 23:59:59",
              c("Datetime","Voltage")]
)

plot(plot_data$Datetime,plot_data$Voltage,type="l", xlab="datetime",ylab="Voltage")

## Generate plot 3

plot_data <- na.omit(
   power_data[power_data$Datetime >= "2007-02-01 00:00:00" & power_data$Datetime <= "2007-02-02 23:59:59",
              c("Datetime","Sub_metering_1","Sub_metering_2","Sub_metering_3")]
)

with(plot_data, {
   plot(Datetime,Sub_metering_1,type="l", xlab="",ylab="Energy sub metering")
   lines(Datetime,Sub_metering_2, col="red")
   lines(Datetime,Sub_metering_3, col="blue")
   legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","blue","red"),lwd=1)
})

## Generate plot 4


plot_data <- na.omit(
   power_data[power_data$Datetime >= "2007-02-01 00:00:00" & power_data$Datetime <= "2007-02-02 23:59:59",
              c("Datetime","Global_reactive_power")]
)

plot(plot_data$Datetime,plot_data$Global_reactive_power,type="l", xlab="datetime", ylab="Global_reactive_power")

## Save the plot, using default 480px width and height
dev.copy(png,"plot4.png")
dev.off()

## Remove the data and variables from the workspace
rm(list=c("plot_data","power_data","url","wd","zipfile"))

## Set the working directory back to its previous path
setwd(oldwd)
rm(oldwd)
