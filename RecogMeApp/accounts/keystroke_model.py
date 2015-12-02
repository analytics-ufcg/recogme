import rpy2.robjects as ro

ro.r('library("caret")')
ro.r('library("dplyr")')
ro.r('library ( "e1071")')


def prepare_set_test(input, output):
    ro.r('library("Rmisc")')
    ro.r('arquivo_csv = "' + input + '"')
    ro.r('output_csv = "' + output + '"')
    ro.r('FRASE = "Para as rosas, escreveu alguém, o jardineiro é eterno.";')

    ro.r(
        'verificaLogin <- function(arquivo_csv, output_csv){ dados = read.csv(arquivo_csv, sep = "\t", header = T, encoding = "UTF-8", quote = ""); dados.filtrado = data.frame();for(i in 1:nrow(dados)){if(!dados[i,"keyValue"] == "Backspace"){dados.filtrado = rbind(dados.filtrado,dados[i,])}else if (!nrow(dados.filtrado) == 0 && dados[i,"source"] == dados.filtrado[nrow(dados.filtrado),"source"]){dados.filtrado = dados.filtrado[-nrow(dados.filtrado),]}};names(dados.filtrado) =c ("attempt_id","email","attempt_time","source","keyDown","keyUp","keyValue","keyCode");userEmails <- dados.filtrado %>% filter(source == "email");get_latency <- function (user){user <- arrange(user, keyUp);user$latency <- 0;for (i in 2:nrow(user)) {user[i,]$latency <- user[i,]$keyDown - user[i-1,]$keyUp};return (user)};holdTime <- function(user){user$holdTime = user$keyUp - user$keyDown;return (user)};userEmails_10_first_char <- userEmails %>% get_latency() %>% holdTime() %>% group_by(attempt_id) %>% slice(1:10);get_features <- function(data){data_t <- data %>% select(latency, holdTime);data_t <- t(data_t);Flatencies <- data.frame(Femail_latency1 = data_t[1,2], Femail_latency2 = data_t[1,3],Femail_latency3 = data_t[1,4], Femail_latency4 = data_t[1,5], Femail_latency5 = data_t[1,6], Femail_latency6 = data_t[1,7], Femail_latency7 = data_t[1,8], Femail_latency8 = data_t[1,9],Femail_latency9 = data_t[1,10]);FholdTimes <- data.frame(Femail_holdtime1 = data_t[2,1],Femail_holdtime2 = data_t[2,2], Femail_holdtime3 = data_t[2,3], Femail_holdtime4 = data_t[2,4], Femail_holdtime5 = data_t[2,5], Femail_holdtime6 = data_t[2,6],Femail_holdtime7 = data_t[2,7],Femail_holdtime8 = data_t[2,8],Femail_holdtime9 = data_t[2,9],Femail_holdtime10 = data_t[2,10]);resp <- cbind(Flatencies, FholdTimes, row.names = NULL);return (resp)};email_features <- userEmails_10_first_char %>% group_by(email, attempt_id) %>% do(get_features(.));dados.filtrado$email = as.character(dados.filtrado$email);dados.frase = subset(dados,dados.filtrado$source == "userText");dados.frase = subset(dados.frase,(dados.frase$keyValue %in% LETTERS));frase = toupper(FRASE); features = c();for(i in 2:nchar(frase)){if((substr(frase,i,i) %in% LETTERS & substr(frase,i-1,i-1) %in% LETTERS)){features = c(features,paste0(substr(frase,i-1,i-1),substr(frase,i,i)))}};features = unique(features);linha = c();latencias = rep(0,length(features));ocorrencias = rep(0,length(features));for (j in 1:nrow(dados.frase)-1){feat = paste0(dados.frase[j,"keyValue"],dados.frase[j+1,"keyValue"]);posicao = match(feat,features);if(!is.na(posicao)){ocorrencias[posicao] = ocorrencias[posicao] + 1; latencias[posicao] = (dados.frase[j+1,"keyDown"] - dados.frase[j,"keyUp"]) + latencias[posicao]}};latencias = latencias / ocorrencias;linha = c(linha,latencias);caracteres = c();for(j in 1:nchar(frase)){if(substr(frase,j,j) %in% LETTERS){caracteres = c(caracteres,substr(frase,j,j))}};caracteres = unique(caracteres);holds = rep(0,length(caracteres));ocorrencias = rep(0,length(caracteres));for(j in 1:nrow(dados.frase)){posicao = match(dados.frase[j,"keyValue"],caracteres);if(!is.na(posicao)){ocorrencias[posicao] = ocorrencias[posicao] + 1;holds[posicao] = holds[posicao] + (dados.frase[j,"keyUp"] - dados.frase[j,"keyDown"])}};holds = holds / ocorrencias;linha = c(linha,holds);latencias = c();for (j in 1:nrow(dados.frase)-1){latencias = c(latencias,(dados.frase[j+1,"keyDown"] - dados.frase[j,"keyUp"]))};intervalo = CI(latencias,ci=0.95);intervalo = as.double(intervalo);linha = c(linha,intervalo[3],intervalo[1]);frase_features = data.frame();frase_features = rbind(frase_features,linha);features = cbind(email_features,frase_features);features$attempt_id <- NULL;write.table(features, quote = FALSE, sep = "\t", file=output_csv, row.names = F, col.names = T)}')

    ro.r('verificaLogin(arquivo_csv, output_csv)')


class SvmModel:
    def __init__(self, dataset_train, dataset_test):
        self.train = "'" + dataset_train + "'"
        self.test = "'" + dataset_test + "'"

    def create_model(self):
        ro.r('dados.train <- read.delim(' + self.train + ')')
        ro.r('dados.train <- dados.train[complete.cases(dados.train),]')
        # ro.r('dados.train <- dados.train %>% filter(email != "arthur.senaufcg@gmail.com", ' +
        #      'email != "orion.lima@ccc.ufcg.edu.br")%>% droplevels()')
        # ro.r('levels(dados.train$email)')
        # ro.r('str(dados.train)')
        # ro.r('summary(dados.train)')
        ro.r('model <- svm( dados.train$email~., dados.train)')

    def create_test(self, dataset_test):
        print(dataset_test)
        print("->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>-")
        test = "'" + dataset_test + "'"
        ro.r('dados.teste <- read.delim(' + test + ')')
        ro.r(
            'colnames(dados.teste)<-c("email",	"attempt_id","Femail_latency1","Femail_latency2","Femail_latency3",' +
            '"Femail_latency4","Femail_latency5","Femail_latency6","Femail_latency7","Femail_latency8",' +
            '"Femail_latency9","Femail_holdtime1",	"Femail_holdtime2","Femail_holdtime3","Femail_holdtime4",' +
            '"Femail_holdtime5","Femail_holdtime6", "Femail_holdtime7", "Femail_holdtime8","Femail_holdtime9", ' +
            '"Femail_holdtime10","X169","X96.5", "X.23", "X.71.5", "X.0.5","X.41","X39","X75","X144","X131","X1",' +
            '"X16","X49","X48","X1.1","X.21","NaN.","X.2","X114","X1.2","NaN..1","X42","X0","X57","NaN..2","NaN..3",' +
            '"NaN..4",	"NaN..5","NaN..6","X128","X147.166666666667","X117","X140.75","X107.333333333333","X119.8",' +
            '"X96","X69","X137","X116","X115","X152","X129","X131.1","X98","X57.1","NaN..7","X87.6995927923112")')
        ro.r('dados.teste[is.na(dados.teste)] <- 0')
        ro.r('dados.teste <- droplevels(dados.teste[complete.cases(dados.teste),])')
        ro.r('levels(dados.teste$email)')
        ro.r('test <- select(dados.teste, - email)')

    def consult_prediction(self, email):
        ro.r('prediction <- predict(model, test)')
        ro.r('resp <- table(prediction, dados.teste$email)')
        ro.r('resp <- as.data.frame(resp)')
        prediction = ro.r('(resp %>% filter(prediction == "' + email + '",Var2 == "' + email + '"))$Freq')
        return prediction

# create_model("dados-train.psv")
# create_test("dados-teste.psv")
# acuracy = create_prediction('leonardo.santos@ccc.ufcg.edu.br')
# print(acuracy)
