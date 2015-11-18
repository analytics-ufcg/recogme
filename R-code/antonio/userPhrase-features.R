library(dplyr, quietly = TRUE)

userLogin_v1 <- read.delim("~/Documents/recogme/recogme-R/userLogin_v1.csv", quote="")

userLogin_v1 <- userLogin_v1 %>% select(-attempt_time,-latencyKeyUp, -latencyKeyDown, -latencySortedByKeyUp, -latencySortedByKeyDown)

userPhrases <- userLogin_v1 %>% filter(source == "userText",keyValue != "Backspace") %>% select(-source)

userPhrase_alberto <- userPhrases %>% filter(email == "albertofagner.cav@gmail.com", keyValue != "Backspace")


#Calcula os percentis para um dataset.
percentis <- function (data){

  data$cent <- 0
  data$half <- 0
  data$quarter <- 0

  resp <- data[0,]
  
  for (id in unique(data$attempt_id)){
    attempt <- data %>% filter(attempt_id == id)
    
    attempt$cent <- rep(100, nrow(attempt))
    
    attempt[1:floor(0.5*nrow(attempt)),]$half <- 50
    attempt[(floor(0.5*nrow(attempt))+1):nrow(attempt),]$half <- 100
    
    attempt[1:floor(0.25*nrow(attempt)),]$quarter <- 25
    attempt[(floor(0.25*nrow(attempt))+1):floor(0.5*nrow(attempt)),]$quarter <- 50
    attempt[(floor(0.5*nrow(attempt))+1):floor(0.75*nrow(attempt)),]$quarter <- 75
    attempt[(floor(0.75*nrow(attempt))+1):nrow(attempt),]$quarter <- 100
    
    
    resp <- rbind(resp, attempt) 
  }
  
  return (resp);
}

percentis_for_all_users <- function(users){
  users$cent <- 0
  users$half <- 0
  users$quarter <- 0
  
  resp <- users[0,]
  
  for (e in unique(users$email)){
    user <- users %>% filter(email == e)
    user <- percentis(user)
    resp <- rbind(resp, user)
  }
  
  return (resp);
}

userPhrases_p <- percentis_for_all_users(userPhrases)


data <- userPhrases_p
latency_by_percentis <- function (data){
  resp <- data.frame(attempt_id = numeric(), email = character() , quarter = numeric(), half = numeric(), cent = numeric())
  
  for (e in unique(data$email)){
    user <- data %>% filter(email == e)
    for (a in unique(user$attempt_id)){
      attempt <- user %>% filter(attempt_id == a)
      quarter <- attempt %>% group_by(quarter) %>% summarise(latency_quarter = max(keyDown) - min(keyUp))
      half <- attempt %>% group_by(half) %>% summarise(latency_half = max(keyDown) - min(keyUp))
      cent <- attempt %>% group_by(cent) %>% summarise(latency_cent = max(keyDown) - min(keyUp))
      user <- data.frame(attempt_id = a, email = e, quarter, half, cent)
      resp <- rbind(resp, user)
    }
  }
  return (resp);
}

test_out <- latency_by_percentis(data)
