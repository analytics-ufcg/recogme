occurrence = read.table("~/development/recogme/dados_coletados/Dados_CSV/occurrence_table.csv", header=TRUE, sep = "\t", quote = "")
pairs.of.letter = read.table("~/development/recogme/dados_coletados/Dados_CSV/letter_pairs_by_attempt.tsv", header=TRUE, sep = "\t", quote = "")
pairs.of.letter$hold = pairs.of.letter$keyUp - pairs.of.letter$keyDown

occurrence = occurrence[with(occurrence, order(-occurrence)), ]
row.names(occurrence) = NULL

diversity <- function(lista){
  normalized = (lista-min(lista))/(max(lista)-min(lista))
  sd(normalized)
}

#primeira maior ocorrencia
k1 = "A"
k2 = "R"
occurr1.data = pairs.of.letter[pairs.of.letter$key_1st == k1 & pairs.of.letter$key_2nd == k2,]
occurr1.type.rate = aggregate(hold ~ attempt_id, occurr1.data, mean)

hist(occurr1.type.rate$hold, nclass = 300, col = "lightblue")

#primeira maior ocorrencia
k1 = "R"
k2 = "O"
occurr2.data = pairs.of.letter[pairs.of.letter$key_1st == k1 & pairs.of.letter$key_2nd == k2,]
occurr2.type.rate = aggregate(hold ~ attempt_id, occurr2.data, mean)

hist(occurr2.type.rate$hold, nclass = 300, col = "lightgreen")

#primeira maior ocorrencia
k1 = "A"
k2 = "S"
occurr3.data = pairs.of.letter[pairs.of.letter$key_1st == k1 & pairs.of.letter$key_2nd == k2,]
occurr3.type.rate = aggregate(hold ~ attempt_id, occurr3.data, mean)

hist(occurr3.type.rate$hold, nclass = 300, col = "lightyellow")

#primeira maior ocorrencia
k1 = "O"
k2 = "Space"
occurr4.data = pairs.of.letter[pairs.of.letter$key_1st == k1 & pairs.of.letter$key_2nd == k2,]
occurr4.type.rate = aggregate(hold ~ attempt_id, occurr4.data, mean)

hist(occurr4.type.rate$hold, nclass = 300, col = "lightpink")

#primeira maior ocorrencia
k1 = "Space"
k2 = "A"
occurr5.data = pairs.of.letter[pairs.of.letter$key_1st == k1 & pairs.of.letter$key_2nd == k2,]
occurr5.type.rate = aggregate(hold ~ attempt_id, occurr5.data, mean)

hist(occurr5.type.rate$hold, nclass = 300, col = "lightblue")

#primeira maior ocorrencia
k1 = "Space"
k2 = "E"
occurr6.data = pairs.of.letter[pairs.of.letter$key_1st == k1 & pairs.of.letter$key_2nd == k2,]
occurr6.type.rate = aggregate(hold ~ attempt_id, occurr6.data, mean)

hist(occurr6.type.rate$hold, nclass = 300, col = "orange")


diversity(occurr1.type.rate$hold)
diversity(occurr2.type.rate$hold)
diversity(occurr3.type.rate$hold)
diversity(occurr4.type.rate$hold)
diversity(occurr5.type.rate$hold)
diversity(occurr6.type.rate$hold)

