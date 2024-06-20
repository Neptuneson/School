######################################
### Code for Bar graph & Pie chart ###
### Name: Robert Petro             ###
### Variable: Blood Type (Major)   ###
######################################

labels = c("A", "AB", "B", "O")
btype = c("A", "A", "B", "O", "O", "O", "AB", "A", "A", "O", "O", "AB", 
          "B","B", "A", "A", "O", "AB", "B", "O")
table(btype)
height = c(6,3,4,7)
barplot(height, names.arg = labels, xlab = "Amount", ylab = "Blood Types", col = "red", main = "Blood Type (Major)", border = "black")
