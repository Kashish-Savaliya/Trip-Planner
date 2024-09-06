from django.contrib import admin
from .models import User, Place, Nearby_Place,State, hist_back

# Register your models here.
admin.site.register(User)
admin.site.register(Place)
admin.site.register(Nearby_Place)
admin.site.register(State)
admin.site.register(hist_back)