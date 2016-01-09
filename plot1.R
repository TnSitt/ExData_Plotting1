plot1 <- function(){
    library(sqldf)
    #Read and filter data at the same time
    filtered_df <- read.csv.sql("household_power_consumption.txt", "select * from file where Date == '1/2/2007' or Date == '2/2/2007'", sep = ";")
    
    #Add new column "DateTime", which is a merge between column "Date" and column "Time"
    filtered_df$DateTime <- paste(filtered_df$Date, filtered_df$Time)
    
    #Translate DateTime
    filtered_df$DateTime <- strptime(filtered_df$DateTime, "%d/%m/%Y %H:%M:%S")
    
    #Call graphics device PNG
    png(filename = "plot1.png", width = 480, height = 480, units = "px")
    
    #Create graph
    hist(filtered_df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
    
    #Close graphics device
    dev.off()
}