from django.urls import path
from . import views

urlpatterns = [
    path('',views.home,name='home'),
    path('main/',views.main,name='main'),
    path('login/',views.login,name='login'),
    path('register/',views.register,name='register'),
    path('logout/',views.logout,name='logout'),
    # path('gallery/',views.gallery,name='gallery'),
    # path('iternaries/',views.iternaries,name='iternaries'),
    path('stories/', views.stories,name="stories"),
    path('stories/east', views.east,name="east"),
    path('stories/west', views.west,name="west"),
    path('stories/north', views.north,name="north"),
    path('stories/south', views.south,name="south"),
    path('stories/<str:direction>/<str:state>',views.hidden_gems,name='hidden_gems'),
    path('stories/<str:direction>/<str:state>/<str:place>',views.place,name='place'),
    path('review/',views.getFeedback ,name="review"),

]
