# -*- coding: utf-8 -*-
# Generated by Django 1.11.5 on 2017-11-11 01:45
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('event', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='eventdetail',
            name='opreater_name',
            field=models.CharField(default='actanble', max_length=10, verbose_name='操作员名字'),
        ),
    ]
