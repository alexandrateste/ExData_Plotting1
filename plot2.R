# Assumption: the zip file is in the working directory
ffile <- unzip("./exdata-data-household_power_consumption.zip")
# Extract only rows for which Date is in [01/02/2007, 02/02/2007]
# Requires: install.packages("sqldf")
library(sqldf)
alldata <-read.csv.sql("household_power_consumption.txt", sep = ';', sql = "select * from file where Date in ('1/2/2007','2/2/2007')")
# Replace empty values and "?" by NA
alldata[alldata=="?"]<-NA
alldata[alldata==""]<-NA
# Concatenates the Date and Time columns
alldata <- within(alldata,  DateTime <- paste(Date, Time, sep=" "))
# Transforms the new DateTime columns into a Date/Time class
alldata$DateTime <- strptime(alldata$DateTime,format="%d/%m/%Y %H:%M:%S")
# Plots to the plot2.png file (480 pixels wide and high)
# Time series of Global Active Power
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(alldata$DateTime,alldata$Global_active_power,type='l',xlab="",ylab="Global Active Power (kilowatts)")
dev.off()