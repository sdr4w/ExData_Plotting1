## Read in data file in working directory

col_names = c("Global_active_power","Global_reactive_power","Voltage",        # List of variable names
              "Sub_metering_1","Sub_metering_2","Sub_metering_3");
raw <- read.csv("household_power_consumption.txt",sep=";");                   # Read in raw data 
df  <- rbind( subset(raw,Date == "1/2/2007", select=Date:Sub_metering_3),     # Select obs over 2 day period
              subset(raw,Date == "2/2/2007", select=Date:Sub_metering_3) );
date_time = strptime(paste(df$Date,df$Time,sep=' '),"%d/%m/%Y %T",tz = "");   # Merge Date & Time colums
df  <- cbind( DateTime=date_time,  df[col_names] );                           # Build new data frame
rm(raw,col_names,date_time);                                                  # Remove objects not needed anymore

## Plot 3 -- Create 'plot3.png' in working directory

png(file = "plot3.png");                                                      # Open PNG device
leg_txt  = c("Sub_metering_1","Sub_metering_2","Sub_metering_3");             # Text to use on legend
plot(df$DateTime,df$Sub_metering_1,                                           # Draw plot 0f Sub_metering_1
     type="l",                                                                #   ~ Draw solid line
     col="black",                                                             #   ~ Line color is black
     xlab="",                                                                 #   ~ Label x-axis
     ylab="Energy sub metering");                                             #   ~ Label y-axis
lines(df$DateTime,df$Sub_metering_2,col="blue");                              # Draw Sub_metering_2 on same plot using the color blue
lines(df$DateTime,df$Sub_metering_3,col="red");                               # Draw Sub_metering_3 on same plot using the color red
legend("topright",leg_txt,lty=c(1,1,1),col=c("black","blue","red"));          # Draw legend on plot
dev.off();                                                                    # Close the PDF file device
rm(leg_txt);