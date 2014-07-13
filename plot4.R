## Read in data file in working directory

col_names = c("Global_active_power","Global_reactive_power","Voltage",        # List of variable names
              "Sub_metering_1","Sub_metering_2","Sub_metering_3");
raw <- read.csv("household_power_consumption.txt",sep=";");                   # Read in raw data 
df  <- rbind( subset(raw,Date == "1/2/2007", select=Date:Sub_metering_3),     # Select obs over 2 day period
              subset(raw,Date == "2/2/2007", select=Date:Sub_metering_3) );
date_time = strptime(paste(df$Date,df$Time,sep=' '),"%d/%m/%Y %T",tz = "");   # Merge Date & Time colums
df  <- cbind( DateTime=date_time,  df[col_names] );                           # Build new data frame
rm(raw,col_names,date_time);                                                  # Remove objects not needed anymore

## Plot 4 -- Create 'plot4.png' in working directory

png(file = "plot4.png");                                                      # Open PNG device
par(mfrow=c(2,2));
plot(df$DateTime,df$Global_active_power,type="l",xlab="",ylab="Global Active Power");
plot(df$DateTime,df$Voltage,type="l",xlab="datetime",ylab="Voltage");
plot(df$DateTime,df$Sub_metering_1,col="black",xlab="",ylab="Energy sub metering",type="l"); 
lines(df$DateTime,df$Sub_metering_2,col="blue"); 
lines(df$DateTime,df$Sub_metering_3,col="red"); 
legend(x='topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","blue","red"),box.lty=1);
plot(df$DateTime,df$Global_reactive_power,xlab="datetime",ylab="Energy sub metering",type="l"); 
dev.off();                                                                    # Close the PNG file device
