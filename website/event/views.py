from django.shortcuts import render
from django.contrib.auth.views import login_required
from django.http import HttpResponse
# Create your views here.
from django.http import HttpResponse, JsonResponse
import pymysql


from qlshenji.settings import DB_CONFIG

def from_sql_get_data(sql):
    # Connect to the database
    connection = pymysql.connect(**DB_CONFIG)
    corsor = connection.cursor()
    corsor.execute(sql)
    try:
        res = corsor.fetchall()
        try:
            data = {"data": res, "heads": [x[0] for x in corsor.description]}
        except:
            data = None
    finally:
        ## connection.commit()
        corsor.close()
        connection.close()
    return data


## 单纯执行的
def sql_action(sql):
    connection = pymysql.connect(**DB_CONFIG)
    corsor = connection.cursor()
    corsor.execute(sql)
    # print(sql)
    connection.commit()
    corsor.close()
    connection.close()
    return


def main_json(request, sql):
    return JsonResponse(from_sql_get_data(sql))


def gaim_json(request):
    sql = """select  concat('<p onclick="g_open(', event_eventbase.id, ');"\>', 
                  event_eventbase.event_src, '</p>') as src,
            event_eventbase.to_server, 
            event_eventbase.port,
            event_eventbase.happened_date,
            event_eventbase.event_cate from event_eventbase; """
    return main_json(request, sql)


def get_deled_history_datas():
    sql = """select event_eventbase.*, ed.extra_add, ed.event_stat, ed.event_time, ed.opreater_name from 
                event_eventdetail as ed 
                  left join event_eventbase     
                  on ed.event_id = event_eventbase.id
    		where ed.event_stat = '处理';
    """
    res = from_sql_get_data(sql)
    return res["data"][:3]

## 获取 event_detail 传入 event_id 后 event_detail 中该事件的所有情况。
def get_details(event_id):
    sql = """select event_eventbase.*, event_eventdetail.event_stat, event_eventdetail.event_time from event_eventdetail 
                  left join event_eventbase
                  on event_eventdetail.event_id = event_eventbase.id
    				where event_eventdetail.event_stat = '发生'
    				and event_id={};
        """.format(event_id)
    data = from_sql_get_data(sql)
    return data


## 获取 event_detail 传入 event_id 后 event_detail 中该事件的所有情况。
def get_all_details():
    sql = """select event_eventbase.*, event_eventdetail.event_stat, event_eventdetail.event_time from 
                  (
                  select * from event_eventdetail 
                      where event_id not in 
                      (select event_id from event_eventdetail where event_stat != "发生")
                  ) as  event_eventdetail
                  left join event_eventbase     
                  on event_eventdetail.event_id = event_eventbase.id
    		where event_eventdetail.event_stat = '发生';"""
    data = from_sql_get_data(sql)
    return data


def test_json(requset):
    return JsonResponse(get_details(2))


@login_required
def homepage(request):
    return render(request, "event/index.html", {})


def warning_index(request):
    ## 只显示前面6条; 而且是没看过的; 后期要更改, 没有后面两个阶段的，才选出来
    res = get_all_details()["data"]
    datas = res[:6]
    e_ids = [x["id"] for x in datas]
    return render(request, "event/warning.html", {"datas": datas, "e_ids": e_ids})

from datetime import datetime
## 处理时间的详情页面; warning.html,
@login_required
def event_detail(request, e_id):
    data = get_details(int(e_id))
    # print(data)
    ## 增加一条 Detail 记录 is_seen=1,
    data2 = from_sql_get_data("""select * from event_eventdetail where event_id={}""".format(e_id))
    ## 如果Detail该条目只有一条执行下面的程序
    if(len(data2["data"])) > 1:
        pass
    else:
        params = {
            "event_stat": "签收",
            "event_time":str(datetime.today()),
            "extra_add": "页面点击签收",
            "event_id": int(e_id),
            "opreater_name": request.user.username
        }

        sql = """insert into event_eventdetail(event_stat, event_time, extra_add, event_id, opreater_name) 
                values('{event_stat}', '{event_time}', '{extra_add}', {event_id}, '{opreater_name}')""".format(**params)
        sql_action(sql)
    return render(request, "event/warning_detail.html", {"res": data, "e_id": e_id})


def event_desolve(request):
    e_id = request.GET["e_id"]
    extra_add = request.GET["extra"]
    params = {
        "event_stat": "处理",
        "event_time": str(datetime.today()),
        "extra_add": extra_add,
        "event_id": int(e_id),
        "opreater_name": request.user.username
    }
    sql = """insert into event_eventdetail(event_stat, event_time, extra_add, event_id, opreater_name) 
                    values('{event_stat}', '{event_time}', '{extra_add}', {event_id}, '{opreater_name}')""".format(
        **params)
    sql_action(sql)
    return HttpResponse("您的处理已经提交！")


def solve_timeline(e_id):
    res = from_sql_get_data("""select * from event_eventdetail where event_id = {}""".format(int(e_id)))




from django.http import HttpResponse
# Create your views here.
def send_email(request):
    # from __future__ import unicode_literals
    from django.conf import settings
    from django.core.mail import EmailMultiAlternatives

    html_content = request.GET["subject"]
    geter = request.GET["geter"]

    subject = '清朗元安审计邮件|IM'
    # html_content = '<p>这是一封<strong>重要的</strong>邮件.</p>'
    msg = EmailMultiAlternatives(subject, html_content, 'm13429888211@163.com', [].append(geter))
    msg.attach_alternative(html_content, "text/html")
    msg.send()
    return HttpResponse("发送成功")


def sql_all():
    ### 签收未处理的所有条目;;; 发生|签收 才是唯一的，所以在 detail 中查找发生的即可得到所有的满足案例。
    sql = """select event_eventbase.*, event_eventdetail.event_stat, event_eventdetail.event_time from 
                  (select * from event_eventdetail 
                      where event_id in 
                        (select event_id from (
                          select event_id,count(event_id) as ce from event_eventdetail 
                            group by event_id) as t where ce =2
                        )
                  ) as event_eventdetail
                  left join event_eventbase     
                  on event_eventdetail.event_id = event_eventbase.id
                where event_eventdetail.event_stat = "发生";"""