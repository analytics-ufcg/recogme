occurrence_table <- read.table("~/development/recogme/dados_coletados/Dados_CSV/occurrence_table.csv", header=TRUE, sep = "\t", quote = "")
occurrence_table = occurrence_table[with(occurrence_table, order(-occurrence)), ]
row.names(occurrence_table) = NULL

occurrence = read.table("~/development/recogme/dados_coletados/Dados_CSV/occurrence_table.csv", header=TRUE, sep = "\t", quote = "")
pairs.of.letter = read.table("~/development/recogme/dados_coletados/Dados_CSV/letter_pairs_by_attempt.tsv", header=TRUE, sep = "\t", quote = "")
pairs.of.letter$hold = pairs.of.letter$keyUp - pairs.of.letter$keyDown

occurrence = occurrence[with(occurrence, order(-occurrence)), ]
row.names(occurrence) = NULL

#maior ocorrencia
a = "A"
r = "R"
occurr1.data = pairs.of.letter[pairs.of.letter$key_1st == a & pairs.of.letter$key_2nd == r,]



