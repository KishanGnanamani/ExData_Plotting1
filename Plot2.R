# This function takes the complete file path of the household_power_consumption.txt file as input parameter and creates the "Plot2.png" in the working directory
# Function invocation example - createPlot2("C:/Users/.../household_power_consumption.txt")

createPlot2 <- function(filepath) {

    fpath <- filepath
    
    # reads the file and stores the data in the "pjct1data" data frame
    pjct1data <- read.table(fpath,sep = ";",header = TRUE)
    
    # "ssdata" data frame is created by subsetting only the 02/01/07 and 02/02/07 data from the "pjct1data" data frame
    ssdata <- subset(pjct1data,pjct1data$Date == "1/2/2007" | pjct1data$Date == "2/2/2007")
    
    # new column "DateTime" is created in the "ssdata" data frame bt concatenating the "Date" and " Time" columns
    ssdata <- cbind(DateTime = paste(as.character(ssdata$Date),as.character(ssdata$Time)),ssdata)
    
    # converts the "Global_active_power" column as a numeric field and the "DateTime" column as a POSIXCT field
    ssdata$Global_active_power = as.numeric(as.character(ssdata$Global_active_power))
    ssdata$DateTime = as.POSIXct(ssdata$DateTime,format = "%d/%m/%Y %H:%M:%S")
    
    #png graphic file creation with the scatter plot
    png(file = "Plot2.png",width = 480, height = 480, units = "px")
    with(ssdata,plot(DateTime,Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))
    dev.off()
    
}
