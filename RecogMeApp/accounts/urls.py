__author__ = 'leonardo'

from django.conf.urls import url
from . import views

urlpatterns = [
                url(r'^registro/$', views.registro_usuario_view, name='accounts.registro'),
                url(r'obrigado/(?P<username>[\w]+)/$', views.obrigado_view, name='accounts.obrigado'),
                ]
