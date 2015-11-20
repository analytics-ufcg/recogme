library(dplyr, quietly = TRUE)
library(ggplot2, quietly = TRUE)

userLogin <- read.delim("~/Documents/recogme/recogme/dados_coletados/Dados_CSV/userLogin-formated.psv", quote="")
summary(userLogin)

user_antonio <- userLogin %>% filter(email == "antonioricardojr@gmail.com")
summary(user_antonio)

#Total de teclas pressionadas por attempt para um usuário
user_attempts <- user_antonio %>% group_by(attempt_id) %>% summarise(count=n()) 
ggplot(data=user_attempts,aes(factor(attempt_id), count)) + geom_bar(stat="identity") + theme_bw()

#Total de teclas pressionadas por attempt para um usuário
user_attempts_by_source <- user_antonio %>% group_by(attempt_id, source) %>% summarise(count=n())
ggplot(data=user_attempts_by_source,
       aes(factor(attempt_id), count, fill=factor(source))) + geom_bar(stat="identity") + theme_bw()


###Derivando variaveis

###Keypressed - Tempo que uma tecla fica sob pressão.
user_antonio$keyPressed <- user_antonio$keyUp - user_antonio$keyDown

#Sumário de keyPressed para a tecla A (keycode 65)
a <- user_antonio %>% filter(keyCode == 65)
summary(a$keyPressed)

#Média dos tempos em que as teclas ficam pressionadas (keyPressedMean) 
user_login_keystroke <- user_antonio %>% group_by(keyCode, keyValue) %>% 
                  summarise(keyPressedMean = mean(keyPressed))

user_login_keystroke <- user_login_keystroke[order(desc(user_login_keystroke$keyPressedMean)),]

ggplot(user_login_keystroke, aes(x=factor(reorder(keyValue, -keyPressedMean)), y=keyPressedMean)) +
                                geom_bar(stat="identity") + labs(x="Keys", y="KeyPressed Mean")  + theme_bw() 


user_carol <- userLogin %>% filter(email == "carolzinhacabral@gmail.com")
user_carol <- latency(user_carol)
# Funcão que gera a feature latency para um dado usuário.
latency <- function (user){
  user$latency <- 0
  user$keyDownLatency <- 0
  user$keyUpLatency <- 0
  for (i in 2:nrow(user)){
    user[i,]$latency <- user[i,]$keyDown - user[i-1,]$keyUp
    #user[i,]$keyDownLatency <- user[i,]$keyDown - user[i-1,]$keyDown
    user[i,]$keyUpLatency <- user[i,]$keyUp - user[i-1,]$keyUp
    
    user_temp <- arrange(user, keyDown)
    user_
    #user[i,]$keyDownLatency <- 
  }
  return (user);
}



a <- function(nome, numero){
  
  return (user_antonio[nome]);
}

a("holdTime", 10)


