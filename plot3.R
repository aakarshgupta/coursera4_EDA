##creating a folder for the third plot
dir.create("plot3")
setwd("plot3")

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

##creating the plot3
par(mfrow = c(1, 1))
plot(workdata$datetime,workdata$Sub_metering_1,type='l',col="Black",ylab="Energy sub metering",xlab="",cex.axis=0.8,cex.lab=0.8)
lines(workdata$datetime,workdata$Sub_metering_2,type='l',col="Red",cex.axis=0.8,cex.lab=0.8)
lines(workdata$datetime,workdata$Sub_metering_3,type='l',col="Blue",cex.axis=0.8,cex.lab=0.8)
legend("topright", pch = "_", col = c("Black", "Red","Blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

##coping the plot to a png file
dev.copy(png,file="plot3.png")
dev.off()

##setting back the root directory as working directory
setwd("..")

