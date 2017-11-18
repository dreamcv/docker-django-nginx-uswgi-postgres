from django.db import models

# Create your models here.
class JIps(models.Model):
    ip = models.CharField('主机或者服务器IP', max_length=20, default="127.0.0.1")
    stat = models.IntegerField('状态|ip', default=0)
    belongCate = models.CharField('IP所属类型', max_length=20, default="host")
    tc_text = models.CharField('弹出text', max_length=20, default="预警信息")
    add_date = models.DateTimeField("添加时间", auto_now_add=True)
    # id = models.AutoField(primary_key=True)

    class Meta:
        verbose_name = "Jtopo里面的IP"

    def __str__(self):
        return self.ip
