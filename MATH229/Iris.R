###########################
###     Iris RLab 2     ###
###     Robert Petro    ###
###########################

##Data imported
iris <- read.csv("~/Documents/College/Year 2, Semester 1/MATH - 229/R/iris.txt", sep="")

## Set values to columns
sepalLength = iris$X1
sepalWidth = iris$X2
petalLength = iris$X3
petalWidth = iris$X4
species = iris$X5

## plot petal length using sepal length on a scatter plot
plot(petalLength, sepalLength, main = "Sepal Length Using Petal Length", xlab = "Petal Length", ylab = "Sepal Length")

## correlation of line
cor(petalLength, sepalLength)

## create formula for regression line
formula = lm(sepalLength ~ petalLength)
summary(formula)
