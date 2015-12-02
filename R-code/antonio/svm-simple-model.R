library(dplyr)
library(caret)
library( 'e1071' )

dados.train <- read.delim("~/Documents/recogme/recogme/R-code/antonio/dados-train.psv", quote="")

#dados.train <- dados.train[complete.cases(dados.train),]
#dados.train <- dados.train %>% filter(V1.x != "arthur.senaufcg@gmail.com", V1.x != "orion.lima@ccc.ufcg.edu.br") %>% droplevels()
#levels(dados.train$V1.x)
#length(levels(dados.train$V1.x))

dados.train[is.na(dados.train)] <- 0

str(dados.train)
summary(dados.train)

model <- svm( dados.train$V1.x~., dados.train)

dados.teste <- read.delim("~/Documents/recogme/recogme/R-code/antonio/dados-teste.psv")
dados.teste[is.na(dados.teste)] <- 0
#dados.teste <- droplevels(dados.teste[complete.cases(dados.teste),])
levels(dados.teste$V1.x)
length(levels(dados.teste$V1.x))

test <- select(dados.teste, -V1.x)

prediction <- predict(model, test)

resp <- table(prediction, dados.teste$V1.x)
View(resp)
confusionMatrix(resp)

matches <- as.data.frame(resp) %>% filter(Freq == 1)
true_matches <- matches %>% filter(prediction == Var2)
false_matches <- matches %>% filter(prediction != Var2)

write.table(true_matches, "true_matches-email-text.csv",quote = FALSE, row.names = FALSE)
write.table(false_matches, "false_matches-email-text.csv",quote = FALSE, row.names = FALSE)

