from django.contrib import admin
from .models import Movie, MovieShowtime, Seat, Ticket, Hall 

# Register your models here.
admin.site.register(Movie)
admin.site.register(MovieShowtime)
admin.site.register(Seat)
admin.site.register(Ticket)
admin.site.register(Hall)
