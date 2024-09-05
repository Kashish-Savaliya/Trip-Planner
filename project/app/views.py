from asyncio.log import logger
from django.shortcuts import render, redirect, get_object_or_404, HttpResponse
from django.contrib import messages
from .models import User, State, Place, Nearby_Place, travel_and_cost, Review
from django.contrib.auth import authenticate, login as auth_login
from django.contrib.auth import logout as auth_logout
from .forms import CustomUserCreationForm
from django.contrib.auth.hashers import make_password, check_password
from .itineraries import create_graph, create_routes, plot_routes_on_map, hotel_data, places_data, transportation_data
import folium
import os
from django.http import FileResponse, Http404
from django.conf import settings
from django.contrib.auth.decorators import login_required
from geopy.geocoders import Nominatim
from django.core.mail import send_mail
from django.conf import settings
from django.core.validators import validate_email
from django.core.exceptions import ValidationError

# Create your views here.


def send_email(to_email, subject, body):
    from_email = settings.DEFAULT_FROM_EMAIL  # Uses the default 'from' email set in settings.
    print(to_email)
    try:
        validate_email(to_email)
    except ValidationError:
        print(f"Invalid recipient email: {to_email}")
        return
    try:
        send_mail(
            subject,
            body,
            from_email,
            [to_email],  # List of recipient emails
            fail_silently=False,  # Set to True if you want to suppress exceptions
        )
        print(f"Email sent successfully to {to_email}")
    except Exception as e:
        print(f"An error occurred while sending email: {e}")

def home(request):
    return render(request, 'Home.html')

def main(request):
    return render(request, 'main.html')

def register(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.set_password(form.cleaned_data['password'])
            user.save()
            messages.success(request, "Registration successful. Please log in.")
            return redirect('login')  # Redirect to the login page
        else:
            messages.error(request, "Registration failed. Please correct the errors.")
    else:
        form = CustomUserCreationForm()
    return render(request, 'signup.html', {'form': form})


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
    transportation = place_obj.travel_and_cost.filter(category='TRANSPORTATION')
    accommodation = place_obj.travel_and_cost.filter(category='ACCOMMODATION')
    food = place_obj.travel_and_cost.filter(category='FOOD')
    sightseeing = place_obj.travel_and_cost.filter(category='SIGHTSEEING')
    overall_cost = place_obj.travel_and_cost.filter(category='OVERALL_COST')
    context = {
        'place':place_obj,'nearbyplaces':nearby_places,'histories':histories,
        'transportation': transportation,
        'accommodation': accommodation,
        'food': food,
        'sightseeing': sightseeing,
        'overall_cost': overall_cost
    }
    return render(request, 'index2.html', context)
    
@login_required
def plan_trip(request):
    states = list(places_data.keys())
    places = []
    map_html = None
    transportation_map_html = None
    selected_state = None
    selected_place = None

    if request.method == 'POST':
        # Get common form data
        start_state = request.POST.get('start_state')
        end_state = request.POST.get('end_state')
        num_intermediate = int(request.POST.get('num_intermediate', 0))
        intermediate_states = [request.POST.get(f'intermediate_state_{i}') for i in range(num_intermediate)]
        no_of_days = request.POST.get('days')
        if request.user.is_authenticated:
            user_email = request.user.email
            send_email(user_email, "Thanks for using Pravaspedia!", "We hope you have a great time! Please let us know your precious reviews about using our application")

        # Validate form data
        if not start_state or not end_state:
            return HttpResponse("Start state or end state not provided")
        
        # Check which button was clicked
        if 'plan_trip' in request.POST:
            # Logic for 'Plan Trip' button
            G = create_graph()
            if not G.has_node(start_state) or not G.has_node(end_state):
                return HttpResponse("Invalid start or end state")

            for state in intermediate_states:
                if not G.has_node(state):
                    return HttpResponse(f"Invalid intermediate state: {state}")
            all_routes = create_routes(G, start_state, end_state, intermediate_states)
            sorted_routes = sorted(all_routes, key=len)
            top_5_routes = sorted_routes[:5]
            plot_routes_on_map(top_5_routes, G)
            
            return redirect('view_map', filename='top_5_routes.html')

        elif 'view_hotels' in request.POST:
             # Logic for 'View Hotels' button
            selected_state = end_state
            selected_place = request.POST.get('place')

            if selected_state:
                places = places_data.get(selected_state, [])

            if selected_place:
                # Get the hotels for the selected place
                hotels = hotel_data.get(selected_place, [])
                if hotels:
                    # Generate the map with markers for all hotels
                    map_center = hotels[0]["location"]
                    m = folium.Map(location=map_center, zoom_start=14)

                    # Add hotel markers to the map
                    for hotel in hotels:
                        popup_content = f"""
                        <div>
                            <span style="color:red; font-weight:bold;">{hotel['name']}</span><br>
                            <a href="{hotel['website']}" target="_blank">
                                <button style="margin-top:5px;">Visit Website</button>
                            </a>
                        </div>
                        """
                        folium.Marker(
                            location=hotel["location"],
                            popup=folium.Popup(popup_content, max_width=400),
                            icon=folium.Icon(color='red', icon='info-sign')
                        ).add_to(m)

                    # Ensure the 'static' directory exists
                    if not os.path.exists('static'):
                        os.makedirs('static')

                    # Save the map to the 'static' directory
                    static_dir = os.path.join(os.path.dirname(__file__), 'static')
                    map_path = os.path.join(static_dir, 'map.html')
                    print(f"Map path: {map_path}")
                    m.save(map_path)
                    map_html = 'map.html'
                
        elif 'view_transportation' in request.POST:
        # Logic for 'View Transportation' button
            # print("Transportation button clicked")
            selected_state = start_state
            selected_place = request.POST.get('place')
            # print(f"{selected_state} : {selected_place}")
            if selected_state:
                places = places_data.get(selected_state, [])

            if selected_place:
                # Get the transportation options for the selected place
                transportation = transportation_data.get(selected_state, [])
                # print(f"{transportation}")
                if transportation:
                    # Generate the map with markers for all transportation options
                    map_center = transportation[0]["services"][0]["location"]     
                    m = folium.Map(location=map_center, zoom_start=14)

                    # Add transportation markers to the map
                    for city_data in transportation:
                        city = city_data["city"]
                        for transport in city_data["services"]:
                            popup_content = f"""
                            <div>
                                <span style="color:blue; font-weight:bold;">{city}</span><br>
                                <span style="color:blue; font-weight:bold;">{transport['operator']}</span><br>
                                <span style="color:blue; font-weight:bold;">{transport['contact']}</span><br>
                                <span style="color:blue; font-weight:bold;">{transport['type']}</span><br>
                                <a href="{transport['website']}" target="_blank">
                                    <button style="margin-top:5px;">Visit Website</button>
                                </a>
                            </div>
                            """
                            folium.Marker(
                                location=transport["location"],
                                popup=folium.Popup(popup_content, max_width=400),
                                icon=folium.Icon(color='blue', icon='info-sign')
                            ).add_to(m)

                    # Ensure the 'static' directory exists
                    if not os.path.exists('static'):
                        os.makedirs('static')

                    # Save the map to the 'static' directory
                    static_dir = os.path.join(os.path.dirname(__file__), 'static')
                    map_path = os.path.join(static_dir, 'transportation_map.html')
                    print(f"Transportation Map HTML Path: {map_path}")
                    m.save(map_path)
                    transportation_map_html = 'transportation_map.html'
                    # return redirect('view_map', filename='top_5_routes.html')
                
    return render(request, 'itinerary.html', {
        'states': states,
        'places': places,
        'selected_state': selected_state,
        'selected_place': selected_place,
        'map_html': map_html,
        'transportation_map_html' : transportation_map_html,
    })
     
def view_map(request, filename):
    # Construct the path to the static directory
    file_path = os.path.join(settings.BASE_DIR, 'app', 'static', filename)
    
    if os.path.exists(file_path):
        return FileResponse(open(file_path, 'rb'), content_type='text/html')
    else:
        raise Http404("File does not exist")
    

@login_required    
def getFeedback(request):
    if request.method == "POST":
        name = request.POST.get('name')
        location = request.POST.get('location')
        rating = request.POST.get('rating')
        review_text = request.POST.get('review')
        feedback = Review(name=name, location=location, rating = rating, review=review_text)
        feedback.save()
    reviews = Review.objects.all()
    # print(reviews)
    return render(request, 'review.html',{'reviews':reviews})






