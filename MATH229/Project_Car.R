################################
###        Cars Data         ###
###      Robert Petro        ###
################################

## Read csv file
car_sales <- read.csv("Documents/College/Year 2, Semester 1/MATH - 229/R/car_sales.csv")
par(mfrow = c(1,1))

## Pie Chart of Vehicle Type
typesData = table(car_sales$type)
pie(typesData, labels = c("Automobile","Truck"), main = "Automobiles vs Trucks")

## Bar Graph of manufacturer
manufacturerData = table(car_sales$manufact)

par(mai=c(2,1,1,1))
barplot(manufacturerData, 
        main = "Number of Cars sold per Manufacturere", 
        ylab = "Number of cars Sold", 
        xlab = "",
        las = 2,
        cex.names = 0.7)
mtext("Maufacturer", side=1, line = 7, las=1)

## Histogram for price of car
hist(car_sales$price, xlab = "Price in thousands of dollars", main = "Histogram of Car Price")

## Box plot for 4 year resale value
boxplot(car_sales$resale, main = "Box plot of 4 year resale value", ylab = "Resale Price in thousands of dollars")

## Average resale value by vehicle type table
resaleVehicleTable = data.frame(tapply(car_sales$resale, car_sales$type, mean, na.rm = TRUE), row.names = c("Automobile", "Truck"))
names(resaleVehicleTable)[1] = "Resale Price"

## Price of car by vehicle type table
priceVehicleTable = data.frame(tapply(car_sales$price, car_sales$type, mean, na.rm = TRUE), row.names = c("Automobile", "Truck"))
names(priceVehicleTable)[1] = "Price of car"

## Regression analysis
result = lm(car_sales$price ~ car_sales$mpg)
summary(result)

## All 4 assumption graphs compbined
par(mfrow = c(2, 2))
library(ggfortify)
autoplot(result)
par(mfrow = c(1,1))

## Population average using sample of 40
xdata = sample(car_sales$price, 40)
##xdata = na.exclude(xdata)
xdata
mean = mean(xdata)
mean

t.test(xdata, mu = mean)

## Normality Assumption
qqnorm(xdata,  main = "Normal Q-Q Plot",xlab = "Theoretical Quantiles", ylab = "Sample Quantiles")
qqline(xdata, col="blue")





