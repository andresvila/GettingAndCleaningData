library(reshape2)

fileName<-"X_test.txt"
XTest <- read.table(fileName, sep = "" , header = FALSE)

fileName<-"subject_test.txt"
subTest <- read.table(fileName, sep = "" , header = FALSE)


fileName<-"y_test.txt"
yTest <- read.table(fileName, sep = "" , header = FALSE)


fileName<-"X_train.txt"
XTrain <- read.table(fileName, sep = "" , header = FALSE)

fileName<-"subject_train.txt"
subTrain <- read.table(fileName, sep = "" , header = FALSE)

fileName<-"y_train.txt"
yTrain <- read.table(fileName, sep = "" , header = FALSE)



subTotal<-rbind(subTest,subTrain)
ytotal<-rbind(yTest,yTrain)
dataTotal<-rbind(XTest,XTrain)

dataTotal$subject<-subTotal$V1
dataTotal$activity<-ytotal$V1

dataTotal$activity<-factor(dataTotal$activity)

levels(dataTotal$activity)<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

fileName<-"features.txt"
features <- read.table(fileName, sep = "" , header = FALSE)

columnNames<-c(as.character(features$V2),"subject","activity")

colnames(dataTotal)<-columnNames


tidyData<-dataTotal[,c(grep("mean\\()",columnNames),grep("std()",columnNames),562,563)]


dataMelt<-melt(tidyData,id=c("subject","activity"),measure.valrs=colnames(tidyData)[1:dim(tidyData)[2]])

tidiestData<-dcast(dataMelt,activity+subject~variable,mean)

write.table(tidiestData,"tidyData.txt",row.name=FALSE)


