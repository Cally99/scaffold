from django.db import models

# Create your models here.
class Example(models.Model):
    example_id = models.AutoField(primary_key = True)
    description = models.TextField()
