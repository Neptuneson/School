diabetes = read.table("~/Documents/College/Year 2, Semester 1/MATH - 229/R/diabetes.txt", header=TRUE, quote="\"")
HbA1c = diabetes$HbA1c
FPG = diabetes$FPG
plot(HbA1c, FPG, main = "HbA1c using FPG")
formula = lm(FPG~HbA1c)
abline(formula)
summary(formula)