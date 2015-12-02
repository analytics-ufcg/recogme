library(dplyr)
library(caret)
require(kernlab)
require(pROC)

dados.train <- read.delim("~/Documents/recogme/recogme/R-code/antonio/dados-train.psv", quote="")
dados.train[is.na(dados.train)] <- 0

fitControl <- trainControl(## 10-fold CV
  method = "cv",
  number = 10)

library(plyr)
dados.train <- ddply(dados.train,.(V1.x), function(x) head(x, 2))


treeFit <- train(V1.x ~ ., data = dados.train,
                 method = "C5.0",
                 trControl = fitControl,
                 tuneGrid=expand.grid(model = "tree", winnow = FALSE, trials = c(1:10)))

treeFit
plot(treeFit)

dados.teste <- read.delim("~/Documents/recogme/recogme/R-code/antonio/dados-teste.psv")
dados.teste[is.na(dados.teste)] <- 0
test <- select(dados.teste, -V1.x)

prediction_rf <- predict(treeFit, test)

resp_rf <- table(prediction_rf, dados.teste$V1.x)
View(resp_rf)
confusionMatrix(resp_rf)

matches <- as.data.frame(resp_rf) %>% filter(Freq == 1)
true_matches <- matches %>% filter(prediction_rf == Var2)
false_matches <- matches %>% filter(prediction_rf != Var2)
plot(varImp(treeFit))

