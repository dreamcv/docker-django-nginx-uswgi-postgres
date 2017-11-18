#!/usr/bin/env python
# encoding: utf-8
from django.core.urlresolvers import reverse
from django import template

register = template.Library()
from django.template.defaultfilters import stringfilter

@register.filter(name="shenfen")
def load_oauth_applications(User):
    from accounts.models import UserShenFen
    return UserShenFen.objects.get(webuser=User).shenfen


@register.filter(name="data2html")
def data2html(data):
    if int(data["port"]) < 500:
        string = """<!-- cate 4 -->
                <div class="alert alert-danger alert-dismissable">
                  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
		
                  <h4>  <i class="icon fa fa-check"></i> """ + data["event_cate"] + """</h4>
                  """+ data["event_name"] + """
                  <p>
                  <button class="btn btn-outline" name='sign""" + str(data["id"]) +"""'>签收</button>
                  </p>
                </div>"""
        return string

    elif(int(data["port"]) < 1000):
        string = """				
                <div class="alert alert-info alert-dismissable">
                  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                       <h4><i class="icon fa fa-info"></i>  """ + data["event_cate"] + """</h4>
                       """ + data["event_name"] + """
                       <p>
                        <button class="btn btn-outline" name='sign"""+  str(data["id"])  +"""'>签收</button>
                       </p>
                     </div>"""
        return string


    elif(int(data["port"]) < 3500):
        string = """				
                <div class="alert alert-warning alert-dismissable">
                  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                  <h4><i class="icon fa fa-warning"></i>""" + data["event_cate"] + """</h4>
                               """ + data["event_name"] + """
                               <p>
                                 <button class="btn btn-outline" name='sign"""+  str(data["id"])  +"""'>签收</button>
                               </p>
                             </div>"""
        return string

    else:
        string = """<div class="alert alert-danger alert-dismissable">
                  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                  <h4><i class="icon fa fa-ban"></i>""" + data["event_cate"] + """</h4>
                                       """ + data["event_name"] + """
                                       <p>
                                         <button class="btn btn-outline" name='sign"""+  str(data["id"])  +"""'>签收</button>
                                       </p>
                                     </div>"""
        return string


@register.filter(name="is_in_deled")
def is_in_deled(e_id):
    from event.views import from_sql_get_data
    res = from_sql_get_data("""select * from event_eventdetail where event_stat = '处理' and event_id = {}""".format(int(e_id)))
    if(len(res["data"]) > 0):
        return "run(2);"
    return ""


@register.filter(name="deled_detail_by_eid")
def deled_detail_by_eid(e_id):
    sql = """select e.event_name, e.event_cate, ed.* from event_eventdetail as ed 
                          left join event_eventbase as e
                          on ed.event_id = e.id
            				where ed.event_id={};
                """.format(int(e_id))
    from event.views import from_sql_get_data
    res = from_sql_get_data(sql)
    res_data = res["data"]
    days = [x["event_time"].date() for x in res_data]
    ### 对 天数去重
    new_days = []
    for day in days:
        if day not in new_days:
            new_days.append(day)

    result_str = """"""
    result_str += """ <div class="box-body">
        			 <!-- The time line -->
        			<ul class="timeline">
        			  <!-- timeline time label -->
        			  """
    i = 0
    for day in new_days:
        result_str += """  <li class="time-label">
    				<span class="bg-green">
    				  {date}
    				</span>
    			  </li>""".format(date=day)

        for e in [x for x in res_data if x["event_time"].date() == day]:
            params = {
                "e_time": e["event_time"].time(),
                "event_cate": e["event_cate"],
                "extra_add": e["extra_add"],
                "event_name": e["event_name"],
                "opreater_name": e["opreater_name"]
            }
            if i == 0:
                result_str += """<li>
                        <i class="fa bg-aqua"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="fa fa-clock-o"></i> {e_time}</span>
                          <h3 class="timeline-header"><a href="#">{event_cate}</a></h3>
                          <div class="timeline-body">
                            {event_name} <h3>发生</h3>
                          </div>
                        </div>
                      </li>""".format(**params)
            else:
                result_str += """<li>
                                        <i class="fa bg-aqua"></i>
                                        <div class="timeline-item">
                                          <span class="time"><i class="fa fa-clock-o"></i> {e_time}</span>
                                          <h3 class="timeline-header"><a href="#">{event_cate}</a></h3>
                                          <div class="timeline-body">
                                            <strong>处理人:{opreater_name}</strong>
                                            </br>
                                            {extra_add}
                                          </div>
                                        </div>
                                      </li>""".format(**params)

            i += 1

    result_str += """
        			  <li>
        				<i class="fa fa-clock-o bg-gray"></i>
        			  </li>
        			</ul>
               </div><!-- /.box-body -->"""

    return result_str



