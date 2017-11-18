from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.core.urlresolvers import reverse
from django.contrib.sites.models import Site
from accounts.models import ProjUser

"""
class Stations(models.Model):
    station = models.CharField('状态', max_length=50, blank=True)
    # iStation = models.IntegerField('状态INT')
    id = models.AutoField(primary_key=True)

    class Meta:
        verbose_name = "状态集合"

    def __str__(self):
        return self.station


# Create your models here.
class Stat(models.Model):
    stat = models.ForeignKey(Stations, verbose_name="状态", blank=True)
    desc = models.CharField('状态描述', max_length=150, blank=True)
    id = models.AutoField(primary_key=True)

    class Meta:
        verbose_name = "事件状态"

    def __str__(self):
        return self.stat.station


class EventCate(models.Model):
    cate = models.CharField('事件类型', max_length=50, default="告急信息")
    id = models.AutoField(primary_key=True)

    def __str__(self):
        return self.cate

    class Meta:
        verbose_name = "事件类型集合"

"""

class EventBase(models.Model):
    event_name = models.CharField('事件名', max_length=150, blank=True)
    event_cate = models.CharField('事件类型', max_length=50, default="交通")
    event_src = models.CharField('泄露源', max_length=20, default='0.0.0.0')
    to_server = models.CharField('流向IP', max_length=20, default="0.0.0.0")
    port = models.CharField('端口', max_length=20, default="443")
    happened_date = models.DateField("发生日期", auto_now=True)
    id = models.AutoField(primary_key=True)

    def __str__(self):
        return self.get_eventname

    def get_eventname(self):
        s = "从 `" + self.event_src + "` 向 `" + self.to_server + \
        "` 通过 `" + self.port +"`端口的 `" + self.event_cate + "` 信息泄露"
        return s

    class Meta:
        verbose_name = "事件"


class EventDetail(models.Model):
    event = models.ForeignKey(EventBase, verbose_name="事件")
    event_stat = models.CharField('状态', max_length=50, blank=True)
    event_time = models.DateTimeField("事件状态时间", auto_now=True)
    # is_seen = models.BooleanField("看过", default=False)
    connect_person = models.ManyToManyField(ProjUser, verbose_name="状态参与人员", blank=True)
    # id = models.AutoField(primary_key=True) ## 事件处理详情的ID
    opreater_name = models.CharField('操作员名字', max_length=10, default="actanble")
    extra_add = models.TextField(verbose_name="添加备注", default="")

    def __str__(self):
        return self.event.event_name + "-" + self.event_stat

    class Meta:
        verbose_name = "事件详细"

