#Plot1.R

#Set working directory: "C:/Gary/Test/ExploratoryData1/ExData_Plotting1"
#Load data
#install.packages(chron)
#load library: library(chron)

TargetFile<-"household_power_consumption.txt"
TargetData<-read.table(TargetFile,header=TRUE, sep=";",na.strings="?",stringsAsFactors = FALSE)
TargetData$Date<-as.Date(TargetData$Date,format="%d/%m/%Y")
TargetData$Time<-chron(times=TargetData$Time)

# Two ways to create subset:
# The code below was used for checking:
# > L=(TargetData$Date=="2007/2/1"|TargetData$Date=="2007/2/2")
# > SubData<-TargetData[L,]

SubData<-subset(TargetData,(Date>="2007-02-01" & Date<="2007-02-02"))

png("plot1.png",width=480,height=480)
hist(SubData$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off()

