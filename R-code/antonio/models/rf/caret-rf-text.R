library(dplyr)
library(caret)
library(plyr)
library(randomForest)

#fitControl <- trainControl(method = "cv", number = 10)

dados.train <- read.delim("~/Documents/recogme/recogme-R-antonio/dados-train.psv")
dados.teste <- read.delim("~/Documents/recogme/recogme-R-antonio/dados-teste.psv")

df <- rbind(dados.train, dados.teste)
#df <- df %>% arrange(V1.x)
df <- df[sample(nrow(df)),]
df <- df %>% filter(V1.x != "talitabac@gmail.com") %>% droplevels()

#df_email <- df[,2:20]

df <- df %>% select(-V3.x,-V4.x,-V5.x,-V6.x,-V7.x,-V8.x,-V9.x,-V10.x -V11.x,-V12.x,-V13.x,- V14.x,-V15.x
                         ,-V16.x,-V17.x,-V18.x, -V10.x, -V11.x, -V19.x, -V21.x)

df$id <- 1:nrow(df)
dfTrain <- ddply(df,.(V1.x), function(x) head(x, 2))
dfTest <- df[!(df$id %in% dfTrain$id),]
dfTrain$id <- NULL
dfTest$id <- NULL
#str(dfTrain)

model <- train( V1.x ~ . ,data = dfTrain, method = "rf", trControl =trainControl(method = "oob"), importance = TRUE)
model

dfTest[is.na(dfTest)] <- 0

teste <- select(dfTest, -V1.x)

prediction <- predict(model, teste)

resp <- table(prediction, dfTest$V1.x)
View(resp)
confusionMatrix(resp)

matches <- as.data.frame(resp) %>% filter(Freq != 0)
true_matches <- matches %>% filter(prediction == Var2)
false_matches <- matches %>% filter(prediction != Var2)
plot(varImp(model))

write.table(true_matches, "rf-text-true_matches.csv",fileEncoding = "UTF8", sep=",", row.names = FALSE, quote = FALSE)
write.table(false_matches, "rf-text-false_matches.csv",fileEncoding = "UTF8", sep=",", row.names = FALSE, quote = FALSE)



