rm(list=ls())

# Read text file with ; separator
d <- read.csv("household_power_consumption.txt",sep = ";",header = TRUE)

# Convert Date & Time columns to date-time format and extract only time period of interest
d$Datetime <- as.POSIXlt(strptime(paste(d$Date,d$Time),format="%d/%m/%Y %H:%M:%S",tz=""))
dat <- d[as.Date(d$Datetime) >= as.Date("2007-02-01") & as.Date(d$Datetime) <= as.Date("2007-02-02"),]

# Convert fields from factor to numeric class for plotting
# colClasses in read.csv will not work because of missing values denoted by ? character
dat$Global_active_power <- as.numeric(as.character(dat$Global_active_power))
dat$Global_reactive_power <- as.numeric(as.character(dat$Global_reactive_power))
dat$Voltage <- as.numeric(as.character(dat$Voltage))
dat$Sub_metering_1 <- as.numeric(as.character(dat$Sub_metering_1))
dat$Sub_metering_2 <- as.numeric(as.character(dat$Sub_metering_2))
dat$Sub_metering_3 <- as.numeric(as.character(dat$Sub_metering_3))

# Create plot
png(filename="Plot3.png",width=480,height=480)
plot(dat$Datetime,dat$Sub_metering_1,col="black",type="l",xlab="",ylab="Energy sub metering")
points(dat$Datetime,dat$Sub_metering_2,col="red",type="l",xlab="",ylab="")
points(dat$Datetime,dat$Sub_metering_3,col="blue",type="l",xlab="",ylab="")
legend("topright",col=c("black","red","blue"),lty=c(1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()