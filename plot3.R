plot3 <- function(){
  library(sqldf)
  #Read and filter data at the same time
  filtered_df <- read.csv.sql("household_power_consumption.txt", "select * from file where Date == '1/2/2007' or Date == '2/2/2007'", sep = ";")
  
  #Add new column "DateTime", which is a merge between column "Date" and column "Time"
  filtered_df$DateTime <- paste(filtered_df$Date, filtered_df$Time)
  
  #Translate DateTime
  filtered_df$DateTime <- strptime(filtered_df$DateTime, "%d/%m/%Y %H:%M:%S")
  
  #Call graphics device PNG
  png(filename = "plot3.png", width = 480, height = 480, units = "px")
  
  #Create graph
  with(filtered_df, plot(filtered_df$DateTime, filtered_df$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
  lines(filtered_df$DateTime, filtered_df$Sub_metering_1, col = "black")
  lines(filtered_df$DateTime, filtered_df$Sub_metering_2, col = "red")
  lines(filtered_df$DateTime, filtered_df$Sub_metering_3, col = "blue")
  legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1))
  
  #Close graphics device
  dev.off()
}