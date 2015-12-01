library(caret)
library(dplyr)
dados.train <- read.delim("~/Documents/recogme/recogme-R-antonio/dados-train.psv")
str(dados.train)

#dados.train <- dados.train[!duplicated(dados.train$V1.x),]

library(plyr)
dados.train <- ddply(dados.train,.(V1.x), function(x) head(x, 2))



#ctrl <- trainControl(method = "cv", number = 10)
#df <- select(dados.train, -V1.x)

dados.train <- dados.train %>% filter(V1.x != "talitabac@gmail.com") %>% droplevels()
levels(dados.train$V1.x)
model <- train( V1.x ~ . ,data = dados.train, method = "rf", trControl = trainControl(method = "oob"), importance = TRUE)
model

dados.teste <- read.delim("~/Documents/recogme/recogme-R-antonio/dados-teste.psv")
dados.teste[is.na(dados.teste)] <- 0
dados.teste <- dados.teste %>% filter(V1.x != "talitabac@gmail.com") %>% droplevels()

teste <- select(dados.teste, -V1.x)

prediction <- predict(model, teste)
resp <- table(prediction, dados.teste$V1.x)
View(resp)
confusionMatrix(resp)

matches <- as.data.frame(resp) %>% filter(Freq == 1)
true_matches <- matches %>% filter(prediction == Var2)
false_matches <- matches %>% filter(prediction != Var2)
plot(varImp(model))

