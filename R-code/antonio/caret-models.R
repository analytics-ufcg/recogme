library(dplyr)
library(caret)
require(kernlab)
require(pROC)

dados.train <- read.delim("~/Documents/recogme/recogme/R-code/antonio/dados-train.psv", quote="")

dados.train[is.na(dados.train)] <- 0

str(dados.train)
summary(dados.train)

fitControl <- trainControl(## 10-fold CV
  method = "cv",
  number = 10)

svmFit <- train(V1.x ~ ., data = dados.train,
                method = "svmRadial",
                trControl = fitControl, 
                preProcess = c("center","scale"), 
                tuneLength = 5, 
                metric = "Accuracy") 
svmFit
plot(svmFit)
  plot(varImp(svmFit))


dados.teste <- read.delim("~/Documents/recogme/recogme/R-code/antonio/dados-teste.psv")
dados.teste[is.na(dados.teste)] <- 0

test <- select(dados.teste, -V1.x)

prediction <- predict(svmFit, test)

resp <- table(prediction, dados.teste$V1.x)
View(resp)
confusionMatrix(resp)

#teste com KNN
knnFit <- train(V1.x ~ ., data = dados.train,
                method = "knn",
                trControl = fitControl, 
                preProcess = c("center","scale"), 
                tuneGrid = data.frame(.k = 2:20))
knnFit

prediction <- predict(knnFit, test)

resp <- table(prediction, dados.teste$V1.x)
View(resp)
confusionMatrix(resp)



#Teste com C5.0
treeFit <- train(V1 ~ ., data = dados.train.impute,
                 method = "C5.0",
                 trControl = fitControl,
                 tuneGrid=expand.grid(model = "tree", winnow = FALSE, trials = c(1:10)))

treeFit
plot(treeFit)

prediction_rf <- predict(treeFit, test)

resp_rf <- table(prediction_rf, dados.teste.impute$V1)
View(resp_rf)
confusionMatrix(resp_rf)

matches <- as.data.frame(resp_rf) %>% filter(Freq == 1)

false_matches <- matches %>% filter(prediction_rf != Var2)
plot(varImp(treeFit))
