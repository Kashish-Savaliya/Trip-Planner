from django import forms 

class ItineraryForm(forms.Form):
    source = forms.CharField(max_length=100)
    destination = forms.CharField(max_length=100)
    days = forms.IntegerField()
    budget = forms.DecimalField(max_digits=10, decimal_places=2)
    email = forms.EmailField()