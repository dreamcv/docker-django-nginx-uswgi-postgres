# -*- coding: utf-8 -*-
# Generated by Django 1.11.5 on 2017-11-17 02:58
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('jtopot', '0003_auto_20171117_1048'),
    ]

    operations = [
        migrations.AlterField(
            model_name='jips',
            name='add_date',
            field=models.DateTimeField(auto_now_add=True, verbose_name='添加时间'),
        ),
    ]
