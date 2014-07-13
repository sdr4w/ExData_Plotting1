## Read in data file in working directory

col_names = c("Global_active_power","Global_reactive_power","Voltage",        # List of variable names
              "Sub_metering_1","Sub_metering_2","Sub_metering_3");
raw <- read.csv("household_power_consumption.txt",sep=";");                   # Read in raw data 
df  <- rbind( subset(raw,Date == "1/2/2007", select=Date:Sub_metering_3),     # Select obs over 2 day period
              subset(raw,Date == "2/2/2007", select=Date:Sub_metering_3) );
date_time = strptime(paste(df$Date,df$Time,sep=' '),"%d/%m/%Y %T",tz = "");   # Merge Date & Time colums
df  <- cbind( DateTime=date_time,  df[col_names] );                           # Build new data frame
rm(raw,col_names,date_time);                                                  # Remove objects not needed anymore

## Plot 2 -- Create 'plot2.png' in working directory

png(file = "plot2.png");                                                      # Open PNG device;
plot(df$DateTime,df$Global_active_power,                                      # Draw plot
     type="l",                                                                #   ~ Draw solid line
     xlab="",                                                                 #   ~ Label x-axis
     ylab="Global Active Power (kilowatts)");                                 #   ~ Label y-axis
dev.off();                                                                    # Close the PNG file device

