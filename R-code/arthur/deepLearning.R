library(h2o)
library(plyr)
library(dplyr)
library(caret)

localH2O <- h2o.init(ip = "localhost", port = 54321, startH2O = TRUE)


######## USING IRIS DATA ################
# prosPath = system.file("extdata", "/local/iris.csv", package = "h2o")
# iris.hex <-  h2o.uploadFile(localH2O, path = system.file("extdata", "/local/iris.csv", package="h2o"), destination_frame = "iris.hex")

inTraining <- createDataPartition(iris$Species, p = .75, list = FALSE)
training <- iris[ inTraining,]
testing  <- iris[-inTraining,]

iris.hex = h2o.uploadFile(path = system.file("extdata", "iris_wheader.csv", package="h2o"), destination_frame = "iris.hex")
iris.hex_tr <- as.h2o(training)
iris.hex_te <- as.h2o(testing[,-5])

model <- h2o.deeplearning(
    x = 1:4, y = 5,
    training_frame = iris.hex_tr,
    activation = "Tanh", hidden = c(10, 10, 10), epochs = 10000
  )

predictions = predict(object = model, newdata = iris.hex_te)
predictions.result = as.data.frame(predictions)
resp <- table(predictions.result$predict, testing$Species)
View(resp)
# perf <- h2o.performance(model, iris.hex[,5])
# h2o.accuracy(perf)


######USING RECOGME DATA ###################33

dados.train <- read.delim("/local/recogme/R-code/antonio/dados-train.psv")
dados.teste <- read.delim("/local/recogme/R-code/antonio/dados-teste.psv")

#Dataset ruim - NAO USAR pra treinar o modelo
# dfTrain<- read.delim("~/treino_ricardo2.psv", header=FALSE)
# dfTest<- read.delim("~/teste_ricardo2.psv", header=FALSE)


df <- rbind(dados.train, dados.teste)

inTraining <- createDataPartition(df$V1.x, p = .75, list = FALSE)
training <- df[ inTraining,]
testing  <- df[-inTraining,]

# df <- rbind(dados.train, dados.teste)
# df <- df %>% arrange(V1.x)
# df <- df %>% filter(V1.x != "talitabac@gmail.com") %>% droplevels() #fez um attempt em uma máquina diferente.
# df <- df[sample(nrow(df)),]
# 
# df$id <- 1:nrow(df)
# dfTrain <- ddply(df,.(V1.x), function(x) head(x, 2))
# dfTest <- df[!(df$id %in% dfTrain$id),]
# dfTrain$id <- NULL
# dfTest$id <- NULL

###############TRAINING MODEL#######################
time <- proc.time()
dfTrain.hex <- as.h2o(training)
model <- h2o.deeplearning(
  x = 2:68, y = 1,
  training_frame = dfTrain.hex,
  activation = "Tanh", hidden = c(512, 512, 512), epochs = 10000
)

model <- h2o.deeplearning(
  x = 2:68, y = 1,
  training_frame = dfTrain.hex,
  activation = "RectifierWithDropout",
  input_dropout_ratio = 0.2,
  hidden_dropout_ratios = c(0.5,0.5,0.5),
  balance_classes = TRUE, 
  hidden = c(800,800,800),
  epochs = 500
)

model = h2o.randomForest(y = 1, x = 2:68, training_frame = dfTrain.hex, ntrees = 50, max_depth = 100)

time <- proc.time() - time

summary(model)

##################PREDICITING MODEL###################
dfTest[is.na(dfTest)] <- 0
testing[is.na(testing)] <- 0

teste <- select(dfTest, -V1.x)
dfTest.hex <- as.h2o(testing[,-1])

predictions <- h2o.predict(object = model, newdata = dfTest.hex,)

predictions.result = as.data.frame(predictions)
resp <- table(predictions.result$predict, testing$V1.x)
confusionMatrix(resp)

View(resp)
View(filter(as.data.frame(resp), Freq != 0))
View(filter(as.data.frame(resp), Freq != 0, as.character(Var1) == as.character(Var2)))
View(filter(as.data.frame(resp), Freq != 0, as.character(Var1) != as.character(Var2)))

# perf <- h2o.performance(model = model, data = dfTest.hex$V1.x)
cm<- h2o.confusionMatrix(predictions$predict, dfTest.hex)

cm<- h2o.confusionMatrix(predictions$predict)

View(cm)
auc  = h2o.auc(perf)
