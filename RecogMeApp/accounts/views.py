# coding: utf-8
from django.shortcuts import render
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User

from .form import RegistroUserForm
from .models import UserProfile, UserLogin

from django.contrib.auth import authenticate, login, logout

from django.contrib.auth.decorators import login_required

# Añadir import logout y messages

from django.contrib import messages
import logging
import json

# Create your views here.
# Get an instance of a logger
logger = logging.getLogger(__name__)


# def parser(json_string):
#     # dict_keys(['confirmEmail', 'email', 'confirmPassword', 'confirmFullName', 'fullName', 'password', 'userText'])
#     json_parsed = json.loads(json_string)
#     json_email = {"login": json_parsed["email"], 'confirmEmail': json_parsed['confirmEmail']}
#     json_password = {'password': json_parsed['password'], 'confirmPassword': json_parsed['confirmPassword']}
#     json_full_name = {'fullName': json_parsed['password'], 'confirmFullName': json_parsed['confirmFullName']}
#     json_user_text = {'userText': json_parsed['userText']}

#     logger.error("___________________________________________________________________________\n")
#     logger.error(json_parsed)
#     logger.error("___________________________________________________________________________\n")

#     return [json_email, json_password, json_full_name, json_user_text]

def parser(json_string, tela):
    retorno = None
    if tela == "registro":

        # dict_keys(['confirmEmail', 'email', 'confirmPassword', 'confirmFullName', 'fullName', 'password', 'userText'])
        json_parsed = json.loads(json_string)
        json_email = {"login": json_parsed["email"], 'confirmEmail': json_parsed['confirmEmail']}
        json_password = {'password': json_parsed['password'], 'confirmPassword': json_parsed['confirmPassword']}
        json_full_name = {'fullName': json_parsed['password'], 'confirmFullName': json_parsed['confirmFullName']}
        json_user_text = {'userText': json_parsed['userText']}

        logger.error("___________________________________________________________________________\n")
        logger.error(json_parsed)
        logger.error("___________________________________________________________________________\n")

        retorno = [json_email, json_password, json_full_name, json_user_text]
    elif tela == "login":
         # dict_keys(['confirmEmail', 'email', 'confirmPassword', 'confirmFullName', 'fullName', 'password', 'userText'])
        json_parsed = json.loads(json_string)
        json_email = {"login": json_parsed["email"]}
        json_password = {'password': json_parsed['password']}
        json_user_text = {'userText': json_parsed['userText']}

        logger.error("___________________________________________________________________________\n")
        logger.error(json_parsed)
        logger.error("___________________________________________________________________________\n")

        retorno = [json_email, json_password, json_user_text]
    return retorno

def registro_usuario_view(request):
    print(request)
    if request.method == 'POST':
        # for i in request.POST.lists():
        #     logger.error("___________________________________________________________________________\n")
        #     logger.error(i)
        #     logger.error("___________________________________________________________________________\n")

        form = RegistroUserForm(request.POST, request.FILES)
        # Comprobamos si el formulario es valido
        if form.is_valid():
            # En caso de ser valido, obtenemos los datos del formulario.
            # form.cleaned_data obtiene los datos limpios y los pone en un
            # diccionario con pares clave/valor, donde clave es el nombre del campo
            # del formulario y el valor es el valor si existe.
            cleaned_data = form.cleaned_data
            username = cleaned_data.get('email')
            password = cleaned_data.get('password')
            phrase = cleaned_data.get('phrase')
            fullname = cleaned_data.get('name')
            first_name = fullname.split()[0]
            last_name = " ".join(fullname.split()[1:])
            keystroke = request.POST.get('keystroke')
            keystroke = parser(keystroke,"registro")

            # E instanciamos un objeto User, con el username y password
            user_model = User.objects.create_user(username=username, password=password)

            user_model.is_active = True
            user_model.first_name = first_name
            user_model.last_name = last_name
            # Y guardamos el objeto, esto guardara los datos en la db.
            user_model.save()
            # Ahora, creamos un objeto UserProfile, aunque no haya incluido
            # una imagen, ya quedara la referencia creada en la db.
            user_profile = UserProfile()
            # Al campo user le asignamos el objeto user_model
            user_profile.user = user_model
            user_profile.phrase = phrase

            user_profile.json_email = json.dumps(keystroke[0])
            user_profile.json_full_name = json.dumps(keystroke[2])
            user_profile.json_password = json.dumps(keystroke[1])
            user_profile.json_user_text = json.dumps(keystroke[3])

            # y le asignamos la photo (el campo, permite datos null)
            # user_profile.photo = photo
            # Por ultimo, guardamos tambien el objeto UserProfile
            user_profile.save()
            # Ahora, redireccionamos a la pagina accounts/obrigado.html
            # Pero lo hacemos con un redirect.
            return redirect(reverse('accounts.obrigado', kwargs={'username': first_name}))
    else:
        form = RegistroUserForm()
    context = {
        'form': form
    }
    return render(request, 'accounts/registro.html', context)


@login_required
def index_view(request):
    return render(request, 'accounts/index.html')


def login_view(request):
    if request.user.is_authenticated():
        return redirect(reverse('accounts.index'))
    mensaje = ''
    if request.method == 'POST':

        temp = "Para as rosas, escreveu alguém, o jardineiro é eterno."

        username = request.POST.get('email')

        password = request.POST.get('password')

        keystroke = request.POST.get('keystroke')
        
        keystroke = parser(keystroke,"login")

        frase = request.POST.get('userText')

        user = authenticate(username=username, password=password)

        if user is not None:
            if user.is_active:
                if frase.strip() != temp:
                     return render(request, 'accounts/login.html', {'mensaje': 'Frase incorreta.'})
                user_login = UserLogin()
                user_login.email = username
                # user_login.password = password
                user_login.json_email = json.dumps(keystroke[0])
                user_login.json_password = json.dumps(keystroke[1])
                user_login.json_user_text = json.dumps(keystroke[2])
                user_login.save()

                login(request, user)
                return redirect(reverse('accounts.index'))
            else:
                pass

        mensaje = 'Nome de usuário ou senha não são válidos.'
        for i in request.POST.lists():
            logger.error(i)
    return render(request, 'accounts/login.html', {'mensaje': mensaje})


def logout_view(request):
    logout(request)
    messages.success(request, 'Deslogado com Sucesso.')
    return redirect(reverse('accounts.login'))


def obrigado_view(request, username):
    return render(request, 'accounts/obrigado.html', {'username': username})
