data <- read.delim("~/development/recogme/dados_coletados/Dados_CSV/userLogin-formated.psv", quote="")

options(scipen=999)

data$keyDown = as.numeric(data$keyDown)
data$keyUp = as.numeric(data$keyUp)
data$attempt_time = as.numeric(data$attempt_time)
data$email = as.character(data$email)

data.email = data[data$source == "email",]
data.password = data[data$source == "password",]
data.text = data[data$source == "userText",]

###VELOCIDADE MEDIA DOS USUARIOS DIGITANDO EMAIL###
#delta.t
attempt_id.email.min.kdown = aggregate(keyDown ~ attempt_id, data.email, min)
attempt_id.email.max.kup = aggregate(keyUp ~ attempt_id, data.email, max)
#n.char
attempt_id.email.length = aggregate(email ~ attempt_id, data.email, length)
attempt_id.email.speed = data.frame("attempt_id" = attempt_id.email.min.kdown$attempt_id)
attempt_id.email.speed$delta.t = attempt_id.email.max.kup$keyUp - attempt_id.email.min.kdown$keyDown
attempt_id.email.speed$rate = attempt_id.email.length$email / attempt_id.email.speed$delta.t
attempt_id.email.speed$delta.t = NULL
#rate view
mean(attempt_id.email.speed$rate)
hist(attempt_id.email.speed$rate, nclass = 35, col = "lightblue")

3
###VELOCIDADE MEDIA DOS USUARIOS DIGITANDO TEXTO###
#delta.t
attempt_id.text.min.kdown = aggregate(keyDown ~ attempt_id, data.text, min)
attempt_id.text.max.kup = aggregate(keyUp ~ attempt_id, data.text, max)
#n.char

data.text$um = 1
attempt_id.text.length = aggregate(um ~ attempt_id, data.text, sum)
attempt_id.text.speed = data.frame("attempt_id" = attempt_id.text.min.kdown$attempt_id)
attempt_id.text.speed$delta.t = attempt_id.text.max.kup$keyUp - attempt_id.text.min.kdown$keyDown
attempt_id.text.speed$rate = attempt_id.text.length$um / attempt_id.text.speed$delta.t
attempt_id.text.speed$delta.t = NULL
#rate view
mean(attempt_id.text.speed$rate)
hist(attempt_id.text.speed$rate, nclass = 30, col = "lightgreen")



