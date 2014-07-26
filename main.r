main <- function(path_to_raw_data="~/R/data/getting_data_course_project/UCI HAR Dataset/", path_to_tidy_data="~/R/data/getting_data_course_project")
{       
        require(stringr)
        old_wd <- getwd()
        setwd(path_to_raw_data)
        
        #this function extracts  all the data from type_of_set folder - /train or test
        collect_pieces <- function (type_of_set)
        {       #reading and naming measured variables
                df <- read.table(str_c(type_of_set, "/X_", type_of_set, ".txt", sep="") )
                names(df) <- features_names
                #reading activity data and factorize it
                activity_df <- read.table(str_c(type_of_set, "/y_", type_of_set, ".txt", sep=""))
                Activity <- factor(activity_df[, 1], levels=activity_labels[, 1], labels=activity_labels[, 2])
                #reading data about subjects of tests
                subject_df <- read.table(str_c(type_of_set, "/subject_", type_of_set, ".txt", sep=""))
                names(subject_df) <- "Subject"
                #bind whole df with all the data and proper labels
                cbind(subject_df, Activity, df, deparse.level = 1 )
        }
        
        
        #this function makes averaging of data, as demands by 6) item. 
        #Its argument is the factor for averaging by
        prepare_tidy_data <- function(factor_column)
        {
                func <- function(x){
                lapply(x[3:length(x)], mean)
                }
                #splitting data by factor, and averaging the quantitive variables in func()
                tmp_list <- lapply(split(df, df[factor_column]), func)
                #making from list a matrix
                do.call(rbind, tmp_list)
                
        }
        #here i extract some data, common for both calls of collect_pieces
        features_names <- read.table("features.txt")[, 2]
        activity_labels <- read.table("activity_labels.txt")
        #rbind two data arrays from /train and /test subsets 
        df <- rbind(collect_pieces("train"), collect_pieces("test"))
        setwd(old_wd)
        #finding logical indexes of data mentioned in 2) item of demands list
        logical_indeces <- str_detect(names(df), ignore.case(".*mean.*|.*std.*"))
        #dont forget about activity and subject columns
        logical_indeces[1:2] <- TRUE
        df <- df[, logical_indeces]
        
        old_wd=getwd()
        setwd(path_to_tidy_data)
        #making tidy dataset
        tidy_data <- lapply(c("Activity", "Subject"), prepare_tidy_data)
        names(tidy_data) <- c("Activity", "Subject")
        #serializing tidy dataset into gzipped file
        con <- gzfile("tidy_data.txt", open="w")
        serialize(tidy_data, con)
        close(con)
        setwd(old_wd)
        
        tidy_data
}


#this function simply unzip and unserialize tidy data file, produced by main.r
load_tidy_data <- function(path_to_tidy_data="~/R/data/getting_data_course_project")
{
        old_wd <- getwd()
        setwd(path_to_tidy_data)
        con <- gzfile("tidy_data.txt", open="r")
        t <- unserialize(con)
        close(con)
        setwd(old_wd)
        t
}
