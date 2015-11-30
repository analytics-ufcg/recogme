arq = open("/home/tales/development/recogme/dados_coletados/Dados_CSV/userLogin-0.1.psv", "r")
header = arq.readline()
lines = arq.readlines()
arq.close()

from KeyTouch import *

sorted_lines_keytouch = []

for line in lines:
	linesSplit = line.replace("\n", "").split("\t")

	sorted_lines_keytouch.append(KeyTouch(linesSplit))

sorted_lines_keytouch = sorted(sorted_lines_keytouch, key=lambda x: x.keyDown, reverse=False)

new_lines = []

prev_keyvalue = ""
prev_source = ""
prev_attempt = ""
bspace_limit = 0


for line in sorted_lines_keytouch:
	linesSplit = line.to_string()
	line = "\t".join(linesSplit)

	
	#linesSplit = line.split("\t")
	source = linesSplit[3]	
	keyvalue = linesSplit[6]
	attempt = linesSplit[0]	

	if(attempt == '119' and source == "userText"):
		print linesSplit

	if((not keyvalue == "CapsLock") and (not keyvalue == "Shift") and (not keyvalue == "Down") and (not keyvalue == "Up") and (not keyvalue == "Left") and (not keyvalue == "Right")):

		if (not keyvalue == "Backspace"):
			new_lines.append(line)
			bspace_limit = bspace_limit + 1

		elif(prev_source == source and bspace_limit > 0):
			#if(attempt == '96' and source == "userText"):
			#	print new_lines[-1], "<-"
			new_lines = new_lines[:-1]
			bspace_limit = bspace_limit - 1

	if (not prev_attempt == attempt):
		bspace_limit = 0

	prev_source = source
	prev_attempt = attempt
	prev_keyvalue = keyvalue

new_new_lines = new_lines[:]

for line in new_lines:
	linesSplit = line.split("\t")
	keyvalue = linesSplit[6]

	if(keyvalue == "E" and prev_keyvalue == "U" and prev_prev_keyvalue == "G"):
		
		print "~~~", new_lines[new_lines.index(line)]

		del new_new_lines[new_new_lines.index(new_lines[new_lines.index(line)])]

	if(keyvalue == "Space" and prev_keyvalue == "E" and prev_prev_keyvalue == "Space"):
		
		print "~~~", new_lines[new_lines.index(line) - 1]

		del new_new_lines[new_new_lines.index(new_lines[new_lines.index(line) - 1])]

	prev_prev_keyvalue = prev_keyvalue
	prev_keyvalue = keyvalue

arq = open("/home/tales/development/recogme/dados_coletados/Dados_CSV/userLogin-0.1-cleaned.tsv", "w")
arq.write(header)
for i in new_new_lines:
	arq.write(i + "\n")
arq.close()

for i in new_new_lines:
	sp = i.split("\t")

	if(sp[0] == '119' and sp[3] == "userText"):
		print ">", sp

print len(new_new_lines), len(new_lines)
