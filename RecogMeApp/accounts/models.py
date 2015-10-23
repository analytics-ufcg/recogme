from django.db import models
from django.conf import settings
# Create your models here.

class UserProfile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL)
    phrase = models.TextField()
    name2 = models.TextField("")
    email2 = models.EmailField()
    json_login = models.TextField()
    json_email = models.TextField()
    json_password = models.TextField()
    json_phrase = models.TextField()

    def __str__(self):
        return self.user.username
