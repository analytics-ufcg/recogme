#!/usr/bin/env python
# -*- coding: utf-8 -*-

from KeyTouch import *

def hold_time(lineSplit):
	return int(lineSplit[int(ku_i)]) - int(lineSplit[int(kd_i)])

def latency_time(keyTouch1, keyTouch2):
	return int(keyTouch2.keyDown) - int(keyTouch1.keyUp)


arq = open("/home/tales/development/recogme/dados_coletados/Dados_CSV/userLogin-0.1-cleaned.tsv", "r")
header = arq.readline()
lines = arq.readlines()

print lines[0]

frase_list = []
frase = "Para as rosas, escreveu algum, o jardineiro  eterno."

for char in frase:
	frase_list.append(char.upper())

new_lines = []

sep = "\t"

kd_i = header.split(sep).index("keyDown")
ku_i = header.split(sep).index("keyUp")

map_attempt_keytouch = {}

#se os dados estiverem ordenados por email, é possivel calcular as LATENCIAS mais otimizadas.
for line in lines:

	linesSplit = line.replace("\n", "").split(sep)
	

	linesSplit.append(hold_time(linesSplit))

	attempt = linesSplit[0]

	if (not attempt in map_attempt_keytouch.keys()):
		map_attempt_keytouch[attempt] = [KeyTouch(linesSplit)]
	else:
		map_attempt_keytouch[attempt].append(KeyTouch(linesSplit))

map_attempt_hold_time = {}
map_attempt_latency_time = {}

previous_keytouch = None

for i in map_attempt_keytouch.keys():
	for j in sorted(map_attempt_keytouch[i], key=lambda x: x.keyDown, reverse=False):
		#print j.to_string()
		if(j.source == "userText"):
			
			if( not (i, j.keyValue) in map_attempt_hold_time.keys() ):
				map_attempt_hold_time[ (i, j.keyValue) ] = [j.rowSplit[8]]

			else:
				map_attempt_hold_time[ (i, j.keyValue) ].append(j.rowSplit[8])

			if(not previous_keytouch == None):
				if( not (i, previous_keytouch.keyValue, j.keyValue) in map_attempt_latency_time.keys()):
					map_attempt_latency_time[ (i, previous_keytouch.keyValue, j.keyValue) ] = [latency_time(previous_keytouch, j)]
				else:
					map_attempt_latency_time[ (i, previous_keytouch.keyValue, j.keyValue) ].append(latency_time(previous_keytouch, j))

			previous_keytouch = j
	previous_keytouch = None

map_attempt_feature_value = {}

for i in map_attempt_latency_time.keys():
	attempt = i[0]
	feature = (i[1], i[2])
	value = map_attempt_latency_time[i]
	#print attempt, ">>", feature, ">>>>>>", value

	if(not attempt in map_attempt_feature_value.keys()):
		map_attempt_feature_value[attempt] = {feature: value}

	else:
		map_attempt_feature_value[attempt][feature] = value


for i in map_attempt_hold_time.keys():
	attempt = i[0]
	feature = (i[1])
	value = map_attempt_hold_time[i]
	#print attempt, ">>", feature, ">>>>>>", value

	if(not attempt in map_attempt_feature_value.keys()):
		map_attempt_feature_value[attempt] = {feature: value}

	else:
		map_attempt_feature_value[attempt][feature] = value

features = []
count_features = {}

prev = None

for char in frase_list:
	if(char == " "):
		char = "Space"
	elif(char == ","):
		char = ",<"
	elif(char == "."):
		char = ".>"

	if (not ("H_" + char) in count_features.keys()):
		features.append("H_" + char + "-1")
		count_features["H_" + char] = 1
	else:
		count_features["H_" + char] = count_features["H_" + char] + 1
		features.append("H_" + char + "-" + str(count_features["H_" + char]))
	
	if(not prev == None):

		if (not ("L_(" + prev +"," + char + ")") in count_features.keys()):
			features.append("L_(" + prev +"," + char + ")" + "-1")
			count_features["L_(" + prev +"," + char + ")"] = 1
		else:
			count_features["L_(" + prev +"," + char + ")"] = count_features["L_(" + prev +"," + char + ")"] + 1
			features.append("L_(" + prev +"," + char + ")" + "-" + str(count_features["L_(" + prev +"," + char + ")"]))

	prev = char

#for i in map_attempt_feature_value.keys():
#	print i
#	for j in map_attempt_feature_value[i]:
#		count = 0
#		for k in map_attempt_feature_value[i][j]:
#			count = count + 1
#			print count, j, k
#			print "***", j
#	print

data = []
row = ""
test_count = 0
counts = []

test_key_na_count = {}
test_atts = []
test_atts_na = []

for attempt in map_attempt_feature_value.keys():
	row = row + str(attempt)
	for feat_brute in features:
		index = int(feat_brute.split("-")[1]) - 1

		if(feat_brute[0] == "L"):
			feat = feat_brute.split("(")[1].split(")")[0]
			feat1 = feat.split(",")[0]
			feat2 = feat.split(",")[1]

			if(feat[0] == ","):
				feat1 = ",<"
				feat2 = feat.split(",")[2]

			if(len(feat2) == 0):
				feat2 = ",<"

			
			test_count = test_count + 1
			try:


				row = row + "\t" + str(map_attempt_feature_value[attempt][(feat1, feat2)][index])
			except:
				if (not (feat1, feat2) in test_key_na_count.keys()):
					test_key_na_count[(feat1, feat2)] = 1
				else:
					test_key_na_count[(feat1, feat2)] = test_key_na_count[(feat1, feat2)] + 1

				test_atts.append(int(attempt))
				test_atts_na.append((int(attempt), (feat1, feat2)))
				row = row + "\tNA"

		elif(feat_brute[0] == "H"):
			feat = feat_brute.split("_")[1].split("-")[0]
			test_count = test_count + 1
			try:
				row = row + "\t" + str(map_attempt_feature_value[attempt][feat][index])
			except:
				if (not feat in test_key_na_count.keys()):
					test_key_na_count[feat] = 1
				else:
					test_key_na_count[feat] = test_key_na_count[feat] + 1

				test_atts.append(int(attempt))
				test_atts_na.append((int(attempt), feat))
				row = row + "\t"

		else:
			print "SOMETHING IS WRONG"
			break

	data.append(row + "\n")
	row = ""
	counts.append(test_count)
	test_count = 0

arq = open("/home/tales/development/recogme/dados_coletados/Dados_CSV/train-0.2.csv", "w")

data_header = []

for f in features:
	data_header.append(f.replace("(","").replace(")","").replace("-","_"))

arq.write("Attempt\t")
arq.write("\t".join(data_header))
#arq.write(feat.replace("(","").replace(")","").replace("-","_") + "\t")
arq.write("\n")

for d in data:
	arq.write(d)

arq.close()
