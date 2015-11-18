from KeyTouch import KeyTouch

path = "/home/tales/development/recogme/dados_coletados/Dados_CSV/userLogin-0.1.psv"

arq = open(path, "r")

sep = "\t"

header = arq.readline()
lines = arq.readlines()
arq.close()

user_keydata = {}

print "Ya"
for line in lines:
	lineSplit = line.replace("\n", "").split(sep)

	source = lineSplit[3]

	if(source == "email"):
		
		keyt = KeyTouch(lineSplit)

		if(not keyt.email in user_keydata.keys()):
			user_keydata[keyt.email] = [keyt]
		else:
			user_keydata[keyt.email].append(keyt)



for i in sorted(user_keydata["tales.tsp@gmail.com"], key=lambda x: x.keyUp, reverse=True):
	print i.keyUp
