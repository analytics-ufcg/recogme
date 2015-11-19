library(dplyr, quietly = TRUE)

userLogin.noBackSpace <- read.delim("~/Documents/recogme/recogme-R-antonio/userLogin-noBackSpace.psv")
userEmails <- userLogin.noBackSpace %>% filter(source == "email")

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

userEmails_10_first_char <- userEmails %>% get_latency() %>% holdTime() %>% group_by(attempt_id) %>% slice(1:10)

get_features <- function(data){
  data_t <- data %>% select(latency, holdTime)
  data_t <- t(data_t)
  
  Flatencies <- data.frame(Femail_latency1 = data_t[1,2], Femail_latency2 = data_t[1,3], 
                           Femail_latency3 = data_t[1,4], Femail_latency4 = data_t[1,5], 
                           Femail_latency5 = data_t[1,6], Femail_latency6 = data_t[1,7], 
                           Femail_latency7 = data_t[1,8], Femail_latency8 = data_t[1,9],
                           Femail_latency9 = data_t[1,10])
  
  FholdTimes <- data.frame(Femail_holdtime1 = data_t[2,1],
                           Femail_holdtime2 = data_t[2,2], 
                           Femail_holdtime3 = data_t[2,3], 
                           Femail_holdtime4 = data_t[2,4], 
                           Femail_holdtime5 = data_t[2,5], 
                           Femail_holdtime6 = data_t[2,6],
                           Femail_holdtime7 = data_t[2,7],
                           Femail_holdtime8 = data_t[2,8],
                           Femail_holdtime9 = data_t[2,9],
                           Femail_holdtime10 = data_t[2,10])
  
  resp <- cbind(Flatencies, FholdTimes, row.names = NULL)
  return (resp);
}

#removendo attempt 48 e 76, pois os usuários utilizaram o autocompletar no campo email,
#o que impossibilitou o registro mínimo de 10 caracteres.
userEmails_10_first_char <- userEmails_10_first_char %>% filter(attempt_id != 48 & attempt_id != 76)

email_features <- userEmails_10_first_char %>% group_by(email, attempt_id) %>% do(get_features(.))

write.table(email_features, file="email_features.psv", quote = FALSE, sep = "\t", row.names = FALSE, fileEncoding = "UTF-8")
