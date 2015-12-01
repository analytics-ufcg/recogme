library(caret)
#library(dplyr)
dados.train <- read.delim("~/Documents/recogme/recogme-R-antonio/dados-train.psv")
str(dados.train)

ctrl <- trainControl(method = "cv", number = 10)

#df <- select(dados.train, -V1.x)

model <- train( V1.x ~ . ,data = dados.train, method = "rf", trControl = ctrl)
model

dados.teste <- read.delim("~/Documents/recogme/recogme-R-antonio/dados-teste.psv")
dados.teste[is.na(dados.teste)] <- 0

teste <- select(dados.teste, -V1.x)

prediction <- predict(model, teste)
resp <- table(prediction, dados.teste$V1.x)
View(resp)
confusionMatrix(resp)

matches <- as.data.frame(resp) %>% filter(Freq == 1)
true_matches <- matches %>% filter(prediction == Var2)
false_matches <- matches %>% filter(prediction != Var2)
plot(varImp(model))

