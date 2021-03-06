__author__ = 'leonardo'

from django import forms
from django.contrib.auth.models import User
from  django.core.validators import RegexValidator
import re


class RegistroUserForm(forms.Form):
    text = "Para as rosas, escreveu alguém, o jardineiro é eterno."
    name = forms.CharField(label='Digite seu Nome Completo', min_length=5,
                           widget=forms.TextInput(attrs={'class': 'form-control', 'id': "fullName",
                                                         'autocomplete': "off"}))
    name2 = forms.CharField(label='Confirme seu Nome Completo', min_length=5,
                            widget=forms.TextInput(attrs={'id': "confirmFullName", 'class': 'form-control',
                                                          'autocomplete': "off"}))

    email = forms.EmailField(label='Digite Seu Email',
                             widget=forms.EmailInput(attrs={'id': "email", 'class': 'form-control',
                                                            'autocomplete': "off"}))
    email2 = forms.EmailField(label='Confirme Seu Email',
                              widget=forms.EmailInput(attrs={'id': 'confirmEmail', 'class': 'form-control',
                                                             'autocomplete': "off"}))

    password = forms.CharField(label='Digite Sua Senha', min_length=6,
                               widget=forms.PasswordInput(attrs={'id': "password", 'class': 'form-control',
                                                                 'autocomplete': "off"}))
    password2 = forms.CharField(validators=[RegexValidator(regex="(.*[a-z A-Z].*[0-9].*)|(.*[0-9].*[a-z A-Z].*)",
                                                           message="Deve Conter ao menos uma letra e um número.")],
                                label='Confirme Sua Senha', min_length=6,
                                widget=forms.PasswordInput(attrs={'id': "confirmPassword", 'class': 'form-control',
                                                                  'autocomplete': "off"}))

    phrase = forms.CharField(label='Digite: Para as rosas, escreveu alguém, o jardineiro é eterno.', min_length=5,
                             widget=forms.TextInput(attrs={'id': "userText", 'class': 'form-control',
                                                           'autocomplete': "off"}))

    def clean_name(self):
        """Verify if the username is already registered"""
        name = self.cleaned_data['name']
        if len(name.split()) < 2:
            raise forms.ValidationError('Digite Nome e Sobrenome.')
        return name

    def clean_name2(self):
        """Verify if the username and username2 are equals"""
        name = self.cleaned_data['name']
        name2 = self.cleaned_data['name2']
        if name != name2:
            raise forms.ValidationError('Os nomes de usuários não conhecidem.')
        return name2

    def clean_email(self):
        """Verify if the email is already registered"""
        email = self.cleaned_data['email']
        if User.objects.filter(username=email):
            raise forms.ValidationError('Email já registrado no banco.')
        return email

    def clean_email2(self):
        """Verify if the email and email2 are equals."""
        email = self.cleaned_data['email']
        email2 = self.cleaned_data['email2']
        if email != email2:
            raise forms.ValidationError('Os emails não conhecidem.')
        return email2

    # def clean_password(self):
    #     password = self.cleaned_data['password']
    #     match = re.fullmatch("(.*[a-z A-Z].*[0-9].*)|(.*[0-9].*[a-z A-Z].*)", password)
    #
    #     if match is None:
    #         raise forms.ValidationError('A senha deve conter ao menos um número e uma letra')
    #
    #     return password

    def clean_password2(self):
        """Verify if the password and password2 are equals."""
        password = self.cleaned_data['password']
        password2 = self.cleaned_data['password2']
        if password != password2:
            raise forms.ValidationError('As senhas não conhecidem.')
        return password2

    def clean_phrase(self):
        """Verify if the phrase typed is equal to the text."""
        phrase = self.cleaned_data['phrase']

        if phrase.strip() != self.text:
            raise forms.ValidationError('A frase não confere')
        return phrase
