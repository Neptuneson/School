################################################
###"Carseats" is a built-in data set inside R###
### A data set with 400 observations about   ###
### the sales of child car seats. It has 11  ###
### variables or characteristics.            ###
### Source: rdrr.io/cran/ISLR/Carseats.html  ###
################################################


################################################
###  Downloading necessary support packages  ###
###   to run the R code                      ###
################################################

install.packages("ISLR")
library(ISLR)

attach(Carseats)
###  Checking the data set  ###
dim(Carseats)     ### number of rows & columns  
head(Carseats)    ### first 6 lines of the data
tail(Carseats)    ### last 6 lines of the data

#################################################
### Variable of interest is: Sales of Carseat ###
### Unit sales (in thousands) at each location###
#################################################

mean(Sales)
sd(Sales)
hist(Sales)

########################################################
### The population data looks slightly right skewed  ###
###     Draw a sample of size 40 from this data      ###
###           Find the sample mean of Slaes          ###
########################################################

##########################################
#### Selecting a simple random sample ####
##########################################

xdata = sample(Sales, 40)
### selects 40 values of Sales randomly ###
head(xdata)
length(xdata)

mean(xdata)
hist(xdata, main =" Histogram of sample of Sales values")

#################################################################
####   Construct a Sampling Distribution by getting sample  #####
####         means from all the students in the class       #####
####          Create a column vector of sample means        #####
####         Then find the mean and standard deviation      #####
####                 of all the sample means                #####
####  Also, create a histogram of the all the sample means  ##### 
####              Look at the findings carefully!           #####
#### This provides the proof for the Central Limit Theorem  #####
#################################################################

smean =c(8.29, 7.67, 7.77,8.52, 8.11, 7.60,7.39, 6.80, 7.62, 7.84, 7.38, 6.99, 8.01, 6.80, 7.98, 7.12, 7.44, 6.72, 7.49, 8.02, 7.33)
hist(smean, main="Sampling Distrbution of Sample means")
mean(smean)
sd(smean)

