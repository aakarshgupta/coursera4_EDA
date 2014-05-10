##creating a folder for the fourth plot
dir.create("plot4")
setwd("plot4")

## downloading the data to the working directory
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="data.zip")
dir()


##extracting data
unzip("data.zip")
dir()


##loading the data into R
basedata<-read.table("household_power_consumption.txt",header=TRUE,sep=";")



##checking the data as per instructions
#colnames
colnames(basedata)
#rows = 2075259
nrow(basedata)
#columns = 9
ncol(basedata)

head(basedata)
str(basedata)

##converting to Date
basedata$Date <- as.Date(basedata$Date,"%d/%m/%Y")


##filtering out the working data
workdata<- basedata[(basedata$Date>="2007-02-01") & (basedata$Date<="2007-02-02"), ]
head(workdata)
tail(workdata)
str(workdata)
workdata$Global_active_power <- as.numeric(as.character(workdata$Global_active_power))
workdata$Global_reactive_power <- as.numeric(as.character(workdata$Global_reactive_power))
workdata$Voltage <- as.numeric(as.character(workdata$Voltage))
workdata$Global_intensity <- as.numeric(as.character(workdata$Global_intensity))
workdata$Sub_metering_1 <- as.numeric(as.character(workdata$Sub_metering_1))
workdata$Sub_metering_2 <- as.numeric(as.character(workdata$Sub_metering_2))
workdata$Sub_metering_3 <- as.numeric(as.character(workdata$Sub_metering_3))
head(workdata)
tail(workdata)
workdata$datetime<-as.POSIXct(paste(workdata$Date,workdata$Time))
head(workdata)
str(workdata)

##creating the plot4
par(mfrow = c(2, 2))
plot(workdata$datetime,workdata$Global_active_power,type='l',col="Black",ylab="Global Active Power",xlab="",cex.axis=0.8,cex.lab=0.8)
plot(workdata$datetime,workdata$Voltage,type='l',col="Black",ylab="Voltage",xlab="datetime",cex.axis=0.8,cex.lab=0.8)
plot(workdata$datetime,workdata$Sub_metering_1,type='l',col="Black",ylab="Energy sub metering",xlab="",cex.axis=0.8,cex.lab=0.8)
lines(workdata$datetime,workdata$Sub_metering_2,type='l',col="Red",cex.lab=0.8)
lines(workdata$datetime,workdata$Sub_metering_3,type='l',col="Blue",cex.lab=0.8)
legend("topright",bty="n",box.col="white",pch = "_", col = c("Black", "Red","Blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),cex=0.8)
plot(workdata$datetime,workdata$Global_reactive_power,type='l',col="Black",ylab="Global_reactive_power",xlab="datetime",ylim=c(0.0,0.5),cex.axis=0.8,cex.lab=0.8)

##coping the plot to a png file
dev.copy(png,file="plot4.png")
dev.off()

##setting back the root directory as working directory
setwd("..")

