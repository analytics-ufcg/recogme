library(dplyr)
library( 'e1071' )
library(caret)


dados.train <- read.delim("~/Documents/recogme/recogme/R-code/antonio/dados-train.psv", quote="")

dados.train.email <- dados.train %>% select(V1.x,V3.x,V4.x,  V5.x,  V6.x, V7.x,V8.x,V9.x,V10.x, V11.x, V12.x, 
                                           V13.x, V14.x, V15.x, V16.x, V17.x, V18.x,V19.x, V20.x, V21.x)

summary(dados.train.email)

svm_model <- svm(dados.train.email$V1.x~., dados.train.email)

dados.teste <- read.delim("~/Documents/recogme/recogme/R-code/antonio/dados-teste.psv")

dados.text.teste <- dados.teste %>% select(V1.x,V3.x,V4.x,  V5.x,  V6.x, V7.x,V8.x,V9.x,V10.x, V11.x, V12.x, 
                                           V13.x, V14.x, V15.x, V16.x, V17.x, V18.x,V19.x, V20.x, V21.x)

test <- select(dados.text.teste, -V1.x)

prediction <- predict(svm_model, test)
resp <- table(prediction, dados.text.teste$V1.x)
View(resp)

confusionMatrix(resp)

matches <- as.data.frame(resp) %>% filter(Freq == 1)
true_matches <- matches %>% filter(prediction == Var2)
false_matches <- matches %>% filter(prediction != Var2)

write.table(true_matches, "true_matches-email.csv",quote = FALSE, row.names = FALSE)
write.table(false_matches, "false_matches-email.csv",quote = FALSE, row.names = FALSE)
