# This function takes the complete file path of the household_power_consumption.txt file as input parameter and creates the "Plot4.png" in the working directory
# Function invocation example - createPlot4("C:/Users/.../household_power_consumption.txt")

createPlot4 <- function(filepath) {
    
    fpath <- filepath
    
    # reads the file and stores the data in the "pjct1data" data frame
    pjct1data <- read.table(fpath,sep = ";",header = TRUE)
    
    # "ssdata" data frame is created by subsetting only the 02/01/07 and 02/02/07 data from the "pjct1data" data frame
    ssdata <- subset(pjct1data,pjct1data$Date == "1/2/2007" | pjct1data$Date == "2/2/2007")
    
    # new column "DateTime" is created in the "ssdata" data frame bt concatenating the "Date" and " Time" columns
    ssdata <- cbind(DateTime = paste(as.character(ssdata$Date),as.character(ssdata$Time)),ssdata)
    
    # converts the "Global_active_power","Sub_metering_1","Sub_metering_2","Sub_metering_3" columns as numeric fields and the "DateTime" column as a POSIXCT field
    ssdata$Global_active_power = as.numeric(as.character(ssdata$Global_active_power))
    ssdata$DateTime = as.POSIXct(ssdata$DateTime,format = "%d/%m/%Y %H:%M:%S")
    ssdata$Sub_metering_1 = as.numeric(as.character(ssdata$Sub_metering_1))
    ssdata$Sub_metering_2 = as.numeric(as.character(ssdata$Sub_metering_2))
    ssdata$Sub_metering_3 = as.numeric(as.character(ssdata$Sub_metering_3))
    ssdata$Global_reactive_power = as.numeric(as.character(ssdata$Global_reactive_power))
    ssdata$Voltage = as.numeric(as.character(ssdata$Voltage))
    
    #png graphic file creation with the scatter plot
    png(file = "Plot4.png",width = 480, height = 480, units = "px")
    par(mfrow = c(2,2),mar = c(4,4,3,1.5))
    with(ssdata,plot(DateTime,Global_active_power,type = "l",xlab = "",ylab = "Global Active Power"))
    with(ssdata,plot(DateTime,Voltage,type = "l",xlab = "datetime",ylab = "Voltage"))
    with(ssdata,plot(DateTime,Sub_metering_1,ylim = range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)),type = "l",xlab = "",ylab = ""))
    par(new = TRUE)
    with(ssdata,plot(DateTime,Sub_metering_2,ylim = range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)),col = "red",type = "l",xlab = "",ylab = ""))
    par(new = TRUE)
    with(ssdata,plot(DateTime,Sub_metering_3,ylim = range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3)),col = "blue",type = "l",xlab = "",ylab = "Energy sub metering"))
    legend("topright",lty = c(1,1,1), col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    with(ssdata,plot(DateTime,Global_reactive_power,type = "l",xlab = "datetime",ylab = "Global_reactive_power"))
    dev.off()
    
}

