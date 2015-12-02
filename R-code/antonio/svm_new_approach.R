library(dplyr)
library(caret)
library(e1071)

userLogin.0.1 <- read.delim("~/Documents/recogme/recogme/dados_coletados/Dados_CSV/userLogin-0.1.psv", quote="")
userLogin.0.1 <- userLogin.0.1 %>% select(-attempt_time)

get_latency <- function (user){
  user <- arrange(user, keyUp)
  user$latency <- 0
  for (i in 2:nrow(user)) {
    user[i,]$latency <- user[i,]$keyDown - user[i-1,]$keyUp
  }
  return (user);
}

holdTime <- function(user){
  user$holdTime = user$keyUp - user$keyDown
  return (user);
}

userLogin_features <- userLogin.0.1 %>% group_by(email, source, attempt_id) %>% do(holdTime(.)) %>% do(get_latency(.)) 

features <- as.data.frame(userLogin_features) %>% select(-keyValue, -keyDown, -keyUp)

features$attempt_id <- as.factor(features$attempt_id)
features$keyCode <- as.factor(features$keyCode)
summary(features)
str(features)

#features_email <- features %>% filter(source == "email") %>% select(-source)


features_summarised <- features %>% group_by(attempt_id, email, source, keyCode) %>% 
                                   summarise(mean_holdtime = mean(holdTime), mean_latency = mean(latency))

features_summarised <- as.data.frame(features_summarised) %>% select(-attempt_id)


trainIndex <- createDataPartition(features_summarised$email, p = .8, list = FALSE, times = 1)
dfTrain <- features_summarised[trainIndex,]
dfTest <- features_summarised[-trainIndex,]



svm_model <- svm(dfTrain$email~., dfTrain)
summary(svm_model)

prediction <- predict(svm_model, dfTest)

resp <- table(prediction, dfTest$email)
View(resp)

confusionMatrix(resp)
