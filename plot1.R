library(tidyr)
library(readr)
library(lubridate)
library(sqldf)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp,"household_power_consumption.txt")
data <- read.csv.sql("household_power_consumption.txt",sep = ';',sql = "select * from file where Date in ('1/2/2007','2/2/2007')",header = T)
data <- readr::type_convert(data,col_types = 'ccnnnnnnn')
data$Time <- as.POSIXlt(paste0(data$Date,'T',data$Time),format="%d/%m/%YT%H:%M:%S")
data$Date <- as.Date(data$Date,format="%d/%m/%Y")
unlink(temp)

dev.set(2)
hist(data$Global_active_power,col='red',main='Global Active Power',xlab = 'Global Active Power (kilowatts)',ylab = 'Frequency',bg='white')

dev.copy(png,filename="plot1.png")
dev.off()

