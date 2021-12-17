from django.db import models


# Create your models here.
class Students(models.Model):
    name = models.TextField()
    age = models.IntegerField()

    def __str__(self):
        return self.name
