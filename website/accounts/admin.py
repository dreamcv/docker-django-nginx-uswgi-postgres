from django.contrib import admin

# Register your models here.
from .models import ProjUser, UserShenFen

admin.site.register(ProjUser)
admin.site.register(UserShenFen)
