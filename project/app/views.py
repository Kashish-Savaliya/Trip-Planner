from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from .models import User, State, Place, Nearby_Place, travel_and_cost
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.hashers import make_password, check_password
import requests
from .forms import ItineraryForm
from django.core.mail import send_mail

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
    transportation = travel_and_cost.objects.filter(category='TRANSPORTATION')
    accommodation = travel_and_cost.objects.filter(category='ACCOMMODATION')
    food = travel_and_cost.objects.filter(category='FOOD')
    sightseeing = travel_and_cost.objects.filter(category='SIGHTSEEING')
    overall_cost = travel_and_cost.objects.filter(category='OVERALL_COST')
    context = {
        'place':place_obj,'nearbyplaces':nearby_places,'histories':histories,
        'transportation': transportation,
        'accommodation': accommodation,
        'food': food,
        'sightseeing': sightseeing,
        'overall_cost': overall_cost
    }
    return render(request, 'index2.html', context)
    

def plan_trip(request):
    if request.method == "POST":
        form = ItineraryForm(request.POST)
        if form.is_valid():
            source = form.cleaned_data['source']
            destination = form.cleaned_data['destination']
            days = form.cleaned_data['days']
            budget = form.cleaned_data['budget']
            email = form.cleaned_data['email']

            possible_routes = get_routes(source, destination)
            hotels = get_hotels(destination, budget)
            transport_modes = get_transport_modes(source, destination)

            total_cost = calculate_total_cost(hotels, transport_modes, days)

            send_feedback_email(email, source, destination)

            return render(request, 'itinerary.html',{
                'source' : source,
                'destination' : destination,
                'days' : days,
                'budget' : budget,
                'total_cost' : total_cost,
                'possible_routes' : possible_routes,
                'hotels' : hotels,
                'transport_modes' : transport_modes,
            })
        else:
            form = ItineraryForm()
        return render(request, 'plan_trip.html', {'form': form})
    

def feedback(request):
    return render(request, 'feedback.html')

def get_hotels(destination, budget):
    response = requests.get('API_URL',params={'location': destination, 'budget': budget})
    return response.json()

def get_transport_modes(source, destination):
    response = requests.get('API_URL', params={'source': source, 'destination': destination})
    return response.json()

def send_feedback_email(email, source, destination):
    send_mail('We\'d love your feedback!',
        f'Thank you for using our service! How was your trip from {source} to {destination}? Please share your feedback by clicking the link: http://127.0.0.1:8000/feedback',
        'your_email@example.com',
        [email],
        fail_silently=False,
    )

# def geocode_address(address, api_key):
#     """
#     Converts an address into geographical coordinates (latitude and longitude) using GraphHopper Geocoding API.

#     Args:
#     - address (str): The address or place name to be geocoded.
#     - api_key (str): Your GraphHopper API key.

#     Returns:
#     - tuple: A tuple containing the latitude and longitude of the address, or None if geocoding fails.
#     """
#     url = "https://graphhopper.com/api/1/geocode"
#     params = {
#         "q": address,
#         "key": api_key,
#         "limit": 1
#     }
#     try:
#         response = requests.get(url, params=params)
#         data = response.json()

#         if response.status_code == 200 and data['hits']:
#             geometry = data['hits'][0]['point']
#             return (geometry['lat'], geometry['lng'])
#         else:
#             print(f"Geocoding failed for address: {address}")
#             return None
#     except Exception as e:
#         print(f"An error occurred during geocoding: {e}")
#         return None

# def get_routes(source, destination, graphhopper_api_key):
#     """
#     Fetches routes from the GraphHopper Directions API between a source and destination.

#     Args:
#     - source (tuple): The source coordinates as a tuple (latitude, longitude).
#     - destination (tuple): The destination coordinates as a tuple (latitude, longitude).
#     - graphhopper_api_key (str): Your GraphHopper API key.

#     Returns:
#     - list: A list of route instructions.
#     """
#     url = "https://graphhopper.com/api/1/route"
#     params = {
#         "point": [f"{source[0]},{source[1]}", f"{destination[0]},{destination[1]}"],
#         "vehicle": "car",  # Default to 'car', can be changed dynamically
#         "locale": "en",
#         "points_encoded": "false",
#         "instructions": "true",
#         "key": "091baf08-7a73-4895-accb-0862f8fdabca"
#     }
#     try:
#         response = requests.get(url, params=params)
#         if response.status_code == 200:
#             data = response.json()
#             routes = data['paths'][0]['instructions']
#             route_instructions = [step['text'] for step in routes]
#             return route_instructions
#         else:
#             print(f"Error: Unable to fetch routes. Status Code: {response.status_code}")
#             return []
#     except Exception as e:
#         print(f"An error occurred: {e}")
#         return []

# # Example usage
# # Replace with your actual API key
# graphhopper_api_key = "091baf08-7a73-4895-accb-0862f8fdabca"

# # Example: Dynamic user input for source and destination
# source_address = input("Enter source address or place name: ")  # e.g., "Surat, India"
# destination_address = input("Enter destination address or place name: ")  # e.g., "Rajasthan, India"

# # Convert addresses to coordinates using GraphHopper Geocoding API
# source_coords = geocode_address(source_address, graphhopper_api_key)
# destination_coords = geocode_address(destination_address, graphhopper_api_key)

# # Ensure both geocoding results are valid
# if source_coords and destination_coords:
#     routes = get_routes(source_coords, destination_coords, graphhopper_api_key)
#     for idx, route in enumerate(routes):
#         print(f"Route {idx + 1}: {route}")
# else:
#     print("Unable to retrieve coordinates for the provided addresses.")



