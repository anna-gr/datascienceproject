library(dplyr)

## Reading given data sets and coercing to data.table

features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
activity <- read.table("UCI HAR Dataset/activity_labels.txt")

subj_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

subj_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

## Changing duplicated feature names

features_table <- table(features$V2)
features_duplicated <- names(features_table[features_table>1])
for (f in features_duplicated) {
        similar <- which(features$V2 == f)
        n <- 1
        for (col_n in similar) {
                features[col_n, "V2"] <- paste(features[[col_n, "V2"]], 
                                               as.character(n), sep = "-")
                n <- n+1
                }
}


## Substituting feature names
colnames(x_train) <- features$V2
colnames(x_test) <- features$V2

## Binding columns containing 
## activity, subject and measurements
x_train <- x_train %>% mutate(activity_label = y_train$V1) %>% 
mutate(subject = subj_train$V1)

x_test <- x_test %>% mutate(activity_label = y_test$V1) %>% 
mutate(subject = subj_test$V1)

## Binding Train and Test sets
data_all <- rbind(x_train, x_test)


## Substituting activity labels
colnames(activity) <- c("activity_label", "activity_name")
data_all <- merge(data_all, activity, by = "activity_label")

## Selecting mean and standard deviation features
## as well as activity and subject columns
col_list <- c("activity_name", "subject", 
              grep("mean\\(|std", colnames(data_all), value = TRUE))
data_selected <- select(data_all, one_of(col_list))

## Creating dataset with the average of each feature 
## for each activity and each subject
data_grouped <- group_by(data_selected, activity_name, subject)
data_average <- summarise_all(data_grouped, mean)
write.table(data_average, "data_average.txt", row.name = FALSE)
