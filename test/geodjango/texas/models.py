# This is an auto-generated Django model module created by ogrinspect.
from django.contrib.gis.db import models


class TexasBorder(models.Model):
    filename = models.CharField(max_length=254)
    pt_count = models.IntegerField()
    pt_spacing = models.FloatField()
    z_min = models.FloatField()
    z_max = models.FloatField()
    geom = models.MultiPolygonField(srid=4326)
    objects = models.GeoManager()

# Auto-generated `LayerMapping` dictionary for TexasBorder model
texasborder_mapping = {
    'filename': 'FileName',
    'pt_count': 'Pt_Count',
    'pt_spacing': 'Pt_Spacing',
    'z_min': 'Z_Min',
    'z_max': 'Z_Max',
    'geom': 'MULTIPOLYGON',
}
