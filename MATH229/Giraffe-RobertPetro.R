#####################
### Giraffe Hyena ###
### Robert Petro  ###
#####################

data = read.table("/Users/robertpetro/Documents/College/Year 2, Semester 1/MATH-229/giraffe_hyena.txt")

Age = data[,1]
Train =data[,2]
Speed = data[,3]
Scars = data[,4]
Status = data[,5]

## Pie chart
tableA = table(Status)
tableA
st = c(517, 183)
pie(st, main = "Survival Status of Giraffes", col = rainbow(length(st)), labels = c("Alive", "Dead"))

## Comparative Bar chart
tableB = table(Status, Train)
tableB
count = data.frame(Alive = tableB[1,], Dead = tableB[2,])
barplot(as.matrix(count), main = "Survival Status of Giraffs vs. Number of Trainings", beside = TRUE, col = rainbow(5), xlab= "Survival Status", ylab="No. of Giraffes")
legend("topright", c("1", "2", "3", "4", "5"), cex=1.0, bty = "n", fill = rainbow(5))

## Box Plot
boxplot(Speed, main = "Box Plot for Running Speeds", ylab = "Running Speed (mph)", col = "red")

## Stem and Leaf plot
stem(Speed , scale = 1)

## Mean and St.dev for running speed
meanSpeed = mean(Speed)
meanSpeed
sdSpeed = sd(Speed)
sdSpeed
