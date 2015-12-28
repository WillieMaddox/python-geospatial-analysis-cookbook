from django.contrib.gis import admin
from models import TexasBorder

admin.site.register(TexasBorder, admin.OSMGeoAdmin)
