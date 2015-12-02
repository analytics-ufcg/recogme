library(dplyr)
library(caret)
library(plyr)
library(randomForest)


set.seed(345)
dados.train <- read.delim("~/Documents/recogme/recogme-R-antonio/train.subset.psv")
dados.train <- dados.train %>% select(-attempt_id)
dados.teste <- read.delim("~/Documents/recogme/recogme-R-antonio/test.subset.psv")
dados.teste <- dados.teste %>% select(-attempt_id)

df <- rbind(dados.train, dados.teste)
#df <- df %>% arrange(V1.x)
df <- df %>% filter(email != "talitabac@gmail.com") %>% droplevels() #fez um attempt em uma máquina diferente.
df <- df[sample(nrow(df)),]

df$id <- 1:nrow(df)
dfTrain <- ddply(df,.(email), function(x) head(x, 2))
dfTest <- df[!(df$id %in% dfTrain$id),]
dfTrain$id <- NULL
dfTest$id <- NULL


model <- train( email ~ . ,data = dfTrain, method = "rf", trControl = trainControl(method = "oob"))
model

dfTest[is.na(dfTest)] <- 0

teste <- select(dfTest, -email)

prediction <- predict(model, teste)

resp <- table(prediction, dfTest$email)
View(resp)
confusionMatrix(resp)

matches <- as.data.frame(resp) %>% filter(Freq != 0)
true_matches <- matches %>% filter(prediction == Var2)
false_matches <- matches %>% filter(prediction != Var2)

false_negative <- matches %>% filter(prediction == Var2, Freq == 0)

plot(varImp(model))


write.table(true_matches, "rf-email-text-true_matches.csv",fileEncoding = "UTF8", sep=",", row.names = FALSE, quote = FALSE)
write.table(false_matches, "rf-email-text-false_matches.csv",fileEncoding = "UTF8", sep=",", row.names = FALSE, quote = FALSE)
