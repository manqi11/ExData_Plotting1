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

#Plot the first plot
names(newdata)

png(filename = "plot1.png", width = 480, height = 480,
    bg = "white")
hist(newdata$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()


