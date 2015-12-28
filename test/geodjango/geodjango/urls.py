from django.conf.urls import include, url
from django.contrib.gis import admin

urlpatterns = [
    # Examples:
    # url(r'^$', 'geodjango.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    #url(r'^admin/', include(admin.site.urls)),
    url(r'^admin/', admin.site.urls),
]
