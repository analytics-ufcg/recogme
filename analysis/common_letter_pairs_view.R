occurrence_table <- read.table("~/development/recogme/dados_coletados/Dados_CSV/occurrence_table.csv", header=TRUE, sep = "\t", quote = "")
occurrence_table = occurrence_table[with(occurrence_table, order(-occurrence)), ]
row.names(occurrence_table) = NULL

data = read.table("~/development/recogme/dados_coletados/Dados_CSV/userLogin-1.0.tsv", header=TRUE, sep = "\t", quote = "")
