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
png(filename="Plot2.png",width=480,height=480)
plot(dat$Datetime,dat$Global_active_power,col="black",xlab="",ylab="Global Active Power (kilowatts)",type="l")
dev.off()