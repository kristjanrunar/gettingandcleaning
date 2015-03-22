list.files("train/")

X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

 X<- rbind(X_train,X_test)
 y<- rbind(y_train,y_test)
 subject <- rbind(subject_train,subject_test)
 
colnames(features) <- c("ID","feature")
 
colnames(X) <- features$feature
colnames(y) <- "activity_ID"
colnames(activity_labels) <- c("activity_ID", "activity")

colnames(subject) <- "subject_ID"

y_tidy <- merge(y,activity_labels)

used_data <- X[,grep("mean|std", colnames(X))]
used_data <- cbind(y_tidy$activity,used_data)
used_data <- cbind(subject,used_data)
colnames(used_data[2]) <- "activity"

mydata <- data.table(used_data)

tidy2 <- mydata[,lapply(.SD,mean), by = subject_ID]

write.table(tidy2, file="tidy_data.txt", row.names = FALSE)