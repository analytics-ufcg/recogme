__author__ = 'leonardo'

from django import forms
from django.contrib.auth.models import User


class RegistroUserForm(forms.Form):
    text = "Ei ipsum appareat ius, quo ei."
    username = forms.CharField(label='Digite Seu Nome', min_length=5, widget=forms.TextInput(attrs={'class': 'form-control'}))
    username2 = forms.CharField(label='Confirme Seu Nome', min_length=5, widget=forms.TextInput(attrs={'class': 'form-control'}))

    email = forms.EmailField(label='Digite Seu Email', widget=forms.EmailInput(attrs={'class': 'form-control'}))
    email2 = forms.EmailField(label='Confirme Seu Email', widget=forms.EmailInput(attrs={'class': 'form-control'}))

    password = forms.CharField(label='Digite Sua Senha', min_length=5,
                               widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    password2 = forms.CharField(label='Confirme Sua Senha', min_length=5,
                                widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    phrase = forms.CharField(label='Digite \"Ei ipsum appareat ius, quo ei.\"', min_length=5,
                             widget=forms.TextInput(attrs={'class': 'form-control'}))

    def clean_username(self):
        """Verify if the username is already registered"""
        username = self.cleaned_data['username']
        if User.objects.filter(username=username):
            raise forms.ValidationError('Nome de usuário já registrado.')
        return username

    def clean_username2(self):
        """Verify if the username and username2 are equals"""
        username = self.cleaned_data['username']
        username2 = self.cleaned_data['username2']
        if username != username2:
            raise forms.ValidationError('Os nomes de usuários não conhecidem.')
        return username2

    def clean_email(self):
        """Verify if the email is already registered"""
        email = self.cleaned_data['email']
        if User.objects.filter(email=email):
            raise forms.ValidationError('Email já registrado no banco.')
        return email

    def clean_email2(self):
        """Verify if the email and email2 are equals."""
        email = self.cleaned_data['email']
        email2 = self.cleaned_data['email2']
        if email != email2:
            raise forms.ValidationError('Os emails não conhecidem.')
        return email2

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

        if phrase != self.text:
            raise forms.ValidationError('A frase não confere')
        return phrase

