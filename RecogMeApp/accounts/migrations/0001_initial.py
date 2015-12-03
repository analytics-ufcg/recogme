# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='FalseLogin',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, primary_key=True, verbose_name='ID')),
                ('invader_email', models.EmailField(max_length=254, default='default@mail.com')),
                ('attempt', models.TextField(default='default')),
                ('hacked_email', models.TextField(default='default')),
                ('prediction_result', models.TextField(default='default')),
            ],
        ),
        migrations.CreateModel(
            name='UserLogin',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, primary_key=True, verbose_name='ID')),
                ('email', models.TextField(default='default')),
                ('time', models.DateTimeField(auto_now=True)),
                ('json_email', models.TextField(default='default')),
                ('json_password', models.TextField(default='default')),
                ('json_user_text', models.TextField(default='default')),
            ],
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, primary_key=True, verbose_name='ID')),
                ('phrase', models.TextField()),
                ('time', models.DateTimeField(auto_now=True)),
                ('json_email', models.TextField(default='default')),
                ('json_full_name', models.TextField(default='default')),
                ('json_password', models.TextField(default='default')),
                ('json_user_text', models.TextField(default='default')),
                ('user', models.OneToOneField(to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
