library(dplyr, quietly = TRUE)

userLogin.noBackSpace <- read.delim("~/Documents/recogme/recogme-R/userLogin-noBackSpace.psv")

summary(userLogin.noBackSpace)

userPasswords <- userLogin.noBackSpace %>% filter(source == "password")

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

userPasswords <- get_latency(userPasswords)
userPasswords <- holdTime(userPasswords)

get_top_6 <- function(data){
  return (data[1:6,])
}

get_top_6_by_attempt <- function (data){
  library(dplyr, quietly = TRUE)
  detach("package:dplyr", unload=TRUE)
  library(plyr, quietly = TRUE)
  resp <- ddply(data, "attempt_id", get_top_6)
  detach("package:plyr", unload=TRUE)
  library(dplyr, quietly = TRUE)
  return (resp)
}


user_ricardo <- userPasswords %>% filter(email == "ricooliveira@gmail.com")  
detach("package:dplyr", unload=TRUE)
library(plyr, quietly = TRUE)
user_ricardo <- ddply(user_ricardo, "attempt_id", get_top_6)

users_passwords_6_char <- get_top_6_by_attempt(userPasswords)

data <- user_ricardo %>% filter(attempt_id == 1)
get_features <- function(data){
    library(dplyr, quietly = T)
    data_t <- data %>% select(latency, holdTime)
    data_t <- t(data_t)
    
    Flatencies <- data.frame(Fpw_latency1 = data_t[1,2], Fpw_latency2 = data_t[1,3], 
                       Fpw_latency3 = data_t[1,4], Fpw_latency4 = data_t[1,5], Fpw_latency5 = data_t[1,6])
    
    FholdTimes <- data.frame(Fpw_holdtime1 = data_t[2,1],
                             Fpw_holdtime2 = data_t[2,2], 
                             Fpw_holdtime3 = data_t[2,3], 
                             Fpw_holdtime4 = data_t[2,4], 
                             Fpw_holdtime5 = data_t[2,5], 
                             Fpw_holdtime6 = data_t[2,6])
  
    resp <- cbind(email = data$email,Flatencies, FholdTimes)
    return (resp);
}

library(plyr)
test_get_features <- ddply(users_passwords_6_char, "attempt_id",get_features) 
test_get_features <- data.frame(unique(test_get_features))

write.table(test_get_features, "password-features.csv", quote = FALSE, sep = "\t", col.names = TRUE, row.names = FALSE, fileEncoding = "UTF-8")


