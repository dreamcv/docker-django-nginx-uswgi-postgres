from django.shortcuts import render
from django.http import JsonResponse, HttpResponse

from event.views import from_sql_get_data, sql_action


def homepage(request):
    return render(request, "jtopot/index.html", {})


def get_form_input(request):
    pass


## 原始Demo的数据; 1116版本
def get_config_data(requset):
    from event.views import DB_CONFIG, from_sql_get_data, sql_action
    sql = "select event_src from event_eventbase;"
    res = from_sql_get_data(sql)
    ips = [x["event_src"] for x in res["data"]]

    data = []
    unique_ips = []
    for ip in ips:
        if ip not in unique_ips:
            unique_ips.append(ip)
            g_dict = {}
            g_dict.setdefault("ip", ip)
            g_dict.setdefault("stat", 1)
        data.append(g_dict)

    for i in range(12):
        ip = "192.168.156." + str(i+1)
        g_dict = {}
        g_dict.setdefault("ip", ip)
        g_dict.setdefault("stat", 0)
        data.append(g_dict)

    fang = int(len(data) ** (0.5)) + 1

    return JsonResponse({"data": data, "fang":fang})

################## 1117 记录; 版本0.2;
def yanshi(request):
    return render(request, "jtopot/demo/demo.html", {})


def factory_jip(request, sql, opreate):
    from datetime import datetime
    params = {
        "ip": request.GET["ip"],
        "stat": request.GET["stat"],
        "belongCate": request.GET["belongCate"],
        "tc_text": request.GET["tc_text"],
        "add_date": datetime.today()
    }

    try:
        sql_action(sql.format(**params))
    except:
        return HttpResponse(opreate + request.GET["ip"] + " 条目失败")

    #sql_action(sql.format(**params))
    return HttpResponse("已经"+opreate + request.GET["ip"] + " 条目")

#### 127.0.0.1:8000/jtopo/add_ip/?ip=192.168.111.1&stat=0&belongCate=server&tc_text=what001
def add_ip(request):
    sql = """insert into jtopot_jips(ip, stat, belongCate, tc_text, add_date) 
                                values('{ip}', {stat}, '{belongCate}', '{tc_text}', '{add_date}')"""
    return factory_jip(request, sql, "添加")


def edit_ip(request):
    ### 注意如果用replace into 的话没有制定 IP 为唯一的 key 所以会重复添加
    sql = "delete from jtopot_jips where ip = '{}'".format(request.GET["ip"])
    sql_action(sql)
    sql2 = """insert into jtopot_jips(ip, stat, belongCate, tc_text, add_date) 
                                values('{ip}', {stat}, '{belongCate}', '{tc_text}', '{add_date}')"""
    return factory_jip(request, sql2, "编辑")


def delete_ip(request):
    sql = "delete from jtopot_jips where ip = '{}'".format(request.GET["ip"])
    try:
        sql_action(sql)
    except:
        return HttpResponse("删除" + request.GET["ip"] + " 条目失败")
    return HttpResponse("已删除" + request.GET["ip"] + " 条目")


def temp_data(request):
    sql = "select * from jtopot_jips;"
    res = from_sql_get_data(sql)
    datas = res["data"]
    temp_data = []
    unique_ips = []
    for data in datas:
        if data["ip"] not in unique_ips:
            unique_ips.append(data["ip"])
            g_dict = {}
            g_dict.setdefault("ip", data["ip"])
            g_dict.setdefault("stat", data["stat"])
            g_dict.setdefault("tc_text", data["tc_text"])
            g_dict.setdefault("belongCate", data["belongCate"])

            temp_data.append(g_dict)

    fang = int(len(temp_data) ** (0.5)) + 1

    return JsonResponse({"data": temp_data, "fang":fang})


def get_get_modal(request):
    ip = request.GET["ip"]

    html = """
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <button type="button" class="btn btn-danger" onclick="delete_ip('"""+ ip +"""')" style="width:80px;float:right;">删除对象</button>
                <h4 class="modal-title" id="myModalLabel">IP信息修改 - <strong>"""+ ip +""" </strong></h4>
                 
            </div>

            <p>
                <x style="width:80px;float:left;">-</x>
                <input type="text" class="form-control" id="modal_ip" placeholder="IP" style="width:120px;float:left;">
                <input type="text" class="form-control" id="modal_stat" placeholder="状态" style="width:80px;float:left;">
                <input type="text" class="form-control" id="modal_tc" placeholder="弹出" style="width:80px;float:left;">
                <input type="text" class="form-control" id="modal_png" placeholder="server|host" style="width:110px;float:left;">
               
               <button style="width:50px;float:center;" type="button" class="btn btn-info" data-dismiss="modal" onclick="add_ip('"""+ ip +"""')" >添加</button>
               
            </p>
            <h5> 这个地方可以插入关于 ip 的 div 表格——略 </h5>
            <div id="msg" class="modal-body">  </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div>
            """




    return HttpResponse(html)



