## set columns to values
glucose = c(glucose_2$Glucose)
cost = c(glucose_2$Cost)

## plot and create line of best fit
plot(glucose, cost, ylab = "Cost", xlab = "Glucose", main = "Scatter plot of glucose and cost data")
abline(lm(y~x))

## correlation of line
cor(glucose, cost)

## Regressionline formula and sumary of regression stats
formula =lm(cost ~ glucose)
summary(formula)