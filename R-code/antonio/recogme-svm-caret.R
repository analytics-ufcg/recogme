library(caret, quietly = T)

require(GGally, quietly = T)

features_login_frase <- read.delim("~/Documents/recogme/recogme-R/features_login_frase.psv", header=FALSE, quote="")

summary(features_login_frase)


set.seed(825)

fitControl <- trainControl(## 10-fold CV
  method = "repeatedcv",
  number = 10,
  ## repeated ten times
  repeats = 10)

svmFit <- train(V1 ~ ., data = features_login_frase[,1:5],
                #method = "svmRadial",
                trControl = fitControl,
                preProc = c("center", "scale"),
                tuneLength = 8
                #metric = "ROC"
                )
