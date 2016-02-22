#Plot4.R

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

# To be used for all plots
Plot_DT<-strptime(SubData$DateTime,"%Y-%m-%d %H:%M:%S")

# To be used for plot 1
Plot_GAP<-SubData$Global_active_power

# To be used for plot 2
Plot_Volt<-SubData$Voltage

# To be used for plot 3
Plot_SM1<-SubData$Sub_metering_1
Plot_SM2<-SubData$Sub_metering_2
Plot_SM3<-SubData$Sub_metering_3

# To be used for plot 4
Plot_GRP<-SubData$Global_reactive_power

png("plot4.png",width=480,height=480)
#to arrange plots in 2 rows and 2 columns
par(mfrow=c(2,2))

# Plot 1
plot(Plot_DT,Plot_GAP,type="l",xlab="",ylab="Global Active Power")

# Plot 2
plot(Plot_DT,Plot_Volt,type="l",xlab="datetime",ylab="Voltage")

# Plot 3
plot(Plot_DT,Plot_SM1,type="l",xlab="",ylab="Energy sub metering")
lines(Plot_DT,Plot_SM2,type="l",col="red")
lines(Plot_DT,Plot_SM3,type="l",col="blue")
legend(x="topright",col=c("black","red","blue"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Plot 4
plot(Plot_DT,Plot_GRP,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()

