library(dplyr)
library( 'e1071' )

dados.train <- read.delim("~/Documents/recogme/recogme/R-code/antonio/dados-train.psv", quote="")

dados.train.text <- dados.train %>% select(-V3.x,-V4.x,  -V5.x,  -V6.x,- V7.x,-V8.x,-V9.x,-V10.x, -V11.x, -V12.x, 
                                     -V13.x, -V14.x, -V15.x, -V16.x, -V17.x, -V18.x,-V19.x, -V20.x, -V21.x)

dados.train.text[is.na(dados.train.text)] <- 0
summary(dados.train.text)
str(dados.train.text)

model <- svm( dados.train.text$V1.x~., dados.train.text)

dados.teste <- read.delim("~/Documents/recogme/recogme/R-code/antonio/dados-teste.psv")

dados.text.teste <- dados.teste %>% select(-V3.x,-V4.x,  -V5.x,  -V6.x,- V7.x,-V8.x,-V9.x,-V10.x, -V11.x, -V12.x, 
                                     -V13.x, -V14.x, -V15.x, -V16.x, -V17.x, -V18.x,-V19.x, -V20.x, -V21.x)

dados.text.teste[is.na(dados.text.teste)] <- 0

test <- select(dados.text.teste, -V1.x)

prediction <- predict(model, test)

resp <- table(prediction, dados.teste$V1.x)
View(resp)
confusionMatrix(resp)

matches <- as.data.frame(resp) %>% filter(Freq == 1)
true_matches <- matches %>% filter(prediction == Var2)
false_matches <- matches %>% filter(prediction != Var2)

write.table(true_matches, "true_matches-text.csv",quote = FALSE, row.names = FALSE)
write.table(false_matches, "false_matches-text.csv",quote = FALSE, row.names = FALSE)
