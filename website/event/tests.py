#from django.test import TestCase

# Create your tests here.
import os

###
from os.path import dirname, abspath
PROJECT_DIR = dirname(dirname(abspath(__file__)))
import sys
sys.path.insert(0, PROJECT_DIR)
os.environ["DJANGO_SETTINGS_MODULE"] = "qlshenji.settings"

import django
django.setup()


e_id = 3

def test(e_id):
    sql = """select e.event_name, e.event_cate, ed.* from event_eventdetail as ed 
                      left join event_eventbase as e
                      on ed.event_id = e.id
        				where ed.event_id={};
            """.format(e_id)
    from event.views import from_sql_get_data
    res = from_sql_get_data(sql)
    res_data = res["data"]
    days = [x["event_time"].date() for x in res_data]

    start_str = """ <div class="box-body">
    			 <!-- The time line -->
    			<ul class="timeline">
    			  <!-- timeline time label -->
    			  """

    result_str = """"""
    result_str += start_str
    for day in days:
        start_str += """  <li class="time-label">
				<span class="bg-green">
				  {date}
				</span>
			  </li>""".format(date=day)

        for e in [x for x in res_data if x["event_time"].date() == day]:
            params = {
                "e_time": e["event_time"].time(),
                "event_cate": e["event_cate"],
                "extra_add": e["extra_add"]
            }
            start_str += """<li>
				<i class="fa bg-aqua"></i>
				<div class="timeline-item">
				  <span class="time"><i class="fa fa-clock-o"></i> {e_time}</span>
				  <h3 class="timeline-header"><a href="#">{event_cate}</a></h3>
				  <div class="timeline-body">
					{extra_add}
				  </div>
				</div>
			  </li>""".format(**params)

    result_str +="""
    			  <li>
    				<i class="fa fa-clock-o bg-gray"></i>
    			  </li>
    			</ul>
           </div><!-- /.box-body -->"""

    return result_str

test(3)