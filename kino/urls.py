from django.urls import path

from . import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', views.index, name='index'),
    path('<int:movie_id>/', views.detail, name='detail'),
    path('seats/<int:showtime_id>/', views.seats, name='seats'),
    path('confirm/<int:seat_ID>/', views.confirm, name='confirm'),
    path('confirm/<int:seat_ID>/done/<int:showtime_ID>', views.confirmed , name='ticket'),
]+ static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
