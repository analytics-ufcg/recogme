require(dplyr)

userLogin.noBackSpace <- read.delim("~/Documents/recogme/recogme-R-antonio/userLogin-noBackSpace.psv")


usersText <- userLogin.noBackSpace %>% filter(source == "userText")

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

usersText <- usersText %>% get_latency() %>% holdTime() %>% filter(attempt_id != 48 & attempt_id != 76)


get_features <- function(data){
  data_t <- data %>% select(latency ,holdTime) %>% t()
  latencies <- t(data_t[1,2:53])
  holdtimes <- t(data_t[2,])
  
  Fholdtimes <- data.frame(holdtimes)
  
  colnames(Fholdtimes) <- c("Ftext_holdtime1","Ftext_holdtime2","Ftext_holdtime3","Ftext_holdtime4","Ftext_holdtime5",
                            "Ftext_holdtime6","Ftext_holdtime7","Ftext_holdtime8","Ftext_holdtime9","Ftext_holdtime10",
                            "Ftext_holdtime11","Ftext_holdtime12","Ftext_holdtime13","Ftext_holdtime14","Ftext_holdtime15",
                            "Ftext_holdtime16","Ftext_holdtime17","Ftext_holdtime18","Ftext_holdtime19","Ftext_holdtime20",
                            "Ftext_holdtime21","Ftext_holdtime22","Ftext_holdtime23","Ftext_holdtime24","Ftext_holdtime25",
                            "Ftext_holdtime26","Ftext_holdtime27","Ftext_holdtime28","Ftext_holdtime29","Ftext_holdtime30",
                            "Ftext_holdtime31","Ftext_holdtime32","Ftext_holdtime33","Ftext_holdtime34","Ftext_holdtime35",
                            "Ftext_holdtime36","Ftext_holdtime37","Ftext_holdtime38","Ftext_holdtime39","Ftext_holdtime40",
                            "Ftext_holdtime41","Ftext_holdtime42","Ftext_holdtime43","Ftext_holdtime44","Ftext_holdtime45",
                            "Ftext_holdtime46","Ftext_holdtime47","Ftext_holdtime48","Ftext_holdtime49","Ftext_holdtime50",
                            "Ftext_holdtime51","Ftext_holdtime52","Ftext_holdtime53")
  
  
  Flatencies <- data.frame(latencies)
  colnames(Flatencies) <- c("Ftext_latency1","Ftext_latency2","Ftext_latency3","Ftext_latency4","Ftext_latency5",
                            "Ftext_latency6","Ftext_latency7","Ftext_latency8","Ftext_latency9","Ftext_latency10",
                            "Ftext_latency11","Ftext_latency12","Ftext_latency13","Ftext_latency14","Ftext_latency15",
                            "Ftext_latency16","Ftext_latency17","Ftext_latency18","Ftext_latency19","Ftext_latency20",
                            "Ftext_latency21","Ftext_latency22","Ftext_latency23","Ftext_latency24","Ftext_latency25",
                            "Ftext_latency26","Ftext_latency27","Ftext_latency28","Ftext_latency29","Ftext_latency30",
                            "Ftext_latency31","Ftext_latency32","Ftext_latency33","Ftext_latency34","Ftext_latency35",
                            "Ftext_latency36","Ftext_latency37","Ftext_latency38","Ftext_latency39","Ftext_latency40",
                            "Ftext_latency41","Ftext_latency42","Ftext_latency43","Ftext_latency44","Ftext_latency45",
                            "Ftext_latency46","Ftext_latency47","Ftext_latency48","Ftext_latency49","Ftext_latency50",
                            "Ftext_latency51","Ftext_latency52")
  
  resp <- cbind(Flatencies, Fholdtimes, row.names = NULL)
  
  return (resp);
}

userTest <- usersText %>% filter(attempt_id == 25)
resp <- get_features(userTest)


usersText-features <- usersText %>% group_by(email, attempt_id) %>% do(get_features(.))
