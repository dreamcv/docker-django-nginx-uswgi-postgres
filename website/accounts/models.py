from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.core.urlresolvers import reverse
from django.contrib.sites.models import Site


class ProjUser(AbstractUser):
    nickname = models.CharField('昵称', max_length=50, blank=True)
    mugshot = models.ImageField('头像', upload_to='upload/mugshots', blank=True)

    # objects = BlogUserManager()

    def get_absolute_url(self):
        return "/u/{}/".format(self.id)

    def __str__(self):
        return self.username

    def get_full_url(self):
        site = Site.objects.get_current().domain
        url = "https://{site}{path}".format(site=site, path=self.get_absolute_url())
        return url

    class Meta:
        verbose_name = "网站扩展用户"


# Create your models here.
class UserShenFen(models.Model):
    shenfen = models.CharField('身份', max_length=50, blank=True)
    proty = models.IntegerField('权限标志|/d', blank=True)
    webuser = models.ForeignKey(ProjUser, verbose_name="网站用户", default=None)

    class Meta:
        verbose_name = "用户身份表|固定填写"


    def __str__(self):
        return self.shenfen +"::" + self.webuser.username





