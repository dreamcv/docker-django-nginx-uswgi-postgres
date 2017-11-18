#!/usr/bin/env python
# encoding: utf-8


import os

###
from os.path import dirname, abspath
PROJECT_DIR = dirname(dirname(abspath(__file__)))
import sys
sys.path.insert(0, PROJECT_DIR)
os.environ["DJANGO_SETTINGS_MODULE"] = "qlshenji.settings"

import django
django.setup()

from event.models import EventDetail, EventBase
from accounts.models import ProjUser
from datetime import date, datetime, time


def init_date_and_time(date_arg):
    import re

    time_args = re.findall("(.*?):(.*?):(.*?)\..*", str(datetime.today().time()))[0]
    date_arg = list(date_arg)
    date_arg.extend([x for x in time_args])
    dicts = {}
    keys = ["year", "month", "day", "hour", "minute", "second"]

    for i in range(len(keys)):
        dicts.setdefault(keys[i], int(date_arg[i]))

    return datetime(**dicts)

def init_date(date_arg):
    date_arg = list(date_arg)
    dicts = {}
    keys = ["year", "month", "day"]
    for i in range(len(keys)):
        dicts.setdefault(keys[i], int(date_arg[i]))
    return date(**dicts)



def post_events():
    array2 = [
        ["2017/08/21", "交通", "192.168.36.3", "192.36.53.98", "445"],
        ["2017/09/08", "户政", "192.5.6.3", "192.5.3.6", "223"],
        ["2013/09/10", "禁毒", "187.23.45.6", "136.3.6.9", "8808"],
        ["2017/08/11", "交通", "192.168.0.1", "187.23.45.6", "443"],
        ["2017/09/12", "内保", "192.168.1.1", "187.23.45.6", "112"],
        ["2017/09/13", "交通", "192.168.0.110", "187.23.45.6", "556"],
        ["2017/09/14", "交通", "192.168.0.11", "187.23.45.6", "224"],
        ["2017/09/15", "网安", "192.168.0.1", "187.23.45.6", "1120"],
        ["2017/09/16", "交通", "192.168.0.1", "187.23.45.6", "554"],
        ["2017/09/17", "交通", "192.168.0.1", "187.23.45.6", "1125"],
        ["2017/09/18", "交通", "192.168.0.1", "187.23.45.6", "557"],
        ["2017/09/08", "户政", "192.5.6.3", "192.5.3.6", "223"],
        ["2017/11/10", "交通", "187.23.45.6", "136.3.6.9", "808"],
        ["2017/11/11", "网安", "192.168.0.1", "187.23.45.6", "443"],
        ["2016/09/12", "内保", "192.168.156.1", "187.23.45.6", "112"],
        ["2017/09/13", "禁毒", "192.168.0.110", "187.23.45.6", "556"],
        ["2012/08/11", "交通", "192.168.0.1", "187.23.45.6", "443"],
        ["2013/09/12", "内保", "192.168.1.1", "187.23.45.6", "112"],
        ["2013/09/13", "交通", "192.168.0.110", "187.23.45.6", "556"],
        ["2016/09/14", "交通", "192.168.0.11", "187.23.45.6", "224"],
        ["2001/09/15", "网安", "192.168.0.1", "187.23.45.6", "1120"],
    ]
    ### columns = ["时间","数据类型", "泄漏源","流向IP","端口"],
    from datetime import datetime, date
    stations = ["发生", "签收", "处理", "完成"]

    for arr in array2:

        happended_date = init_date(arr[0].split("/"))
        e = EventBase(happened_date=happended_date, event_cate=arr[1], event_src=arr[2], to_server=arr[3], port=arr[4])
        e.event_name = e.get_eventname()
        e.save()

        event_time = init_date_and_time(arr[0].split("/"))
        ed = EventDetail(event_stat=stations[0], event_time=event_time, event = e)
        # ed.connect_person = ProjUser.objects.all()
        #### 多对多的人 用他的 add 方法
        ed.save()

    print("所有事件对象写入完成")


if __name__ == "__main__":
    #write_stations()
    ##### post_events()

    pass