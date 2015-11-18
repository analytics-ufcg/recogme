import sys

path = sys.argv[1]
new_path = sys.argv[2]

arq = open(path, "r")

sep = "\t"

header = arq.readline()
print header
break
lines = arq.readlines()
arq.close()

dict_keydown_line = {}

for line in lines:
	line_split = line.replace("\n", "").split("\t")
	keyDown = line_split[4]
	dict_keydown_line[keyDown] = line

sorted_keydown = dict_keydown_line.keys()

sorted_keydown.sort()

pair_data = {}

last_line = lines[0].replace("\n", "").split("\t")

for line in lines[1:]:
	line_split = line.replace("\n", "").split("\t")
	#print line_split
	attempt_id = line_split[0]
	email = line_split[1]
	attempt_date = line_split[2]
	source = line_split[3]
	keyDown = line_split[4]
	keyUp = line_split[5]
	keyValue = line_split[6]
	keyCode = line_split[7]

	
	last_keyValue = last_line[6]
	last_attempt_id = last_line[0]
	last_source = last_line[3]

	#check if the the two consecutive keys are in the same session and the same text field
	if( (last_attempt_id == attempt_id) and (last_source == source) ):
		
		if( not (last_keyValue, keyValue) in pair_data.keys()):
			pair_data[(last_keyValue, keyValue)] = 1
		else:
			pair_data[(last_keyValue, keyValue)] = pair_data[(last_keyValue, keyValue)] + 1

	last_line = line_split

arq = open(new_path, "w")

arq.write("key_1st" + sep + "key_2nd"  + sep + "occurrence\n")

for i in pair_data.keys():
	arq.write(i[0] + sep + i[1] + sep + str(pair_data[i]) + "\n")

arq.close()