__author__ = 'leonardo'

from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.index_view, name='accounts.index'),
    url(r'^login/$', views.login_view, name='accounts.login'),
    url(r'^logout/$', views.logout_view, name='accounts.logout'),
    url(r'^registro/$', views.registro_usuario_view, name='accounts.registro'),
    url(r'obrigado/(?P<username>[\w]+)/$', views.obrigado_view, name='accounts.obrigado'),
]
