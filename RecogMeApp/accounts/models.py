from django.db import models
from django.conf import settings
# Create your models here.

class UserProfile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL)
    phrase = models.TextField()
    name2 = models.TextField("")
    email2 = models.EmailField()

    def __str__(self):
        return self.user.username
