#Plot2.R

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
Plot_GAP<-SubData$Global_active_power

png("plot2.png",width=480,height=480)
plot(Plot_DT,Plot_GAP,type="l",xlab="",ylab="Global Active Power (kilowatts)")


dev.off()

