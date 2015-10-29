from django.db import models
from django.conf import settings
import time
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