import ast

def formated_string_to_tuple(string):
	return ast.literal_eval(string)

arq_user_login = open("/home/tales/development/recogme/dados_coletados/Dados_CSV/userLogin.psv", "r")

header_user_login = arq_user_login.readline()

lines_user_login = arq_user_login.readlines()

print header_user_login + "\n"

for line in lines_user_login:
	line_split = line.replace("\n","").split("|")

	attempt_id = line_split[0], "\n"
	email = line_split[1], "\n"
	time = line_split[2], "\n"
	json_email = formated_string_to_tuple(line_split[3].replace("\n","").split("[")[1].split("]")[0])
	json_password = line_split[4], "\n"
	json_user_text = line_split[5], "\n"