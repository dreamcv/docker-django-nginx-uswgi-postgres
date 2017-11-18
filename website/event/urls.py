#!/usr/bin/env python
# encoding: utf-8

from django.conf.urls import url
from django.contrib.auth import views as auth_view

from . import views

urlpatterns = [
    url(r'^$', views.homepage, name="event_home"),
    url(r'^gj_json/$', views.gaim_json, name='warning_jsons'),
    url(r'^warning/$', views.warning_index, name="warning_index"),
    # url(r'^warning_detail/$', views.warning_detail, name="warning_detail"),

    url(r'^warning_detail/(?P<e_id>[0-9]+)/$', views.event_detail, name="warning_detail"),
    url(r'^warning_del/$', views.event_desolve, name="warning_del"),
    url(r'^send_email/$', views.send_email, name="send_email"),
    url(r'^j/$', views.test_json, name='test')
]
