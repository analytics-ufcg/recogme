import ast
import json

def formated_string_to_tuple_dicts(string):
	return ast.literal_eval(string)

path = "/home/tales/development/recogme/dados_coletados/Dados_CSV/userLogin.psv"
arq_user_login = open(path, "r")

header_user_login = arq_user_login.readline()

lines_user_login = arq_user_login.readlines()

formated_table = []

print "Processing data"
for line in lines_user_login:
	line_split = line.replace("\n","").split("|")

	attempt_id = line_split[0]
	email = line_split[1]
	time = line_split[2]

	json_email = line_split[3]
	email_keystroke = json.loads(json_email)["login"]

	json_password = line_split[4]
	password_keystroke = json.loads(json_password)["password"]

	json_user_text = line_split[5]
	user_text_keystroke = json.loads(json_user_text)["userText"]

	table_header = ",".join(("attempt_id", "email", "attempt_time", "source", "keyDown", "keyUp", "keyValue", "keyCode"))
	formated_table.append(table_header)

	for k_email in email_keystroke:
		row = (attempt_id, email, time, "email", str(k_email["keyDown"]), str(k_email["keyUp"]), k_email["keyValue"], str(k_email["keyCode"]))
		row = ",".join(row)
		formated_table.append(row)

	for k_password in password_keystroke:
		row = (attempt_id, email, time, "password", str(k_password["keyDown"]), str(k_password["keyUp"]), k_password["keyValue"], str(k_password["keyCode"]))
		row = ",".join(row)
		formated_table.append(row)

	for k_text in user_text_keystroke:
		row = (attempt_id, email, time, "userText", str(k_text["keyDown"]), str(k_text["keyUp"]), k_text["keyValue"], str(k_text["keyCode"]))
		row = ",".join(row)
		formated_table.append(row)

print "Saving table"
arq = open("/home/tales/development/recogme/dados_coletados/Dados_CSV/userLogin-formated.psv", "w")
for row in formated_table:
	arq.write(row.encode("utf8") + "\n")

arq.close()

print "Done!"