setwd("C:/Users/Zhiyi/Desktop/project")
rm(list = ls())
unzip("data.zip")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
x_all <- rbind(x_test, x_train)     #accomplish step1

variable_names <- read.table("./UCI HAR Dataset/features.txt")
variable_names$V1 <- NULL     #delete the first column (number 1 to 561)
variable_names <- data.frame(sapply(variable_names, as.character), stringsAsFactors=FALSE)
                                                     #convert factor to charator
names(x_all) = t(variable_names)     #accomplish step4

x_all_mean <- colMeans(x_all)     #compute all measurements' mean
install.packages("matrixStats")
library(matrixStats)
x_all <- as.matrix(x_all)
x_all_sd <- colSds(x_all)     #compute all measurements' standard deviation, accomplish step2

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_all <- rbind(y_test, y_train)

activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_names$V1 <- NULL     #delete the first column (number 1 to 6)
activity_names <- t(activity_names)     #transpose column to row
y_all[, 1] <- activity_names[y_all[, 1]]     #convert activity numbers to activity lables
names(y_all)[1] <- "activity"
#y_all <- as.character(y_all)

xy_all <- cbind(y_all, x_all)     #accomplish step3

write.table(xy_all, "tidyData.txt", row.name = FALSE)



