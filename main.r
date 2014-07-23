
setwd("~/R/data/getting_data_course_project/UCI HAR Dataset/")
train_df <- read.table("train/X_train.txt")
names(train_df) <- features_names[, 2]

activity_labels <- read.table("activity_labels.txt")
train_activity_df <- read.table("train/y_train.txt")
train_activity_df <- factor(train_activity_df[, 1], levels=activity_labels[, 1], labels=activity_labels[, 2])
