library(dplyr)
library(caret)
library(plyr)

dados.train <- read.delim("/local/recogme/R-code/antonio/dados-train.psv")
dados.teste <- read.delim("/local/recogme/R-code/antonio/dados-teste.psv")

df <- rbind(dados.train, dados.teste)
df <- df[,1:20]
#df <- df %>% arrange(V1.x)

df <- df %>% filter(V1.x != "talitabac@gmail.com") %>% droplevels()
df <- df[sample(nrow(df)),]


df$id <- 1:nrow(df)
dfTrain <- ddply(df,.(V1.x), function(x) head(x, 2))
dfTest <- df[!(df$id %in% dfTrain$id),]
dfTrain$id <- NULL
dfTest$id <- NULL

time <- proc.time()
model <- train( V1.x ~ . ,data = dfTrain, method = "svmRadial", trControl = trainControl(method = "cv", number = 10), importance = TRUE)
time <- proc.time() - time
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

write.table(true_matches, "rf-email-true_matches.csv",fileEncoding = "UTF8", sep=",", row.names = FALSE, quote = FALSE)
write.table(false_matches, "rf-email-false_matches.csv",fileEncoding = "UTF8", sep=",", row.names = FALSE, quote = FALSE)

