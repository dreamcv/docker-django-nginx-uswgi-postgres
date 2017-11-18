from django.contrib import admin

# Register your models here.

from .models import  EventDetail, EventBase


# admin.site.register(Stat)
admin.site.register(EventDetail)
# admin.site.register(Stations)
# admin.site.register(EventCate)
admin.site.register(EventBase)
