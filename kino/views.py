from django.http import HttpResponse, Http404
from .models import Movie, MovieShowtime, Seat, Ticket
from django.shortcuts import get_object_or_404, render
from django.db import connection
from collections import namedtuple
#from .forms import Seat
from datetime import datetime

# Create your views here.
def index(request):
	movies = Movie.objects.all()
	context = {'movies': movies}
	return render(request, 'index.html', context)


def detail(request, movie_id):
	try:
		movie_showtimes = MovieShowtime.objects.filter(movie=movie_id, date__gte=datetime.now())
	except:
		raise Http404
	return render(request, 'detail.html', {'movie_showtimes': movie_showtimes})

def dictfetchall(cursor):
	"Return all rows from a cursor as a dict"
	columns = [col[0] for col in cursor.description]
	return [
		dict(zip(columns, row))
		for row in cursor.fetchall()
	]

def seats(request, showtime_id):
	#try:
	#	seats = Seat.objects.filter(showtime=showtime_id)
	#except:
	#	raise Http404
	with connection.cursor() as cursor:
		cursor.execute("SELECT * FROM seat WHERE showtime_ID = %s", [showtime_id])
		rows =dictfetchall(cursor)
	return render(request, 'seats.html',{'seats': rows})

def confirm(request, seat_ID):
	with connection.cursor() as cursor:
		cursor.execute(
		'''SELECT s.seat_ID, s.seat_number, s.category, s.row_num, sh.date, m.title, sh.hall_ID, sh.showtime_ID
		FROM seat s, movie_showtime sh, movie m
		WHERE s.seat_ID = %s and s.showtime_ID=sh.showtime_ID and sh.movie_ID = m.movie_ID''', [seat_ID])
		rows = dictfetchall(cursor)
	return render(request, 'confirm.html',{'seats': rows})


def confirmed(request, seat_ID, showtime_ID):
	check = Ticket.objects.all()
	if not check.filter(seat_id=seat_ID, showtime_id=showtime_ID).exists():
		with connection.cursor() as cursor:
			cursor.execute(
			'''UPDATE seat SET category='not-empty' WHERE seat_ID=%s''', [seat_ID]
			)
			cursor.execute(
			'''INSERT INTO ticket (seat_ID, showtime_ID, price, price_category)
			VALUES(%s,%s, 15, 'ULGOWY')''', [seat_ID, showtime_ID]
			)
			cursor.execute(
			'''SELECT t.price, t.price_category, t.showtime_ID, sh.date, m.title, s.seat_number, s.row_num, h.hall_ID  
			FROM ticket t LEFT JOIN movie_showtime sh ON sh.showtime_ID=t.showtime_ID
			LEFT JOIN seat s ON s.seat_ID = t.seat_ID
			LEFT JOIN movie m ON sh.movie_ID = m.movie_ID 
			LEFT JOIN hall h ON h.hall_ID = sh.hall_ID
			where t.seat_ID = %s and t.showtime_ID=%s''', [seat_ID, showtime_ID]
			)
			rows = dictfetchall(cursor)
		return render(request, 'ticket.html',{'ticket': rows})
	else:
		return render(request, 'ticket.html',{'check':check})



