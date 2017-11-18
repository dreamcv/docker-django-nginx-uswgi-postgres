"""qlshenji URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from django.views.decorators.cache import cache_page
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
      url(r'^admin/', admin.site.urls),
      url(r'', include('accounts.urls', namespace='account', app_name='accounts')),
      url(r'', include('event.urls', namespace='event', app_name='event')),
      url(r'^jtopo/', include('jtopot.urls', namespace='jtopot', app_name='jtopot')),
      # url(r'', include('servermanager.urls', namespace='servermanager', app_name='servermanagers'))


  ] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)


urlpatterns +=static(
    settings.MEDIA_URL,document_root=settings.MEDIA_ROOT
)
