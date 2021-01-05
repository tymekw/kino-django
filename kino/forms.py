from django import forms

class SeatChoise(forms.Form):
    seat = forms.IntegerField(label="Enter seat")
