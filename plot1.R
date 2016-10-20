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


## Change Date column from factor to data and subset required data
power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")
power_data <- na.omit(power_data[power_data$Date >= "2007-02-01" & power_data$Date <= "2007-02-02","Global_active_power"])

## Generate plot
hist(power_data,xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power", col="red")

## Save the plot, using default 480px width and height
dev.copy(png,"plot1.png")
dev.off()

## Remove the data and variables from the workspace
rm(list=c("power_data","url","wd","zipfile"))

## Set the working directory back to its previous path
setwd(oldwd)
rm(oldwd)
