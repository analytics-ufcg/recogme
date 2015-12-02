#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs
import ast
import json
import sys


def formated_string_to_dicts_tuple(string):
    return ast.literal_eval("{" + string + "}")


def generate_table(data, path):
    # path = path

    sep = "\t"

    # arq_user_login = open(path, "r")
    data = data.split("\n")
    header_user_login = data[0]

    lines_user_login = data[0:]
    formated_table = []

    table_header = sep.join(
        ("attempt_id", "email", "attempt_time", "source", "keyDown", "keyUp", "keyValue", "keyCode"))
    formated_table.append(table_header)

    print("Processing data")

    for line in lines_user_login:
        line_split = line.replace("\n", "").split("|")

        attempt_id = line_split[0]
        email = line_split[1]
        time = line_split[2]

        json_email = line_split[3]
        email_keystroke = formated_string_to_dicts_tuple(json_email.replace("\n", "").split("[{")[1].split("}]")[0])

        json_password = line_split[4]
        password_keystroke = formated_string_to_dicts_tuple(
            json_password.replace("\n", "").split("[{")[1].split("}]")[0])

        json_user_text = line_split[5]
        user_text_keystroke = formated_string_to_dicts_tuple(
            json_user_text.replace("\n", "").split("[{")[1].split("}]")[0])

        for k_email in email_keystroke:
            row = (
            attempt_id, email, time, "email", str(k_email["keyDown"]), str(k_email["keyUp"]), k_email["keyValue"],
            str(k_email["keyCode"]))
            row = sep.join(row)
            formated_table.append(row)

        for k_password in password_keystroke:
            row = (attempt_id, email, time, "password", str(k_password["keyDown"]), str(k_password["keyUp"]),
                   k_password["keyValue"], str(k_password["keyCode"]))
            row = sep.join(row)
            formated_table.append(row)

        for k_text in user_text_keystroke:
            row = (
            attempt_id, email, time, "userText", str(k_text["keyDown"]), str(k_text["keyUp"]), k_text["keyValue"],
            str(k_text["keyCode"]))
            row = sep.join(row)
            formated_table.append(row)

    print("Saving table")
    arq = open(path.replace(".psv", ".psv"), "w")
    for row in formated_table:
        arq.write(row + "\n")
    arq.close()
