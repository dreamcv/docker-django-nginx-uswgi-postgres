#!/usr/bin/env python
# encoding: utf-8
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^index.html$', views.homepage, name="jtopo_test_home"),
    url(r'^jtopo_data/$', views.get_config_data, name="jtopo_data"),
    url(r'^yanshi.php$', views.yanshi, name="场景演示"),

    ## 根据修改IP相关

    url(r'^add_ip/$', views.add_ip, name="add_ip"),
    url(r'^edit_ip/$', views.edit_ip, name="add_ip"),
    url(r'^delete_ip/$', views.delete_ip, name="delete_ip"),
    url(r'^demo_data/$', views.temp_data, name="jtopo_demo_tempdata"),
    url(r'^node_modal/$', views.get_get_modal, name="get_get_modal"),
]
