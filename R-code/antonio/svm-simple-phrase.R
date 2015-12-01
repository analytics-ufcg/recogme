library(dplyr)
library( 'e1071' )
library(caret)

dados.train <- read.delim("~/Documents/recogme/recogme-R-antonio/dados-train.psv")
dados.teste <- read.delim("~/Documents/recogme/recogme-R-antonio/dados-teste.psv")


df <- rbind(dados.train, dados.teste)
df <- df[sample(nrow(df)),]
df$V1.x <- as.factor(df$V1.x)

#df <- df[complete.cases(df),]
#df <- droplevels(df)

trainIndex <- createDataPartition(df$V1.x, p = .8, list = FALSE, times = 1)

dfTrain <- df[trainIndex,]
dfTest <- df[-trainIndex,]
summary(dfTest)


svm_model <- svm(dfTrain$V1.x~., dfTrain)

dfTest <- dfTest[complete.cases(dfTest),]
test <- select(dfTest, -V1.x)

prediction <- predict(svm_model, test)
resp <- table(prediction, dfTest$V1.x)
View(resp)

confusionMatrix(resp)
