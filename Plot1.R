# This function takes the complete file path of the household_power_consumption.txt file as input parameter and creates the "Plot1.png" in the working directory
# Function invocation example - createPlot1("C:/Users/.../household_power_consumption.txt")

createPlot1 <- function(filepath) {

    fpath <- filepath
    
    # reads the file and stores the data in the "pjct1data" data frame
    pjct1data <- read.table(fpath,sep = ";",header = TRUE)
    
    # "ssdata" data frame is created by subsetting only the 02/01/07 and 02/02/07 data from the "pjct1data" data frame
    ssdata <- subset(pjct1data,pjct1data$Date == "1/2/2007" | pjct1data$Date == "2/2/2007")
    
    # converts the "Global_active_power" column as a numeric field
    ssdata$Global_active_power = as.numeric(as.character(ssdata$Global_active_power))
    
    #png graphic file creation with the hist plot
    png(file = "Plot1.png",width = 480, height = 480, units = "px")
    hist(ssdata$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)",ylab = "Frequency", main = "Global Active Power")
    dev.off()
    
}
