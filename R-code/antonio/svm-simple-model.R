library( 'e1071' )

dados.train <- read.delim("dados-train.psv")

dados.train <- dados.train[complete.cases(dados.train),]
dados.train <- dados.train %>% filter(V1.x != "arthur.senaufcg@gmail.com", V1.x != "orion.lima@ccc.ufcg.edu.br") %>% droplevels()
levels(dados.train$V1.x)

str(dados.train)
summary(dados.train)

model <- svm( dados.train$V1.x~., dados.train)

dados.teste <- read.delim("dados-teste.psv")
dados.teste <- droplevels(dados.teste[complete.cases(dados.teste),])
levels(dados.teste$V1.x)

test <- select(dados.teste, -V1.x)

prediction <- predict(model, test)

resp <- table(prediction, dados.teste$V1.x)
View(resp)
confusionMatrix(resp)
