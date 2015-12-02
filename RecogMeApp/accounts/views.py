# coding: utf-8
from django.shortcuts import render
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.conf import settings

from .form import RegistroUserForm
from .models import UserProfile, UserLogin, FalseLogin




# Añadir import logout y messages

import logging
import json
import csv
import random
from time import ctime

from .keystroke_model import SvmModel as Svm, prepare_set_test
from .prepare_json import generate_table

logger = logging.getLogger(__name__)

randuser = []
Svm = Svm(settings.MEDIA_ROOT + '/data/dados-train.psv',
          settings.MEDIA_ROOT + '/data/dados-teste.psv')
Svm.create_model()

with open(settings.MEDIA_ROOT + '/data/senhas.psv', 'r') as csvfile:
    users = csv.reader(csvfile)
    users = [(row) for row in users]


def choose_randuser():
    randuser = users[random.randint(1, len(users) - 1)]
    return randuser


def parser(json_string, tela):
    retorno = None
    if tela == "registro":

        # dict_keys(['confirmEmail', 'email', 'confirmPassword', 'confirmFullName', 'fullName', 'password', 'userText'])
        json_parsed = json.loads(json_string)
        json_email = {"login": json_parsed["email"], 'confirmEmail': json_parsed['confirmEmail']}
        json_password = {'password': json_parsed['password'], 'confirmPassword': json_parsed['confirmPassword']}
        json_full_name = {'fullName': json_parsed['password'], 'confirmFullName': json_parsed['confirmFullName']}
        json_user_text = {'userText': json_parsed['userText']}
        retorno = [json_email, json_password, json_full_name, json_user_text]

    elif tela == "login":
        # dict_keys(['confirmEmail', 'email', 'confirmPassword', 'confirmFullName', 'fullName', 'password', 'userText'])
        json_parsed = json.loads(json_string)
        json_email = {"login": json_parsed["email"]}
        json_password = {'password': json_parsed['password']}
        json_user_text = {'userText': json_parsed['userText']}

        retorno = [json_email, json_password, json_user_text]
    return retorno


def prepare_singnup_data(form, request):
    cleaned_data = form.cleaned_data
    username = cleaned_data.get('email')
    password = cleaned_data.get('password')
    phrase = cleaned_data.get('phrase')
    fullname = cleaned_data.get('name')
    first_name = fullname.split()[0]
    last_name = " ".join(fullname.split()[1:])
    keystroke = request.POST.get('keystroke')
    keystroke = parser(keystroke, "registro")

    return first_name, keystroke, phrase, last_name, username, password


def registro_usuario_view(request):
    print(request)
    if request.method == 'POST':
        form = RegistroUserForm(request.POST, request.FILES)
        # Comprobamos si el formulario es valido
        if form.is_valid():
            first_name, keystroke, phrase, last_name, username, password = prepare_singnup_data(form, request)
            # E instanciamos un objeto User, con el username y password
            user_model = User.objects.create_user(username=username, password=password)
            user_model.is_active = True
            user_model.first_name = first_name
            user_model.last_name = last_name
            user_model.save()

            user_profile = UserProfile()
            user_profile.user = user_model
            user_profile.phrase = phrase

            user_profile.json_email = json.dumps(keystroke[0])
            user_profile.json_full_name = json.dumps(keystroke[2])
            user_profile.json_password = json.dumps(keystroke[1])
            user_profile.json_user_text = json.dumps(keystroke[3])
            user_profile.save()

            return redirect(reverse('accounts.obrigado', kwargs={'username': first_name}))
        else:
            form = RegistroUserForm()
    else:
        form = RegistroUserForm()
    context = {
        'form': form
    }
    return render(request, 'accounts/registro.html', context)


@login_required
def index_view(request):
    return render(request, 'accounts/index.html')


@login_required
def ataque_view(request):
    mensaje = ''
    global randuser

    if request.method == 'GET':
        randuser = choose_randuser()

    randemail = randuser[0]
    randsenha = randuser[1]

    if request.method == 'POST':

        temp = "Para as rosas, escreveu alguém, o jardineiro é eterno."

        json_email, json_password, json_user_text, password, phrase, username = prepare_login_data(request)

        if username == randemail and password == randsenha:
            if phrase.strip() != temp:
                return render(request, 'accounts/ataque.html', {'mensaje': 'Frase incorreta.'})

            # data = "{0}|{1}|{2}|{3}|{4}".format(str(1), username, ctime(), json_email, json_password, json_user_text)
            data = "" + str(1) + '|' + username + '|' + ctime() + '|' + json_email + '|' + json_password + '|' + \
                   json_user_text

            output_psv = settings.MEDIA_ROOT + '/data/output.psv'
            test_psv = settings.MEDIA_ROOT + '/data/test.psv'
            generate_table(data, output_psv)
            prepare_set_test(output_psv, test_psv)
            Svm.create_test(dataset_test=test_psv)
            prediction = Svm.consult_prediction(email=randemail)

            false_login = FalseLogin.create(invader_email=str(request.user), attempt_path=test_psv,
                                            hacked_email=randemail, prediction_result=prediction)
            false_login.save()

            if prediction[0] == 1:
                return redirect(reverse('accounts.flpositivo'))
            else:
                return redirect(reverse('accounts.flnegativo'))
        else:
            return render(request, 'accounts/ataque.html',
                          {'mensaje': 'Usuário e Senha não conferem com os repassados.',

                           'randemail': randemail, 'randsenha': randsenha})

    return render(request, reverse('accounts.ataque.html'), {'mensaje': mensaje, 'randemail': randemail, 'randsenha': randsenha})


def login_view(request):
    if request.user.is_authenticated():
        return redirect(reverse('accounts.ataque'))

    mensaje = ''
    if request.method == 'POST':

        temp = "Para as rosas, escreveu alguém, o jardineiro é eterno."

        json_email, json_password, json_user_text, password, phrase, username = prepare_login_data(request)

        user = authenticate(username=username, password=password)

        if user is not None:
            if user.is_active:
                if phrase.strip() != temp:
                    return render(request, 'accounts/login.html', {'mensaje': 'Frase incorreta.'})
                user_login = UserLogin()
                user_login.email = username
                # user_login.password = password
                user_login.json_email = json_email
                user_login.json_password = json_password
                user_login.json_user_text = json_user_text
                user_login.save()

                login(request, user)
                return redirect(reverse('accounts.ataque'))
            else:
                pass

        mensaje = 'Nome de usuário ou senha não são válidos.'
        for i in request.POST.lists():
            logger.error(i)
    return render(request, 'accounts/login.html', {'mensaje': mensaje})


def prepare_login_data(request):
    username = request.POST.get('email')
    password = request.POST.get('password')
    keystroke = request.POST.get('keystroke')
    keystroke = parser(keystroke, "login")
    json_email = json.dumps(keystroke[0])
    json_password = json.dumps(keystroke[1])
    json_user_text = json.dumps(keystroke[2])
    phrase = request.POST.get('userText')
    return json_email, json_password, json_user_text, password, phrase, username


def logout_view(request):
    logout(request)
    messages.success(request, 'Deslogado com Sucesso.')
    return redirect(reverse('accounts.login'))


def obrigado_view(request, username):
    return render(request, 'accounts/obrigado.html', {'username': username})


def falsoLoginPositivo_view(request):
    return render(request, 'accounts/falsoLoginPositivo.html')


def falsoLoginNegativo_view(request):
    return render(request, 'accounts/falsoLoginNegativo.html')
