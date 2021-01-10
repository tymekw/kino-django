# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Hall(models.Model):
    hall_id = models.IntegerField(db_column='hall_ID', primary_key=True)  # Field name made lowercase.
    seats_number = models.IntegerField(blank=True, null=True)
    hall_category = models.CharField(max_length=10, blank=True, null=True)
    
    def __str__ (self):
        return str(self.hall_id) + " " + str(self.hall_category)

    class Meta:
       # managed = False
        db_table = 'hall'


class Movie(models.Model):
    movie_id = models.AutoField(db_column='movie_ID', primary_key=True)  # Field name made lowercase.
    title = models.CharField(max_length=100, blank=True, null=True)
    length = models.IntegerField(blank=True, null=True)
    rating = models.DecimalField(max_digits=3, decimal_places=2, blank=True, null=True)
    language = models.CharField(max_length=45, blank=True, null=True)
    director = models.CharField(max_length=40, blank=True, null=True)
    genre = models.CharField(max_length=45, blank=True, null=True)

    class Meta:
        #managed = False
        db_table = 'movie'

    def __str__(self):
        return self.title

class MovieShowtime(models.Model):
    showtime_id = models.IntegerField(db_column='showtime_ID', primary_key=True)  # Field name made lowercase.
    date = models.DateTimeField(blank=True, null=True)
    movie = models.ForeignKey(Movie, models.DO_NOTHING, db_column='movie_ID', blank=True, null=True)  # Field name made lowercase.
    hall = models.ForeignKey(Hall, models.DO_NOTHING, db_column='hall_ID')  # Field name made lowercase.
    screening_category = models.CharField(max_length=10, blank=True, null=True)
    subtitles = models.IntegerField(blank=True, null=True)
    voiceover = models.IntegerField(blank=True, null=True)
    dubbing = models.IntegerField(blank=True, null=True)

    class Meta:
        #managed = False
        db_table = 'movie_showtime'
    
    def __str__(self):
        return str(self.showtime_id)+' '+ str(self.movie.title) +' '+ str(self.date)

class Seat(models.Model):
    seat_id = models.AutoField(db_column='seat_ID', primary_key=True)  # Field name made lowercase.
    hall = models.ForeignKey(Hall, models.DO_NOTHING, db_column='hall_ID', blank=True, null=True)  # Field name made lowercase.
    showtime = models.ForeignKey(MovieShowtime, models.CASCADE, db_column='showtime_ID', blank=True, null=True)
    seat_number = models.IntegerField(blank=True, null=False)
    row_num = models.IntegerField(blank=True, null=True)
    category = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
       # managed = False
        db_table = 'seat'

    def __str__(self):
        return str(self.seat_number) + ' ' + str(self.showtime)

class Ticket(models.Model):
    ticket_id = models.AutoField(db_column='ticket_ID', primary_key=True)  # Field name made lowercase.
    seat = models.ForeignKey(Seat, models.CASCADE, db_column='seat_ID', blank=True, null=True)  # Field name made lowercase.
    showtime = models.ForeignKey(MovieShowtime, models.CASCADE, db_column='showtime_ID', blank=True, null=True)  # Field name made lowercase.
    price = models.DecimalField(max_digits=4, decimal_places=2, blank=True, null=True)
    price_category = models.CharField(max_length=45, blank=True, null=True)

    class Meta:
      #  managed = False
        db_table = 'ticket'

    def __str__(self):
        return str(self.ticket_id)
