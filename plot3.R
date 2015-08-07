## 
## plot3.R
##

## declare filenames
filename <- "household_power_consumption.txt"
zipFilename <- "household_power_consumption.zip"

## download file if needed
if( !file.exists( zipFilename ) ) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile=zipFilename, method="curl")
}

## decompress file and turn into data frame
data <- read.csv(unz(zipFilename,filename), header=TRUE, sep=";",stringsAsFactors=FALSE)

## select subset of data to plot
select1 <- as.Date(data$Date,format="%d/%m/%Y")>=as.Date("2007-02-01")
select2 <- as.Date(data$Date,format="%d/%m/%Y")<=as.Date("2007-02-02")
subData <- data[select1 & select2,]

## plot data and convert to a png file

png( file="plot3.png" )
plot( 
  strptime( paste(subData$Time, subData$Date), format="%H:%M:%S %d/%m/%Y"), 
  as.numeric(subData$Sub_metering_1), 
  type='l',
  col='black',
  ylab="Energy sub metering", 
  xlab=""
)
points( 
  strptime( paste(subData$Time, subData$Date), format="%H:%M:%S %d/%m/%Y"), 
  as.numeric(subData$Sub_metering_2), 
  type='l',
  col='red'
)
points( 
  strptime( paste(subData$Time, subData$Date), format="%H:%M:%S %d/%m/%Y"), 
  as.numeric(subData$Sub_metering_3), 
  type='l',
  col='blue'
)
legend( 
  "topright", 
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
  lty = 1,
  col = c("black","red", "blue")
)


dev.off()
