library(data.table)
path <- getwd()

## 1. download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="DataFiles.zip")

##2. unzip file
unzip("DataFiles.zip")
setwd("UCI HAR Dataset")
path <- getwd()

##Read files
ActivityTest <- read.table(file.path(path,"test","y_test.txt"),header=FALSE)
ActivityTrain <- read.table(file.path(path,"train","y_train.txt"),header=FALSE)

SubjectTest <- read.table(file.path(path,"test","subject_test.txt"),header=FALSE)
SubjectTrain <- read.table(file.path(path,"train","subject_train.txt"),header=FALSE)

FeaturesTest  <- read.table(file.path(path,"test","X_test.txt"),header=FALSE)
FeaturesTrain <- read.table(file.path(path,"train","X_train.txt"),header=FALSE)

FeaturesNames <- read.table(file.path(path,"features.txt"),header=FALSE)
ActivityLabels <- read.table(file.path(path,"activity_labels.txt"),header=FALSE) 


colnames(ActivityTest)<-"Activity"
colnames(ActivityTrain)<-"Activity"

colnames(SubjectTest)<-"Subject"
colnames(SubjectTrain)<-"Subject"

colnames(FeaturesTest)<- FeaturesNames$V2
colnames(FeaturesTrain)<-FeaturesNames$V2

colnames(ActivityLabels)<-c("Activity","ActivityDescription")

##combined train data and test data
TrainData<-cbind(SubjectTrain,ActivityTrain,FeaturesTrain)
TestData<-cbind(SubjectTest,ActivityTest,FeaturesTest)
data<-rbind(TrainData,TestData)

## only take mean or std columns
data<-data[,c(1,2,grep("mean\\(\\)|std\\(\\)",names(data)))]


## merge data file and activity labels
MergedData<-merge(data,ActivityLabels,by="Activity")

## tidy the name of merged data
names(MergedData)<-gsub("\\(\\)","",names(MergedData))
names(MergedData)<-gsub("-","",names(MergedData)) 
names(MergedData)<-gsub("mean","Mean",names(MergedData))
names(MergedData)<-gsub("std","Std",names(MergedData))
names(MergedData)<-gsub("^t","Time",names(MergedData))
names(MergedData)<-gsub("^f","Frequency",names(MergedData))

## removing the Activity numeber column
TidyData<-MergedData[,-1]
## sort column by subject, activity description, and others
TidyData<-TidyData[c(1,68,2:67)]

write.table(TidyData, file.path(path,"tidydata.txt"))