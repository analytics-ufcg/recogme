from django.db import models
from django.conf import settings
# Create your models here.

class UserProfile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL)
    phrase = models.TextField()
    time = models.DateField(auto_now=True)
    json_email = models.TextField()
    json_full_name = models.TextField()
    json_password = models.TextField()
    json_user_text = models.TextField()

    def __str__(self):
        return self.user.username
