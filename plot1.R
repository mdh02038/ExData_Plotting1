## 
## plot1.R
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
subdData <- data[select1 & select2,]

## plot data and convert to a png file
hist( 
  as.numeric(subdData$Global_active_power),
  col="red",
  xlab="Global Active Power (kilowatts)", 
  main="Global Active Power"
)
dev.copy(png, file="plot1.png")
dev.off()
