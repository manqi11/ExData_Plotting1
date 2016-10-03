#Download file
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
download.date<-date()
unzip("household_power_consumption.zip")

#Read in the dataset
data<-read.table("./household_power_consumption.txt",header =TRUE ,sep=";",na.strings = "?")
View(data)
str(data)

#Use strptime and as.Date function to convert Time and Date to a new variable called DateTime
data$DateTime<-paste(data$Date,data$Time)
data$DateTime<-strptime(data$DateTime,"%d/%m/%Y %H:%M:%S")
data$DateTime<-as.Date(data$DateTime)

#Subset the original dataset to get data from the dates 2007-02-01 and 2007-02-02
newdata<-subset(data,DateTime %in% as.Date(c("2007-02-01","2007-02-02")))

#Convert the Date and Time and create a new variable "NewTime"
newdata$CombineTime<-paste(newdata$Date,newdata$Time)
newdata$NewTime<-strptime(newdata$CombineTime,"%d/%m/%Y %H:%M:%S")

#Plot plot4
png(filename = "plot4.png", width = 480, height = 480,
    bg = "white")
#Plot the figure in four parts 
par(mfrow=c(2,2))
#The left top cornor plot is the same as the plot2
with(newdata,plot(NewTime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))

#The right top cornor plot 
with(newdata,plot(NewTime,Voltage,type="l",xlab="datetime",ylab="Voltage"))

#The left bottom plot is the same as the plot3
plot(newdata$NewTime,newdata$Sub_metering_1,type="l",col="black",xlab="",ylab="")
lines(newdata$NewTime,newdata$Sub_metering_2,type="l",col="red")
lines(newdata$NewTime,newdata$Sub_metering_3,type="l",col="blue")
title(xlab="",ylab="Engergy sub meeting")
legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

#The right bottom plot
with(newdata,plot(NewTime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))

dev.off()

