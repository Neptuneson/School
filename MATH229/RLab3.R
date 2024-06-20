###########################
###      CLT RLab 3     ###
###     Robert Petro    ###
###########################

## Data imported.
cltData <- read.csv("~/Documents/College/Year 2, Semester 1/MATH - 229/R/cltData.csv", sep=",")

## Histogram.
hist(cltData$AmountSpend, xlab = "Amount", main = "Histogram of Amount Spent")

## Population mean and standard deviation.
mean(cltData$AmountSpend)
sd(cltData$AmountSpend)

## A random sample of sample size 50 from this population.
xdata = sample(cltData$AmountSpend, 50)
xdata
mean(xdata)
sd(xdata)

## Sampling distribution of sampling means.
smean = c(261.20, 184.04, 171.93, 246.43, 203.31, 188.01, 138.14, 197.99, 189.96, 256.14, 217.64, 204.39, 170.50, 196.94, 177.09, 221.99, 141.91, 163.12, 204.76, 163.1, 213.3, 186.38, 216.21)

## Histogram of sampling means.
hist(smean, xlab = "Sample Mean", main="Sampling Distrbution of Sample means")

## Sampling means mean and standard deviation.
mean(smean)
sd(smean)