library(dplyr)
library(caret)
library(plyr)
library(randomForest)

dados.train <- read.delim("~/Documents/recogme/recogme-R-antonio/train.subset.psv")
dados.teste <- read.delim("~/Documents/recogme/recogme-R-antonio/test.subset.psv")

df <- rbind(dados.train, dados.teste)
df <- df %>% filter(email != "talitabac@gmail.com") %>% droplevels() #fez um attempt em uma máquina diferente.
df <- df[sample(nrow(df)),]

#separa em treino e teste. o treino fica com dois attempts por usuário.
df$id <- 1:nrow(df)
dfTrain <- ddply(df,.(email), function(x) head(x, 2))
dfTest <- df[!(df$id %in% dfTrain$id),]
dfTrain$id <- NULL
dfTest$id <- NULL


#inputs
train = dfTrain
k = 20
email_user = "carolzinhacabral@gmail.com" #teste de modelo para este usuário
attempts = train %>% filter(email == email_user)
attempts = attempts$attempt_id

att.email = data.frame("attempt_id" = train$attempt_id, "email" = train$email)
train$attempt_id = NULL
train$email = NULL

cl = kmeans(train, centers = k)

clusters = data.frame(att.email, "cluster" = cl$cluster)
row.names(clusters) = NULL

train = data.frame("attempt_id" = att.email$attempt_id,  "email" = att.email$email, train)

cluster = clusters[is.element(clusters$cluster, clusters[is.element(clusters$attempt_id, attempts),]$cluster),]$attempt_id

cluster_members = train[is.element(train$attempt_id, cluster),]

cluster_members$true_user <- ifelse(cluster_members$email == email_user, 1, 0)
cluster_members$email = NULL
cluster_members$attempt_id = NULL

dfTest$true_user <- ifelse(dfTest$email == email_user, 1, 0)
dfTest$attempt_id <- NULL
dfTest$email <- NULL

cluster_members$true_user <- as.factor(cluster_members$true_user) #transformar a variável resposta em factor


model <- train( true_user ~ . ,data = cluster_members, method = "rf", trControl = trainControl(method = "oob"))
model

dfTest[is.na(dfTest)] <- 0
dfTest$true_user <- as.factor(dfTest$true_user)

teste <- select(dfTest, -true_user)

prediction <- predict(model, teste)

resp <- table(prediction, dfTest$true_user)
View(resp)
confusionMatrix(resp)

matches <- as.data.frame(resp) %>% filter(Freq != 0)
true_matches <- matches %>% filter(prediction == Var2)
false_matches <- matches %>% filter(prediction != Var2)

false_negative <- matches %>% filter(prediction == Var2, Freq == 0)

plot(varImp(model))
