##creating a folder for the first plot
dir.create("plot1")
setwd("plot1")

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


##converting to Date
basedata$Date <- as.Date(basedata$Date,"%d/%m/%Y")


##filtering out the working data
workdata<- basedata[(basedata$Date>="2007-02-01") & (basedata$Date<="2007-02-02"), ]
head(workdata)
workdata$Global_active_power <- as.numeric(as.character(workdata$Global_active_power))
head(workdata)


##creating the plot1
par(mfrow = c(1, 1))
hist(as.numeric(workdata$Global_active_power),col="Red",main="Global Active Power",xlab="Global Active Power (kilowatts)",cex.axis=0.8,cex.lab=0.8)

##coping the plot to a png file
dev.copy(png,file="plot1.png")
dev.off()


##setting back the root directory as working directory
setwd("..")