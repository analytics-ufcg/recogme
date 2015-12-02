from django.contrib import admin
from django.db import models
from django.conf import settings


# Create your models here.

class UserProfile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL)
    phrase = models.TextField()
    time = models.DateTimeField(auto_now=True)
    json_email = models.TextField(default='default')
    json_full_name = models.TextField(default='default')
    json_password = models.TextField(default='default')
    json_user_text = models.TextField(default='default')

    def __str__(self):
        return self.user.username


class UserLogin(models.Model):
    email = models.TextField(default='default')
    time = models.DateTimeField(auto_now=True)
    json_email = models.TextField(default='default')
    json_password = models.TextField(default='default')
    json_user_text = models.TextField(default='default')

    def __str__(self):
        return self.email


class FalseLogin(models.Model):
    invader_email = models.EmailField(default='default@mail.com')
    attempt = models.TextField(default='default')
    hacked_email = models.TextField(default='default')
    prediction_result = models.TextField(default='default')

    @classmethod
    def create(cls, invader_email, attempt_path, hacked_email, prediction_result):
        with open(attempt_path) as f:
            attempt = f.read()

        return cls(invader_email=invader_email, attempt=attempt, hacked_email=hacked_email,
                   prediction_result=prediction_result)

    def __str__(self):
        return self.hacked_email
