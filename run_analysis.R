library(data.table)

# read in the dataset
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

#merge the train and test datasets
X<- rbind(X_train,X_test)
y<- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)
 
#rename columns to make them more readable
colnames(features) <- c("ID","feature")
 
colnames(X) <- features$feature
colnames(y) <- "activity_ID"
colnames(activity_labels) <- c("activity_ID", "activity")

colnames(subject) <- "subject_ID"

# lookup the activity name by activity ID 
y_withname <- merge(y,activity_labels)

#select the data to be used (only the mean and standard deviation)
#we need to search for "mean(" with a parentesis to avoid meanFreq
used_data <- X[,grep("mean\\(|std", colnames(X))]

#add the activity name to the dataset
used_data <- cbind(y_withname[2],used_data)
#add the subject ID
used_data <- cbind(subject,used_data)

# convert the data.frame to a data.table
mydata <- data.table(used_data)

# calculate the average of all measurements by subject and activity
tidy <- mydata[,lapply(.SD,mean), by = list(subject_ID,activity)]

# this is the final tidy dataset
tidy

# uncomment in order to write the tidy data to a file
#write.table(tidy, file="tidy_data.txt", row.names = FALSE)
