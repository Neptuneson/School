########################################
### Regrssion & Correlation Analysis ###
###           Robert Petro           ###
########################################

## Data ##
x = c(2521, 2555, 2735, 2846, 3028, 3049, 3198, 3198)
y = c(400, 426, 428, 435, 469, 475, 488, 455)
data = data.frame(x, y)

## correlation ##
cor(x, y)

## Plot ##
plot(x,y, type = "p", main = "Scatter Plot of House size and Price", xlab = "Size (sq. ft)", ylab = "Price ($1000)")
lm(y~x)
abline(lm(y~x))
