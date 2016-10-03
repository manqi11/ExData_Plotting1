setwd("/Users/pzhou5/Dropbox/Coursera/explotary data analysis/Week1 Project")
#Download file
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
download.date<-date()
unzip("household_power_consumption.zip")

#Read in the dataset
data<-read.table("./household_power_consumption.txt",header =TRUE ,sep=";",na.strings = "?")
View(data)
str(data)

#Use strptime and as.Date function to convert Time and Date to a new variable called DateTime
?strptime
data$DateTime<-paste(data$Date,data$Time)
data$DateTime<-strptime(data$DateTime,"%d/%m/%Y %H:%M:%S")
class(data$DateTime)
data$DateTime<-as.Date(data$DateTime)
class(data$DateTime)
View(data)

#Subset the original dataset to get data from the dates 2007-02-01 and 2007-02-02
newdata<-subset(data,DateTime %in% as.Date(c("2007-02-01","2007-02-02")))
View(newdata)


#Plot plot3
names(newdata)
png(filename = "Plot3.png", width = 480, height = 480,
    bg = "white")

plot(newdata$NewTime,newdata$Sub_metering_1,type="l",col="black",xlab="",ylab="")
lines(newdata$NewTime,newdata$Sub_metering_2,type="l",col="red")
lines(newdata$NewTime,newdata$Sub_metering_3,type="l",col="blue")
title(xlab="",ylab="Engergy sub meeting")
legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
dev.off()