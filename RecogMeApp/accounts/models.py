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

    @classmethod
    def create(cls, **kwargs):
        """
        Keywords Arguments
        email -- email of the user
        json_email -- json with the keystroke of the field email
        json_password -- json with the keystroke of the field password
        json_user_text -- json with the keystroke of the field user_text
        """
        return cls(**kwargs)

    def __str__(self):
        return self.email


class FalseLogin(models.Model):
    invader_email = models.EmailField(default='default@mail.com')
    attempt = models.TextField(default='default')
    hacked_email = models.TextField(default='default')
    prediction_result = models.TextField(default='default')

    @classmethod
    def create(cls, attempt_path, **kwargs):
        """
        Keywords Arguments
        invader_email -- the email of invader who's trying hack
        attempt_path  -- the path of the file with the attempent information
        hacked_email  -- the email who's being  hacked
        prediction_result -- the result of the prediction
        """
        with open(attempt_path) as f:
            attempt = f.read()

        return cls(attempt=attempt, **kwargs)

    def __str__(self):
        return self.hacked_email
