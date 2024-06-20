library(tidyverse)
library(broom)
theme_set(theme_classic())

## Regression fuction
model = lm(price ~ mpg, data = car_sales)
model

## Regression residual statistics
model.diag.metrics = augment(model)
head(model.diag.metrics)

## Risidual Plots
## Base R
par(mfrow = c(2, 2))
plot(model)

## ggfortify
library(ggfortify)
autoplot(model)

## plot of mpg and price
par(mfrow = c(1,1))