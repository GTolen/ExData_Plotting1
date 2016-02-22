#Plot3.R

#Set working directory: "C:/Gary/Test/ExploratoryData1/ExData_Plotting1"
#Load data

#for converting Time column from character type 
#install.packages("chron")
#load library: library(chron)

#install.packages("dplyr")
#load library: library(dplyr) for mutate function

TargetFile<-"household_power_consumption.txt"
TargetData<-read.table(TargetFile,header=TRUE, sep=";",na.strings="?",stringsAsFactors = FALSE)
TargetData$Date<-as.Date(TargetData$Date,format="%d/%m/%Y")
TargetData$Time<-chron(times=TargetData$Time)

# Two ways to create subset:
# The code below was used for checking:
# > L=(TargetData$Date=="2007/2/1"|TargetData$Date=="2007/2/2")
# > SubData<-TargetData[L,]

SubData<-subset(TargetData,(Date>="2007-02-01" & Date<="2007-02-02"))
SubData<-mutate(SubData,DateTime=paste(Date, Time))

Plot_DT<-strptime(SubData$DateTime,"%Y-%m-%d %H:%M:%S")

Plot_SM1<-SubData$Sub_metering_1
Plot_SM2<-SubData$Sub_metering_2
Plot_SM3<-SubData$Sub_metering_3

png("plot3.png",width=480,height=480)
plot(Plot_DT,Plot_SM1,type="l",xlab="",ylab="Energy sub metering")
lines(Plot_DT,Plot_SM2,type="l",col="red")
lines(Plot_DT,Plot_SM3,type="l",col="blue")
legend(x="topright",col=c("black","red","blue"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()

