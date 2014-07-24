#######
library(stringr)
#library(plyr)

main <- function(path_to_raw_data="~/R/data/getting_data_course_project/UCI HAR Dataset/", path_to_tidy_data="~/R/data/getting_data_course_project"){
        require(stringr)
        old_wd <- getwd()
        setwd(path_to_raw_data)
        
        collect_pieces <- function (type_of_set)
        {
                #setwd("~/R/data/getting_data_course_project/UCI HAR Dataset/")
                df <- read.table(str_c(type_of_set, "/X_", type_of_set, ".txt", sep="") )
                names(df) <- features_names
                
                activity_df <- read.table(str_c(type_of_set, "/y_", type_of_set, ".txt", sep=""))
                Activity <- factor(activity_df[, 1], levels=activity_labels[, 1], labels=activity_labels[, 2])
                
                subject_df <- read.table(str_c(type_of_set, "/subject_", type_of_set, ".txt", sep=""))
                names(subject_df) <- "Subject"
                
                cbind(subject_df, Activity, df, deparse.level = 1 )
        }
        
        prepare_and_save_tidy_data <- function(factor_column)
        {
                func <- function(x){
                lapply(x[3:length(x)], mean)
                }
                
                tmp_list <- lapply(split(df, df[factor_column]), func)
                varname <- str_c(factor_column, "_mean_m")
                assign(varname, do.call(rbind, tmp_list))
                con <- gzfile(str_c(varname, ".ser"), open="w")
                serialize(get(varname), con)
                close(con)
                get(varname)
        }
        
        features_names <- read.table("features.txt")[, 2]
        activity_labels <- read.table("activity_labels.txt")
        setwd(old_wd)
        
        df <- rbind(collect_pieces("train"), collect_pieces("test"))
        logical_indeces <- str_detect(names(df), ignore.case(".*mean.*|.*std.*"))
        logical_indeces[1:2] <- TRUE
        df <- df[, logical_indeces]
        
        old_wd=getwd()
        setwd(path_to_tidy_data)
        l <- lapply(c("Activity", "Subject"), prepare_and_save_tidy_data)
        setwd(path_to_tidy_data)
        l
}
