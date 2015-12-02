library(h2o)
library(plyr)
library(dplyr)


localH2O <- h2o.init(ip = "localhost", port = 54321, startH2O = TRUE)


######## USING IRIS DATA ################
prosPath = system.file("extdata", "/local/iris.csv", package = "h2o")

iris.hex <-  h2o.uploadFile(localH2O, path = system.file("extdata", "/local/iris.csv", package="h2o"), destination_frame = "iris.hex")
iris.hex = h2o.uploadFile(path = system.file("extdata", "iris_wheader.csv", package="h2o"), destination_frame = "iris.hex")

model = h2o.deeplearning(x = setdiff(colnames(prostate.hex), c("ID","CAPSULE")), y = "CAPSULE", 
                         training_frame = prostate.hex, activation = "Tanh", hidden = c(10, 10, 10), epochs = 10000)


model <- h2o.deeplearning(
    x = 1:4, y = 5,
    training_frame = iris.hex
  )


perf <- h2o.performance(model, iris.hex[,5])
h2o.accuracy(perf)


######USING RECOGME DATA ###################33

dados.train <- read.delim("/local/recogme/R-code/antonio/dados-train.psv")
dados.teste <- read.delim("/local/recogme/R-code/antonio/dados-teste.psv")

df <- rbind(dados.train, dados.teste)
df <- df %>% arrange(V1.x)
df <- df %>% filter(V1.x != "talitabac@gmail.com") %>% droplevels() #fez um attempt em uma máquina diferente.
df <- df[sample(nrow(df)),]

df$id <- 1:nrow(df)
dfTrain <- ddply(df,.(V1.x), function(x) head(x, 2))
dfTest <- df[!(df$id %in% dfTrain$id),]
dfTrain$id <- NULL
dfTest$id <- NULL

###############TRAINING MODEL#######################
time <- proc.time()
dfTrain.hex <- as.h2o(dfTrain)
model <- h2o.deeplearning(
  x = 2:68, y = 1,
  training_frame = dfTrain.hex,
  activation = "Tanh", hidden = c(10, 10, 10), epochs = 10000
)
time <- proc.time() - time

summary(model)

##################PREDICITING MODEL###################
dfTest[is.na(dfTest)] <- 0

teste <- select(dfTest, -V1.x)
dfTest.hex <- as.h2o(dfTest)

predictions <- h2o.predict(object = model, newdata = dfTest.hex[,-1],)
# perf <- h2o.performance(model = model, data = dfTest.hex$V1.x)
cm<- h2o.confusionMatrix(predictions$predict, dfTest.hex)

cm<- h2o.confusionMatrix(predictions$predict)

View(cm)
auc  = h2o.auc(perf)
