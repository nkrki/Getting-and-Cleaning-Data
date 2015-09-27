#Setting file url and setting the working directory
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
setwd("C:/Users/565864/Desktop/Data Scientist Course/Getting and Cleaning Data/Assignment")

#Checking if the file exists and if not, downloading and unzipping it
if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
  download.file(fileURL, paste0(getwd(), "/getdata-projectfiles-UCI HAR Dataset.zip"))
  unzip("getdata-projectfiles-UCI HAR Dataset.zip", exdir = getwd())
}

#Read Test Data and  column bind to get complete set
testlabel <- read.table(paste0(getwd(), "/UCI HAR Dataset/test/y_test.txt"), col.names = "Vl")
testsubject <- read.table(paste0(getwd(), "/UCI HAR Dataset/test/subject_test.txt"), col.names = "Vs")
testdata <- read.table(paste0(getwd(), "/UCI HAR Dataset/test/X_test.txt"))
completetestdata <- cbind(testlabel, testsubject, testdata)
#Read Train Data and column bind to get complete set; row bind both training and test data
trainlabel <- read.table(paste0(getwd(), "/UCI HAR Dataset/train/y_train.txt"), col.names = "Vl")
trainsubject <- read.table(paste0(getwd(), "/UCI HAR Dataset/train/subject_train.txt"), col.names = "Vs")
traindata <- read.table(paste0(getwd(), "/UCI HAR Dataset/train/X_train.txt"))
completetraindata <- cbind(trainlabel, trainsubject, traindata)
oneDataSet <- rbind(completetestdata, completetraindata)

#Reading features, extracting only mean and std; then reading those rows in data
features <- read.table(paste0(getwd(), "/UCI HAR Dataset/features.txt"))
meanstdfeatures <- features[grep("mean\\(|std\\(", features$V2), ]
meanstdData <- oneDataSet[, c(1, 2, meanstdfeatures$V1)]

#Reading Activity Labels and merging it with Mean and Std Data
activitylabels <- read.table(paste0(getwd(), "/UCI HAR Dataset/activity_labels.txt"))
labeledData <- merge(meanstdData, activitylabels, by.x = "Vl", by.y = "V1")

#Setting Column Names close to Standards
columnNames <- gsub("\\(\\)", "", meanstdfeatures$V2)
columnNames <- gsub("\\-", ".", columnNames)
colnames(meanstdData) <- c("Label", "Subject", columnNames)

#Taking Mean and Writing to a Separate File
subjectlabelData <- aggregate(meanstdData[,names(meanstdData) != c('Label','Subject')], 
                              by=list(activity = meanstdData$Label, 
                                      subject = meanstdData$Subject), mean)
write.table(subjectlabelData, "tidyData.txt", row.names = FALSE, sep = "\t")
