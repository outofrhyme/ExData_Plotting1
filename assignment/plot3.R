## Open zip file
unzip('exdata-data-household_power_consumption.zip')

## Read data from file and subset into desired date range; reformat timestamp.
alldata <- read.table('household_power_consumption.txt', sep = ';', header = TRUE)
dataset <- alldata[which(alldata$Date == '1/2/2007' | alldata$Date == '2/2/2007'),]
dataset <- cbind(Timestamp = 0, dataset)
dataset$Timestamp <- paste(dataset$Date, dataset$Time, sep = ' ')
dataset$Timestamp <- strptime(dataset$Timestamp, format = '%d/%m/%Y %H:%M:%S')
dataset <- subset(dataset, select = -c(2,3))

## Convert all factor columns into numeric values. NAs will be introduced.
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
dataset$Global_active_power <- as.numeric.factor(dataset$Global_active_power)
dataset$Global_reactive_power <- as.numeric.factor(dataset$Global_reactive_power)
dataset$Voltage <- as.numeric.factor(dataset$Voltage)
dataset$Global_intensity <- as.numeric.factor(dataset$Global_intensity)
dataset$Sub_metering_1 <- as.numeric.factor(dataset$Sub_metering_1)
dataset$Sub_metering_2 <- as.numeric.factor(dataset$Sub_metering_2)
## Sub_metering_3 is already numeric

## Create Plot 3 Line Chart with multiple lines
png(filename = 'plot3.png', width = 480, height = 480)
with(dataset, {
        plot(Timestamp, Sub_metering_1, type='l', ylab = 'Energy sub metering', xlab = '')
        lines(Timestamp, Sub_metering_2, type='l', col = 'red')
        lines(Timestamp, Sub_metering_3, type='l', col = 'blue')
})
legend('topright', lwd = '1', col = c('black', 'red', 'blue'), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()