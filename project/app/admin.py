from django.contrib import admin
from .models import User, Place, Nearby_Place,State, hist_back, travel_and_cost, Review

# Register your models here.
admin.site.register(User)
admin.site.register(Place)
admin.site.register(Nearby_Place)
admin.site.register(State)
admin.site.register(hist_back)
admin.site.register(Review)

@admin.register(travel_and_cost)
class TripDetailAdmin(admin.ModelAdmin):
    list_display = ('category', 'title', 'cost', 'description','main_place')    #This defines which fields are shown in the list view of the model in the Django admin panel.
    list_filter = ('category',)  # This adds a filter sidebar to the list page in the admin panel, allowing admins to filter the displayed entries based on specific fields.
    search_fields = ('title', 'description')   #This adds a search box to the list view in the admin panel, enabling text-based searches within the specified fields.
