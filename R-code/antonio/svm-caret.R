library(dplyr)
library(caret)
require(kernlab)

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
                tuneLength = 8, 
                metric = "Accuracy") 
svmFit
plot(svmFit)


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
treeFit <- train(V1.x ~ ., data = dados.train,
                 method = "C5.0",
                 trControl = fitControl,
                 tuneGrid=expand.grid(model = "tree", winnow = FALSE, trials = c(1:10)))

treeFit
plot(treeFit)
