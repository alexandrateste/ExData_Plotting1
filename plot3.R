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
# Plots to the plot3.png file (480 pixels wide and high)
# Time series of the 3 energy "sub-meterings"
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(alldata$DateTime,alldata$Sub_metering_1,type='l',col='black',xlab="",ylab="Energy sub metering")
lines(alldata$DateTime,alldata$Sub_metering_2,type='l',col='red')
lines(alldata$DateTime,alldata$Sub_metering_3,type='l',col='blue')
legend("topright",lty=c(1,1), col=c('black','red','blue'),legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
dev.off()
