# coding: UTF-8

# author: Luiz
# O programa lê um arquivo csv com os seguintes campos "user,is_real,authenticated" que indicam respectivamente
# o usuário que está logando, se ele é o verdadeiro e se ele conseguiu ser autenticado no sistema.
# No final, é gerado um arquivo csv com os seguintes campos "user,TP,FN,TN,FP" que indicam respectivamente
# o usuário e o total de vezes que esse usuário foi indicado como True Positive, False Negative, True Negative e False Positive.


import csv


with open('attempts.csv', 'r') as csvfile:  # attempts.csv é o nome do arquivo a ser lido
	attempts = csv.reader(csvfile)
	resultados = {}
	for row in attempts:
		user = row[0]
		is_real = row[1]
		authenticated = row[2]
		if user not in resultados:
			resultados[user] = [0,0,0,0]			
		if is_real == "True":
			if authenticated == "True":
				resultados[user][0] += 1
			elif authenticated == "False":	
				resultados[user][1] += 1
		elif is_real == "False":
			if authenticated == "True":
				resultados[user][2] += 1
			elif authenticated == "False":	
				resultados[user][3] += 1

with open('results.csv', 'r+') as csvfile2:
	writer = csv.writer(csvfile2)
	writer.writerow(["user",'TP','FN','TN','FP'])	
	for nome in resultados:
		lista = [nome] + resultados[nome]
		writer.writerow(lista)
		 
