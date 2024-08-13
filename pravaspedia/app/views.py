from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from .models import User, State, Place, Nearby_Place
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.hashers import make_password, check_password

# Create your views here.

def home(request):
    return render(request, 'Home.html')

def main(request):
    return render(request, 'main.html')

def register(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        repassword = request.POST.get('repassword')
        location = request.POST.get('location')

        if password != repassword:
            messages.error(request, 'Passwords do not match!')
        elif User.objects.filter(email=email).exists():
            messages.error(request, 'Email already exists.')
        else:
            hashed_password = make_password(password)
            user = User(email=email, name='YourNameHere', location=location, password=hashed_password)
            user.save()
            
            messages.success(request, 'Successfully signed up! Please log in.')
            return redirect('login')
    return render(request, 'signup.html')


def login(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        try:
            user = User.objects.get(email=email)
            if check_password(password, user.password):
                # Manually log in the user (set session data here)
                request.session['user_id'] = user.id
                messages.success(request, "Successfully Logged In")
                return redirect("main")
            else:
                messages.error(request, "Invalid credentials! Please try again")
                return redirect("login")
        except User.DoesNotExist:
            messages.error(request, "Invalid credentials! Please try again")
            return redirect("login")
    return render(request, 'login.html')

def logout(request):
    logout(request)
    messages.success(request,"Successfully Logged Out")
    return redirect('main')


def stories(request):
    return render(request, 'Stories.html')

def east(request):
    return render(request, 'East.html')

def west(request):
    return render(request, 'West.html')

def north(request):
    return render(request, 'North.html')

def south(request):
    return render(request, 'South.html')

def hidden_gems(request, direction, state):
    state_obj = get_object_or_404(State, state_name=state,direction=direction)
    hidden_places = state_obj.places.all()
    return render(request, 'J_K.html',{'state':state_obj, 'hidden_places':hidden_places,'direction':direction})

def place(request, direction, state, place):
    place_obj = get_object_or_404(Place, place_name=place,state__state_name=state)
    nearby_places = place_obj.nearby_places.all()
    histories = place_obj.histories.all()
    return render(request, 'index2.html', {'place':place_obj,'nearbyplaces':nearby_places,'histories':histories})
    