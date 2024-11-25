import networkx as nx
import folium
from geopy.geocoders import Nominatim
import os

hotel_data = {
    # Uttarakhand
    "Dhanaulti Hill station": [
        {"name": "Glamwood Resort", "website": "https://glamwoodresort.com/", "location": [30.4256, 78.1076]},
        {"name": "Apple Orchard Resort", "website": "https://www.appleorchardresort.com/", "location": [30.4319, 78.1097]},
        {"name": "The Bliss", "website": "https://blissdhanaulti.com/", "location": [30.4333, 78.1054]}
    ],
    "Lansdowne": [
        {"name": "Blue Pine Resort", "website": "https://www.bluepineresort.com/", "location": [29.8378, 78.6853]},
        {"name": "The First View", "website": "https://thefirstviewlansdowne.com/", "location": [29.8413, 78.6764]},
        {"name": "Kasang Regency", "website": "https://www.kasangregency.com/", "location": [29.8352, 78.6789]}
    ],
    "Chaukori hill station": [
        {"name": "Ojaswi Resort", "website": "https://www.ojaswiresort.com/chaukori/", "location": [29.8477, 80.0354]},
        {"name": "Chaukori Heritage", "website": "https://www.chaukoriheritage.com/", "location": [29.8441, 80.0369]},
        # {"name": "The Himalayan View", "website": "https://www.himalayanviewchaukori.com/", "location": [29.8500, 80.0300]}
    ],
    "Nelong valley": [
        {"name": "The Harshil Orchids", "website": "https://theharshilorchids.com/", "location": [30.7747, 79.9499]},
        {"name": "Prakriti Retreat", "website": "https://www.prakriti-retreat.com/", "location": [30.7800, 79.9500]},
        {"name": "Himalaya Sadan", "website": "https://www.hotelhimalayasadan.in/", "location": [30.7700, 79.9400]}
    ],
    "Harsil valley": [
        {"name": "Harsil Cottages", "website": "https://www.dityahotels.com/harsil-cottages/gallery/", "location": [30.6227, 78.8958]},
        {"name": "Harsil Apple Homestay", "website": "https://www.harsilapplehomestay.com/", "location": [30.6200, 78.9000]},
        {"name": "Himalayan Nature Resort", "website": "https://www.himalayannatureresort.com/#/search", "location": [30.6250, 78.8900]}
    ],
    "Chamoli": [
        {"name": "The Tattva", "website": "https://www.thetattva.in/", "location": [30.4565, 79.3155]},
        {"name": "Satopanth - The Auli Resort", "website": "https://www.auli-resort.com/", "location": [30.4600, 79.3100]},
        # {"name": "Mountain View Hotel", "website": "https://www.mountainviewchamoli.com/", "location": [30.4550, 79.3200]}
    ],

    # Karnataka
    "Devaramane Hill": [
        {"name": "Rangi Taranga", "website": "hhttps://www.rangitaranga.in/", "location": [13.2820, 75.2350]},
        {"name": "Aayna Valley Resort", "website": "https://aayanavalley.com/", "location": [13.2800, 75.2300]},
        {"name": "Streamedge Homestay", "website": "https://www.streamedgesakleshpur.com/", "location": [13.2750, 75.2400]}
    ],
    "Kalasa town": [
        {"name": "Mayura Hotel", "website": "https://www.kstdc.co/mayura-hotels/", "location": [13.5662, 75.6337]},
        {"name": "Upasana Resort", "website": "https://www.upasanaresort.com/", "location": [13.5700, 75.6300]},
        {"name": "Silent Valley Resorts", "website": "https://silentvalleyresorts.com/", "location": [13.5650, 75.6200]}
    ],
    "Sasihitlu beach": [
        {"name": "The Oceanic Beach Front", "website": "https://theoceanicbeachfront.com/", "location": [13.1080, 74.8700]},
        {"name": "Nilaya Stays", "website": "https://nilayastays.com/", "location": [13.1100, 74.8750]}
    ],
    "Kemmangundi Hill station": [
        {"name": "Kemmannugundi Hill Resort", "website": "https://www.junglelodges.com/resort/kemmanagundi-hill-resort/", "location": [13.3189, 75.5884]},
        {"name": "Green Hills Homestay", "website": "https://www.greenhillshomestay.com/", "location": [13.3200, 75.5900]}
    ],
    "Honnemaradu": [
        {"name": "Honnukar Resort", "website": "https://honnukar.com/", "location": [13.2700, 75.1600]},
        {"name": "The Lyca Resorts", "website": "https://thelyca.com/", "location": [13.2750, 75.1650]}
    ],
    "Kavledurga fort": [
        {"name": "Bananki Homestay", "website": "https://www.banankihomestay.com/", "location": [13.8260, 75.3580]},
        {"name": "Tinton Resorts", "website": "https://tintonresorts.com/", "location": [13.8200, 75.3600]}
    ],

    # Himachal Pradesh
    "Hatu peak Narkanda": [
        {"name": "Hosteller Narkanda", "website": "https://www.thehosteller.com/hostels/the-hosteller-narkanda/", "location": [31.3142, 77.4278]},
        {"name": "Crossroads Narkanda", "website": "https://narkandacrossroads.com/", "location": [31.3100, 77.4200]}
    ],
    "Chitkul": [
        {"name": "Zostel Chitkul", "website": "https://www.zostel.com/zostel/chitkul/chitkul-chth585/", "location": [31.2510, 78.6760]},
        {"name": "Samaa Resorts", "website": "https://samaaresorts.com/", "location": [31.2500, 78.6700]}
    ],
    "Pabbar valley": [
        {"name": "Hotel River View", "website": "https://hotelriverviewrohru.com/", "location": [31.2590, 77.7250]},
        {"name": "Chanshal Camps and Resort", "website": "https://chanshalcampsandresort.in/", "location": [31.2600, 77.7200]}
    ],
    "Shangarh": [
        {"name": "Zostel Shangarh", "website": "https://www.zostel.com/zostel/sainj/shangarh-kullu-shnh319/", "location": [31.3120, 77.4500]},
        {"name": "The Seraj Village", "website": "https://theserajvillage.com/", "location": [31.3150, 77.4600]}
    ],
    "Shoja Village": [
        {"name": "Zostel Shoja", "website": "https://www.zostel.com/zostel/shoja/zostel-shoja-jibhi-shjh523", "location": [31.2650, 77.5050]},
        {"name": "Banjara Village Retreat", "website": "https://www.banjaracamps.com/camps-retreats-in-himalayan-valley-himachal/holidays-in-sojha-himachal/31/default.aspx", "location": [31.2700, 77.5100]}
    ],
    "Barot valley": [
        {"name": "Wild Highs", "website": "https://www.wildhighs.com/", "location": [31.8680, 76.6210]},
        {"name": "Taj River View", "website": "https://tajriverviewbarot.com/", "location": [31.8700, 76.6200]}
    ],

    # Rajasthan
    "Khejarla fort": [
        {"name": "Essentia Luxury Resort & Spa", "website": "https://www.essentiahotels.in/", "location": [27.5133, 73.1256]},
        {"name": "Heritage Hotel", "website": "https://jodhpurfortkhejarla.com/", "location": [27.5100, 73.1300]}
    ],
    "Thar Desert": [
        {"name": "Desert Drop Resort", "website": "https://thedesertdrop.com/", "location": [26.9250, 70.9010]},
        {"name": "Bhavya Resorts", "website": "https://bhavyaresorts.com/jaisalmer/", "location": [26.9200, 70.9000]}
    ],
    "Khimsar village": [
        {"name": "Welcome Hotel", "website": "https://www.itchotels.com/in/en/welcomhotelkhimsarfortanddunes-rajasthan?utm_source=google&utm_medium=businesslisting&utm_campaign=Welcomhotel_Fort_Dunes_Khimsar", "location": [27.1444, 73.3861]},
        {"name": "Anargh Holidays Inn", "website": "https://anarghholidaysinn.com/", "location": [27.1400, 73.3800]}
    ],
    "Sambhar lake": [
        {"name": "Camp Sambhar", "website": "https://campsambhar.com/", "location": [26.9560, 75.2950]},
        {"name": "Sambhar Heritage Resort", "website": "https://www.sambharheritage.com/", "location": [26.9600, 75.3000]}
    ],
    "Banswara": [
        {"name": "Hotel Relax Inn", "website": "https://hotelrelaxinn.net/", "location": [23.5461, 74.3176]},
        {"name": "The Imperial", "website": "https://imperialbsw.in/", "location": [23.5500, 74.3200]}
    ],
    "Kumbhalgarh Fort": [
        {"name": "Kumbhalgarh Valley Resort", "website": "https://aaretbagh.com/", "location": [25.0895, 73.4717]},
        {"name": "Kavish - The Haveli Resort", "website": "hhttps://www.kavishhotels.com/kavish-the-haveli-resort-kumbhalgarh/", "location": [25.0900, 73.4700]}
    ],

    # Meghalaya
    "Mawlynnong": [
        {"name": "Polo Orchid Resort", "website": "https://www.hotelpolotowers.com/polo-orchid-resort-in-cherrapunji/", "location": [25.3051, 91.5824]},
        {"name": "Mawlynnong Bamboo Cottage", "website": "https://mawlynnongbamboocottage.com/mawlynnong-bamboo-cottage", "location": [25.3100, 91.5800]}
    ],
    "Mawphlang Sacred Forest": [
        {"name": "Tripura Castle", "website": "https://www.tripuracastle.com/", "location": [25.3000, 91.5700]},
        {"name": "Woodstock Resort", "website": "https://www.hotelpolotowers.com/woodstock-resort/", "location": [25.3050, 91.5750]}
    ],
    "Ranikor": [
        {"name": "Hotel Heiga", "website": "https://www.hotelheigavns.com/", "location": [25.2268, 91.6238]},
        {"name": "Ranikor Retreat", "website": "https://www.ranikorretreat.com/", "location": [25.2300, 91.6200]}
    ],
    "Garden of Caves": [
        {"name": "Saimika Resort", "website": "https://saimika.in/", "location": [25.2280, 91.6350]},
        {"name": "Jiva Resort", "website": "https://jivaresortcherrapunjee.com/", "location": [25.2300, 91.6300]}
    ],
    "Dawki River": [
        {"name": "Nazimgarh Wildness Resort", "website": "https://www.nazimgarh.com/", "location": [25.2910, 92.2345]},
        {"name": "Betelnut Resort", "website": "https://betelnutresort.in/", "location": [25.2900, 92.2300]}
    ],
    "Laitkynsew": [
        {"name": "Saimika Resort", "website": "https://saimika.in/", "location": [25.2970, 91.5840]},
        {"name": "Polo Orchid Resort", "website": "https://www.hotelpolotowers.com/polo-orchid-resort-in-cherrapunji/", "location": [25.3000, 91.5800]}
    ],

    # Goa
    "Salaulim dam": [
        {"name": "Chrisander Resort", "website": "https://www.chrisanderresort.com/", "location": [15.3452, 74.0818]},
        {"name": "Treebo Rock Valley", "website": "https://www.treebo.com/hotels-in-goa/treebo-rock-valley-ponda-4115/?checkin=2024-11-08&checkout=2024-11-09&hotel_id=4115&roomconfig=2-0&utm_campaign=gmblisting&utm_medium=gmb&utm_source=Partnerships", "location": [15.3500, 74.0800]}
    ],
    "Cola beach": [
        {"name": "Blue Lagoon Resort", "website": "https://www.bluelagoonresortgoa.com/", "location": [15.0712, 74.0227]},
        {"name": "Seashell Beach Cottages", "website": "https://seashellbeachcottages.com/", "location": [15.0700, 74.0250]}
    ],
    "Cabo de Rama beach": [
        {"name": "The Cape Goa", "website": "https://thecapegoa.com/", "location": [15.0190, 74.0320]},
        {"name": "Obrigado By Craftels", "website": "https://www.obrigadobycraftels.com/", "location": [15.0200, 74.0300]}
    ],
    "Devil’s Finger Cave": [
        {"name": "Summer Ville Beach Resort", "website": "https://www.summervillebeachresort.com/", "location": [15.2890, 74.0320]},
        {"name": "Whispering Palms", "website": "https://whisperingpalms.com/goa/", "location": [15.2900, 74.0350]}
    ],
    "Sanguem village": [
        {"name": "Hotel Laxmi Empire", "website": "https://live.ipms247.com/booking/book-rooms-hotellaxmiempire", "location": [15.2667, 74.2028]},
        {"name": "The Treat Hotel", "website": "https://www.thetreathotel.in/", "location": [15.2700, 74.2000]}
    ],
    "Butterfly beach": [
        {"name": "Rosa Mystica", "website": "https://www.rosamysticagoa.com/", "location": [15.0140, 74.0745]},
        {"name": "Cuba", "website": "https://www.cubagoa.com/", "location": [15.0150, 74.0700]}
    ],

    # Gujarat
    "Girmal Waterfall": [
        {"name": "Mahal Campsite", "website": "https://mahalcampsite.com/", "location": [21.3280, 74.3512]},
        # {"name": "Waterfall View Lodge", "website": "https://www.waterfallviewlodge.com/", "location": [21.3300, 74.3500]}
    ],
    "Bechtel beach": [
        {"name": "The Fern Sattva Resort", "website": "https://www.fernhotels.com/the-fern-sattva-resort-dwarka", "location": [20.8323, 72.5400]},
        {"name": "The Grand Ladhukara", "website": "https://www.thegrandladhukara.com/", "location": [20.8300, 72.5450]}
    ],
    "KadiyaDhro": [
        {"name": "Hotel White Desert", "website": "https://www.hotelwhitedesert.com/", "location": [22.7765, 72.6458]},
        {"name": "Regenta Resort", "website": "https://www.royalorchidhotels.com/regenta-resort-bhuj/overview", "location": [22.7800, 72.6400]}
    ],
    "Wilson Hill": [
        {"name": "Shilpi Hill Resort", "website": "https://www.shilpihillresort.com/", "location": [21.4254, 72.6796]},
        {"name": "Strawberry Hills Hotels & Resort", "website": "https://www.strawberryhills.co.in/", "location": [21.4200, 72.6750]}
    ],
    "Zarwani Waterfall": [
        {"name": "Hotel Ramada Encore", "website": "https://www.ramadaencoresou.com/", "location": [22.2166, 73.0998]},
        {"name": "The Fern Hotels", "website": "https://www.fernhotels.com/", "location": [22.2200, 73.1000]}
    ],
    "Keliya dam": [
        {"name": "Hotel Vetro Inn", "website": "https://www.hotelvetroinnsurat.com/", "location": [21.7417, 73.0747]},
        {"name": "Somnath Kathiyawadi Hotels", "website": "https://vansda.in/listing/kathiyawadi-somnath-hotel-rooms/", "location": [21.7400, 73.0700]}
    ],

    # Jammu and Kashmir
    "Gurez Valley": [
        {"name": "Afsara Hotels", "website": "https://vertivix.com/afsara/", "location": [34.1567, 73.7495]},
        # {"name": "Hotel Curios", "website": "https://www.hotelcurios.in/", "location": [34.1600, 73.7500]}
    ],
    "TarsarMarsar Trek": [
        {"name": "The Light House Homestay", "website": "https://thelighthousekashmir.com/", "location": [34.1881, 74.0641]},
        {"name": "The Dewan", "website": "https://www.thedewan.in/", "location": [34.1900, 74.0600]}
    ],
    "Sanasar": [
        {"name": "Hotel Forest View", "website": "https://hotelforestview.in/", "location": [33.6352, 75.3246]},
        {"name": "Hotel Patnitop", "website": "https://www.hotelpatnitop.com/index.html", "location": [33.6300, 75.3200]}
    ],
    "Chatpal": [
        {"name": "Walnut Tree Hotels", "website": "https://hotelwalnuttree.com/", "location": [33.7280, 75.2950]},
        {"name": "Zostel", "website": "https://www.zostel.com/zostel/pahalgam/zostel-pahalgam-phlh309", "location": [33.7300, 75.2900]}
    ],
    "Bhaderwah": [
        {"name": "Hotel Apple Tree", "website": "https://hotelappletree.in/", "location": [32.9800, 75.5167]},
        {"name": "Hotel Shivalik", "website": "https://hotelshivalik.org/", "location": [32.9800, 75.5200]}
    ],
    "Pari Mahal": [
        {"name": "Dal View Resort", "website": "https://dalviewresort.com/", "location": [34.0830, 74.7974]},
        {"name": "Hotel Himalayan Resort", "website": "https://hotelhimalayanresort.com/", "location": [34.0800, 74.8000]}
    ],

    # Arunachal Pradesh
    "Anini": [
        {"name": "Mito Hotel Homestay", "website": "https://www.google.com/travel/search?q=hotels%20in%20near%20anini&g2lb=4814050%2C4874190%2C4893075%2C4965990%2C4969803%2C72277293%2C72302247%2C72317059%2C72406588%2C72414906%2C72421566%2C72471280%2C72472051%2C72473841%2C72481459%2C72485658%2C72602734%2C72614662%2C72616120%2C72619927%2C72647020%2C72648289%2C72658035%2C72671093%2C72686036%2C72729615%2C72749231%2C72760082%2C72800276&hl=en-IN&gl=in&cs=1&ssta=1&ts=CAESCgoCCAMKAggDEAAaRwopEicyJTB4MzcxNTkwOWY1ZDQwNGVjZjoweGU0OTBjMTkyOGFjNTgzMTESGhIUCgcI6A8QCxgKEgcI6A8QCxgLGAEyAhAAKgcKBToDSU5S&qs=CAEyKENob0loWkMwa3BlR3QtQ2hBUm9OTDJjdk1URm1lbUl4TVhSMk14QUI4BkIJEf2JJPXr_QEhQgkRa_NC09wAw4hCCREzc3V4xsUha1pRMk-qAUwQASoNIglob3RlbHMgaW4oADIfEAEiGzBa33CGeZKemws3RPAkinLoqqyqm_S0K4Tl9DIYEAIiFGhvdGVscyBpbiBuZWFyIGFuaW5p&ap=KigKEgn08TGcNWY5QBFAECBD82NXQBISCeXGMrxgbz5AEUAQIEObJFhAMABoAQ&ictx=111&ved=0CAAQ5JsGahcKEwjYyOSIn8-JAxUAAAAAHQAAAAAQTw", "location": [28.7895, 95.9250]},
        {"name": "Hotel Nizali", "website": "https://www.google.com/travel/search?q=hotels%20in%20near%20anini&g2lb=4814050%2C4874190%2C4893075%2C4965990%2C4969803%2C72277293%2C72302247%2C72317059%2C72406588%2C72414906%2C72421566%2C72471280%2C72472051%2C72473841%2C72481459%2C72485658%2C72602734%2C72614662%2C72616120%2C72619927%2C72647020%2C72648289%2C72658035%2C72671093%2C72686036%2C72729615%2C72749231%2C72760082%2C72800276&hl=en-IN&gl=in&cs=1&ssta=1&ts=CAESCgoCCAMKAggDEAAaRwopEicyJTB4MzcxNTkwOWY1ZDQwNGVjZjoweGU0OTBjMTkyOGFjNTgzMTESGhIUCgcI6A8QCxgKEgcI6A8QCxgLGAEyAhAAKgcKBToDSU5S&qs=CAEyKENob0lncUhFX2JUUV83WFhBUm9OTDJjdk1URnNObW81T0daa1h4QUI4BkIJEf2JJPXr_QEhQgkRa_NC09wAw4hCCREzc3V4xsUha0gAWlEyT6oBTBABKg0iCWhvdGVscyBpbigAMh8QASIbMFrfcIZ5kp6bCzdE8CSKcuiqrKqb9LQrhOX0MhgQAiIUaG90ZWxzIGluIG5lYXIgYW5pbmk&ap=KigKEgn08TGcNWY5QBFAECBD82NXQBISCeXGMrxgbz5AEUAQIEObJFhAMABoAQ&ictx=111&ved=0CAAQ5JsGahgKEwjYyOSIn8-JAxUAAAAAHQAAAAAQuAE", "location": [28.7920, 95.9275]}
    ],
    "Dambuk": [
        {"name": "Hotel Namlau", "website": "https://hotelnamlau.com/", "location": [28.4550, 95.7330]},
        {"name": "Mito Hotel Homestay", "website": "https://www.google.com/travel/search?q=hotels%20in%20near%20anini&g2lb=4814050%2C4874190%2C4893075%2C4965990%2C4969803%2C72277293%2C72302247%2C72317059%2C72406588%2C72414906%2C72421566%2C72471280%2C72472051%2C72473841%2C72481459%2C72485658%2C72602734%2C72614662%2C72616120%2C72619927%2C72647020%2C72648289%2C72658035%2C72671093%2C72686036%2C72729615%2C72749231%2C72760082%2C72800276&hl=en-IN&gl=in&cs=1&ssta=1&ts=CAESCgoCCAMKAggDEAAaRwopEicyJTB4MzcxNTkwOWY1ZDQwNGVjZjoweGU0OTBjMTkyOGFjNTgzMTESGhIUCgcI6A8QCxgKEgcI6A8QCxgLGAEyAhAAKgcKBToDSU5S&qs=CAEyKENob0loWkMwa3BlR3QtQ2hBUm9OTDJjdk1URm1lbUl4TVhSMk14QUI4BkIJEf2JJPXr_QEhQgkRa_NC09wAw4hCCREzc3V4xsUha1pRMk-qAUwQASoNIglob3RlbHMgaW4oADIfEAEiGzBa33CGeZKemws3RPAkinLoqqyqm_S0K4Tl9DIYEAIiFGhvdGVscyBpbiBuZWFyIGFuaW5p&ap=KigKEgn08TGcNWY5QBFAECBD82NXQBISCeXGMrxgbz5AEUAQIEObJFhAMABoAQ&ictx=111&ved=0CAAQ5JsGahcKEwjYyOSIn8-JAxUAAAAAHQAAAAAQTw", "location": [28.7895, 95.9250]}
    ],
    "Itanagar Wildlife Sanctuary": [
        {"name": "Cygnett Hotels", "website": "https://www.cygnetthotels.com/", "location": [27.1024, 93.6920]},
        {"name": "Waii International Hotel", "website": "https://waiiinternational.com/", "location": [27.0838, 93.6177]}
    ],
    "Mayodia Pass": [
        {"name": "Hotel Min-Ta", "website": "https://www.facebook.com/people/Hotel-Min-Ta/100094153171620/?mibextid=kFxxJD", "location": [28.1677, 95.8038]},
        {"name": "Jia Organic Resort", "website": "https://www.google.com/travel/search?q=hotels%20near%20%20mayodia%20pass&g2lb=4814050%2C4874190%2C4893075%2C4965990%2C4969803%2C72277293%2C72302247%2C72317059%2C72406588%2C72414906%2C72421566%2C72471280%2C72472051%2C72473841%2C72481459%2C72485658%2C72602734%2C72614662%2C72616120%2C72619927%2C72647020%2C72648289%2C72658035%2C72671093%2C72686036%2C72729615%2C72749231%2C72760082%2C72800276&hl=en-IN&gl=in&cs=1&ssta=1&ts=CAESCgoCCAMKAggDEAAaVQo3EjUyJTB4MzczZTM5OTYwNjRjYzc5ZDoweDUxMjkyNGUzY2M3MWZjODY6DE1heXVkaWEgUGFzcxIaEhQKBwjoDxALGAoSBwjoDxALGAsYATICEAA&qs=CAEyJ0Noa0lvYnk0OTZHeDdld01HZzB2Wnk4eE1XZGZlV1prY25SckVBRTgGQgkR_Ykk9ev9ASFCCREMKP1LE6Z96kIJEVKdJ4-5bPWcSABaUjJQqgFNEAEqCiIGaG90ZWxzKAAyHxABIhsEMtZC5KTxtGDdMcYd5ACce0gwsc0j9bo3AXYyHBACIhhob3RlbHMgbmVhciBtYXlvZGlhIHBhc3M&ap=KigKEgl8h0D-oTM5QBF6d79l1YVXQBISCVa8s-cYPz5AEXp3v2V9RlhAMABoAQ&ictx=111&ved=0CAAQ5JsGahgKEwjw5MaFos-JAxUAAAAAHQAAAAAQ1AU", "location": [28.1680, 95.8000]}
    ],
    "Sangti valley": [
        {"name": "Sangti Valley Homestay", "website": "https://sangtivalleyhomestay.com/", "location": [27.3328, 92.2411]},
        {"name": "Lanjom Homestay", "website": "https://lanjomhomestaysangti.com/", "location": [27.3325, 92.2400]}
    ],
    "Tenga valley": [
        {"name": "Monshing Homestay", "website": "https://monshinghomestay.blogspot.com/?m=1", "location": [27.1539, 92.5241]},
        {"name": "The Eaglenest Residency", "website": "https://theeaglenestresidency.com/", "location": [27.1570, 92.5255]}
    ],

    # Delhi
    "Champa gali": [
        {"name": "Hotel Happy Residency", "website": "https://www.happyresidency.in/", "location": [28.5160, 77.1951]},
        {"name": "Grace-Home", "website": "https://grace-home.in/", "location": [28.5152, 77.1956]}
    ],
    "Khirki Masjid": [
        {"name": "Zone Connect By The Park Saket", "website": "https://www.zonebythepark.com/delhi-hotels/zone-connect-by-the-park-saket-delhi", "location": [28.5293, 77.2171]},
        {"name": "Hilton Garden Inn", "website": "https://www.hilton.com/en/hotels/delskgi-hilton-garden-inn-new-delhi-saket/?SEO_id=GMB-APAC-GI-DELSKGI", "location": [28.5285, 77.2166]}
    ],
    "Mehrauli Archaeological Park": [
        {"name": "The Tivoli", "website": "https://tivolibanquets.com/tivoli-garden-resort-hotel/", "location": [28.5195, 77.1837]},
        {"name": "Stay Vista", "website": "https://www.stayvista.com/villa/indraj-manor?utm_source=google&utm_medium=gmb", "location": [28.5154, 77.1813]}
    ],
    "Rajaon ki Baoli": [
        {"name": "Hotel Star Suites", "website": "https://www.stargroupofhotels.in/", "location": [28.5200, 77.1814]},
        {"name": "Stay Vista", "website": "https://www.stayvista.com/villa/indraj-manor?utm_source=google&utm_medium=gmb", "location": [28.5180, 77.1812]}
    ],
    "Sanjay-Van": [
        {"name": "Jaypee Vasant Continental Hotel", "website": "https://www.jaypeehotels.com/hotel/jaypee-vasant-continental-new-delhi", "location":  [28.5355, 77.1657]},
        {"name": "FabHotel Prime Sage ", "website": "https://www.fabhotels.com/hotels-in-new-delhi/fabhotel-prime-sage.html?utm_source=GMB&utm_medium=organic&utm_campaign=GMB_Traffic", "location": [28.5422, 77.1716]}
    ],
    "Tughlaqabad Fort": [
        {"name": "Crowne Plaza", "website": "https://www.ihg.com/crowneplaza/hotels/us/en/new-delhi/ndeol/hoteldetail?cm_mmc=GoogleMaps-_-CP-_-IN-_-NDEOL", "location": [28.5026, 77.2587]},
        {"name": "Hotel Royal Castle Grand", "website": "https://www.royalcastlehotels.com/", "location": [28.5034, 77.2594]}
    ],

     # Madhya Pradesh
    "Bhedaghat Marble Rocks": [
        {"name": "Vrindavan Gopala Resort", "website": "https://www.vrindavangopalaresort.in/", "location": [23.1471, 79.8084]},
        {"name": "Hotel Options Lawns", "website": "https://www.hoteloptionslawns.com/", "location": [23.1475, 79.8078]}
    ],
    "Chanderi": [
        {"name": "MPT Kila Kothi", "website": "https://mpstdc.com/accommodation/Chanderi/MPT-Kila-Kothi-Chanderi", "location": [24.7149, 78.1389]},
        {"name": "Hotel Pragati", "website": "https://hotelpragati.in/", "location": [24.7135, 78.1376]}
    ],
    "Mandu": [
        {"name": "MPT Malwa Resort", "website": "https://mpstdc.com/accommodation/Mandu/MPT-Malwa-Resort-Mandu", "location": [22.3660, 75.3907]},
        {"name": "Malwa Retreat", "website": "https://malwaretreatmandu.com/", "location": [22.3605, 75.3898]}
    ],
    "Patalpani Waterfall": [
        {"name": "MPT Choral Resort", "website": "https://mpstdc.com/accommodation/Choral/MPT-Choral-Resort-Choral", "location": [22.5022, 75.8069]},
        {"name": "Simcha Island", "website": "https://www.simchaisland.com/", "location": [22.4995, 75.8056]}
    ],
    "Raneh Falls Canyon": [
        {"name": "SYNA Heritage Hotel", "website": "https://synaheritagehotel.com/", "location": [24.8586, 79.9318]},
        {"name": "The Lalit Temple View", "website": "https://www.thelalit.com/the-lalit-khajuraho/", "location": [24.8548, 79.9224]}
    ],
    "Tamia": [
        {"name": "Serendipity Lakes & Resorts", "website": "https://serendipitytamia.com/", "location": [22.3562, 78.5635]},
        {"name": "Motel Tamia", "website": "https://moteltamia.com/", "location": [22.3584, 78.5628]}
    ],

    # Maharashtra
    "Bhimashankar Forest": [
        {"name": "MTDC Bhimashankar", "website": "https://www.mtdc.co/en/", "location": [19.0718, 73.5365]},
        {"name": "The Green Jungle Resort", "website": "https://thegreenjungleresort.com/", "location": [19.0665, 73.5323]}
    ],
    "Kaas Plateau": [
        {"name": "The 20s Resort", "website": "https://www.the20sresort.in/", "location": [17.7004, 73.8116]},
        {"name": "Shivsagar Agro Tourism", "website": "https://myshivsagaragro.com/?utm_source=gmb&utm_medium=referral", "location": [17.7080, 73.8152]}
    ],
    "Korlai Fort": [
        {"name": "Coastal Paradise Resort", "website": "https://sites.google.com/view/coastalparadiseresort/home", "location": [18.5145, 72.9281]},
        {"name": "The Coastal Heritage", "website": "https://thecoastalheritage.com/", "location": [18.5113, 72.9272]}
    ],
    "Sandhan Valley": [
        {"name": "The Hosteller", "website": "https://www.thehosteller.com/hostels/the-hosteller-bhandardara/", "location": [19.5615, 73.7315]},
        {"name": "The Yash Resorts", "website": "https://www.cottonstays.com/", "location": [19.5576, 73.7299]}
    ],
    "Tamhini Ghat": [
        {"name": "Bougainvillea Resort by Vibescapes", "website": "https://www.vibescapes.in/property/bougainvillea-resort", "location": [18.4580, 73.3885]},
        {"name": "The Encore Resort", "website": "https://encoreresort.in/", "location": [18.4537, 73.3862]}
    ],
    "Velas Beach": [
        {"name": "The Tranquil Beach Resorts", "website": "https://www.tranquilbeachresort.com/", "location": [17.9852, 73.0319]},
        {"name": "Exotica Beach Cottages", "website": "https://exoticabeachcottages.in/", "location": [17.9867, 73.0304]}
    ],

    # Punjab
    "Japanese Garden": [
        {"name": "President Hotel", "website": "https://presidenthoteljal.com/", "location": [31.3260, 75.5762]},
        {"name": "Hotel Palmdale", "website": "https://hotelthepalmdale.com/", "location": [31.3275, 75.5778]}
    ],
    "Machhiwara Forest": [
        {"name": "Treebo Hotels", "website": "https://www.treebo.com/hotels-in-ludhiana/treebo-trend-highland-civil-lines-725/?checkin=2024-11-09&checkout=2024-11-10&hotel_id=725&roomconfig=1-0&utm_campaign=highland&utm_medium=gplus&utm_source=partnerships", "location": [30.9660, 76.1937]}
    ],
    "Moorish Mosque": [
        {"name": "Ramada by Wyndham Kapurthala", "website": "https://www.ramadakapurthala.com/", "location": [31.3800, 75.3805]},
        {"name": "The Grand Villa Hotel", "website": "https://www.thegrandvillahotel.com/", "location": [31.3780, 75.3822]}
    ],
    "Renuka Lake": [
        {"name": "The Clarks", "website": "https://www.theclarkshotels.com/jay-clarks-exotica-nahan/?utm_source=google_map&utm_medium=organic&utm_campaign=seo&utm_content=website_click&utm_term=jay_clarks_exotica", "location": [30.6155, 77.4738]},
        {"name": "Grand View Resort", "website": "https://www.visitgrandviewresort.com/", "location": [30.6181, 77.4750]}
    ],
    "Rock Garden": [
        {"name": "Hotel Pride", "website": "https://hotelpride.in/", "location": [30.7524, 76.8018]},
        {"name": "Treebo Trend JJ Crown", "website": "https://www.treebo.com/hotels-in-chandigarh/treebo-trend-jj-crown-baltana-825/?checkin=2024-11-09&checkout=2024-11-10&hotel_id=825&roomconfig=1-0&utm_campaign=jjcrown&utm_medium=gplus&utm_source=partnerships", "location": [30.7540, 76.8032]}
    ],
    # "Qila Mubarak": [
    #     {"name": "The Hosteller", "website": "https://www.thehosteller.com/hostels/the-hosteller-bhandardara/", "location": [22.5022, 75.8069]},
    #     {"name": "The Yash Resorts", "website": "https://www.cottonstays.com/", "location": [22.4995, 75.8056]}
    # ],
    

    # Andhra Pradesh
    "Gandikota Fort": [
        {"name": "Gandikota Pallavi Resort and Camping", "website": "https://srgandikotaresort.bookmystay.io/?utm_source=gmb&utm_campaign=website_buttton", "location": [14.8163, 78.2882]},
        {"name": "AP Tourism Haritha Resort", "website": "https://aptourismhotels.in/", "location": [14.8140, 78.2885]}
    ],
    "Kondaveedu Fort": [
        {"name": "Hotel Amarawathi", "website": "https://www.avthotel.com/", "location": [16.3714, 80.2616]},
        {"name": "Welcomhotel By ITC Hotels", "website": "https://www.itchotels.com/in/en/welcomhotelguntur?utm_source=google&utm_medium=businesslisting&utm_campaign=Welcomhotel_Guntur", "location": [16.3067, 80.4365]}
    ],
    "Lambasingi": [
        {"name": "APTDC, Lambasingi", "website": "https://tourism.ap.gov.in/home", "location": [17.9666, 82.6080]},
        {"name": "Vaishnavi Resorts", "website": "https://www.vaishnaviresorts.com/", "location": [17.9640, 82.6057]}
    ],
    "Papikondalu": [
        {"name": "Hotel Shelton Rajamahendri", "website": "https://sheltongroup.in/", "location": [17.0005, 81.7772]},
        {"name": "Manjeera Sarovar Premiere Hotel", "website": "https://www.sarovarhotels.com/manjeera-sarovar-premiere-rajahmundry/", "location": [17.0075, 81.7771]}
    ],
    "Ubbalamadugu Falls": [
        {"name": "Hotel MGM Grand", "website": "https://www.hotelmgmgrand.in/", "location": [13.6561, 79.9577]},
        {"name": "Brigade Hotels and Resorts", "website": "https://brigadehotels.in/", "location": [13.6580, 79.9590]}
    ],
    "Vanjangi the Fog Hill": [
        {"name": "Hiewa Stays", "website": "https://www.hiewastays.com/", "location": [18.2884, 82.6017]},
        {"name": "Casa Hotels", "website": "https://casahotels.in/explore/index.html", "location": [18.2900, 82.6021]}
    ],

    # Tamilnadu
    "Javadi hills": [
        {"name": "Sterling Yelagiri", "website": "https://www.sterlingholidays.com/resorts-hotels/yelagiri?utm_source=gmb&utm_medium=yelagiri", "location": [14.8163, 78.2882]},
        {"name": "MGM Whispering Winds Yelagiri", "website": "https://www.mgm-hotels.com/", "location": [14.8140, 78.2885]}
    ],
    "Kumbakonam": [
        {"name": "RAS Residency", "website": "https://rasresidency.com/", "location": [16.3714, 80.2616]},
        {"name": "Indeco Hotels Swamimalai", "website": "https://indecohotels.com/swamimalai-honeymoon-indeco-resort-swamimalai/", "location": [16.3067, 80.4365]}
    ],
    "Manapad": [
        {"name": "Hotel Royal Treat", "website": "https://www.hotelroyaltreat.com/", "location": [17.9666, 82.6080]},
        {"name": "Archana Lodge", "website": "https://www.archanalodgetiruchendur.in/", "location": [17.9640, 82.6057]}
    ],
    "Meghamalai": [
        {"name": "Hotel Tree Top", "website": "https://hoteltreetop.com/", "location": [17.0005, 81.7772]},
        {"name": "The Elephant Court", "website": "https://www.theelephantcourt.com/", "location": [17.0075, 81.7771]}
    ],
    "Pichavaram mangrove forest": [
        {"name": "The Grand Park", "website": "https://thegrandpark.com/", "location": [13.6561, 79.9577]},
        {"name": "Vandayar Hotel", "website": "https://vandayarhotel.com/", "location": [13.6580, 79.9590]}
    ],
    "Valparai": [
        {"name": "Wintel Wild", "website": "https://www.wintelwild.com/", "location": [18.2884, 82.6017]},
        {"name": "Valparai homestay", "website": "https://cottagesinvalparai.bstay.in/", "location": [18.2900, 82.6021]}
    ],

    # Assam
    "Dibru-Saikhowa National Park": [
        {"name": "Dibru-Saikhowa Eco Camp of Wave Eco Tourism", "website": "https://www.dibrusaikhowaecocamp.com/?i=1", "location": [27.7484, 95.3556]},
        {"name": "The Mirana Hotel", "website": "https://themiranahotel.com/", "location": [27.4974, 95.3409]}
    ],
    "Haflong Hill Station": [
        {"name": "The Landmark Hotels", "website": "https://thelandmarkhotels.in/", "location": [25.1682, 93.0194]},
        {"name": "Hills And Lakes Resort", "website": "https://www.hillsnlakes.com/", "location": [25.1695, 93.0135]}
    ],
    "Kakochang Waterfall": [
        {"name": "IORA The Retreat", "website": "https://iorahotels.com/", "location": [26.5821, 93.3735]},
        {"name": "Kodom Bari Retreat", "website": "https://kodombarikaziranga.com/", "location": [26.5800, 93.3783]}
    ],
    "Kareng Ghar": [
        {"name": "Platinum Lodge", "website": "https://platinumlodgeassam.com/", "location": [27.0170, 94.9114]},
        {"name": "The White Ibis", "website": "https://thewhiteibis.in/", "location": [27.0201, 94.9093]}
    ],
    "Majuli Island": [
        {"name": "Dekasang Majuli", "website": "https://www.dekasang.com/", "location": [26.9438, 94.1924]},
        {"name": "Ayang Okum River Bank Bamboo Cottage", "website": "https://ayangokumriverbankbamboocottage.durablesites.com/?pt=NjZmZmU3MzdlY2U0ZWQ3Y2EwNDk1NmY2OjE3MjgwNDc0MjkuNDM5OnByZXZpZXc=", "location": [26.9533, 94.2136]}
    ],
    "Umrangso": [
        {"name": "The Landmark Hotels", "website": "https://thelandmarkhotels.in/", "location": [25.5163, 92.7867]}
    ],

    # Bihar
     "Udaypur Wildlife Sanctuary": [
        {"name": "Hotel Asha & Banquet", "website": "https://ashahotels.in/", "location": [25.7150, 86.6566]}
    ],
    "Kaimur Hills": [
        {"name": "Hotel Mudra", "website": "https://hotelmudra.com/", "location": [24.6954, 83.6472]},
        {"name": "Panache Inn Kaimur Vihar", "website": "https://www.thepanachehotels.com/", "location": [24.7023, 83.6451]}
    ],
    "Maner Sharif": [
        {"name": "JMD Imperial", "website": "https://www.jmdimperial.com/", "location": [25.6125, 84.8769]},
        {"name": "HOTEL DIAMANT INN", "website": "https://diamantinn.com/", "location": [25.6142, 84.8733]}
    ],
    "Barabar Caves": [
        {"name": "Bihar Eco Adventure Camp Barabar", "website": "https://biharecoadventurecamp.in/", "location": [25.0058, 85.0369]},
        {"name": "Raj Mahal Resort Gaya", "website": "https://www.rajmahalresortgaya.in/", "location": [24.7954, 85.0030]}
    ],
    "Rajgir Hot Springs": [
        {"name": "Kripanidhi Retreat Rajgir", "website": "https://www.kripanidhirajgir.com/", "location": [25.0274, 85.4196]},
        {"name": "Hotel Bodhi Retreat", "website": "https://www.hotelbodhiretreatrajgir.com/", "location": [25.0301, 85.4228]}
    ],
    "Vikramshila Ruins": [
        {"name": "Hotel Rajhans International", "website": "https://hotelrajhansinternational.com/", "location": [25.3351, 87.4669]}
    ],

    # Mizoram
    "Dampa Tiger Reserve": [
        {"name": "Hmuifang Tourist Resort", "website": "https://www.mizoramtourism.com/lodge-detail/65", "location": [23.6951, 92.2964]}
    ],
    "Falkawn Village": [
        {"name": "Hotel Ransam", "website": "https://hotelransam.in/", "location": [23.7555, 92.7153]},
        {"name": "Aizawl Guest House", "website": "https://aizawlguesthouse.com/", "location": [23.7446, 92.7172]}
    ],
    "Palak Dil": [
        {"name": "Aizawl Guest House", "website": "https://aizawlguesthouse.com/", "location": [22.3951, 93.0157]},
        {"name": "Emerald Hotel", "website": "https://www.emeraldhotel.in/", "location": [22.3974, 93.0171]}
    ],
    "Phawngpui National Park": [
        {"name": "Fel Fel Hotel", "website": "https://www.google.com/travel/search?q=hotels%20in%20Phawngpui%20(Blue%20Mountain)%20National%20Park&g2lb=4814050%2C4874190%2C4893075%2C4965990%2C4969803%2C72277293%2C72302247%2C72317059%2C72406588%2C72414906%2C72421566%2C72471280%2C72472051%2C72473841%2C72481459%2C72485658%2C72602734%2C72614662%2C72616120%2C72619927%2C72647020%2C72648289%2C72658035%2C72671093%2C72686036%2C72729615%2C72749231%2C72760082%2C72800276&hl=en-IN&gl=in&cs=1&ssta=1&ts=CAESCAoCCAMKAggDGhwSGhIUCgcI6A8QCxgMEgcI6A8QCxgNGAEyAhAA&qs=CAEyE0Nnb0k0cUxBdFB5bGt1MGpFQUU4CkIJESg53p33znIYQgkRmG4IZ3u7j2BCCRGZ2O1qOB5UjFppMmeqAWQQASoKIgZob3RlbHMoADIfEAEiG3dDztVI53qwHauaopz6FvafbCLWKeM2-IgtQDIzEAIiL2hvdGVscyBpbiBwaGF3bmdwdWkgYmx1ZSBtb3VudGFpbiBuYXRpb25hbCBwYXJr&ap=KigKEglqj4SvI302QBHgXuMv7T5XQBISCWu_tdl0fjZAEeBe41kdP1dAMABoAboBCG92ZXJ2aWV3&ictx=111&ved=0CAAQ5JsGahcKEwjIl6Wht9GJAxUAAAAAHQAAAAAQQg", "location": [22.6134, 93.0196]},
        # {"name": "Raj Mahal Resort Gaya", "website": "https://www.rajmahalresortgaya.in/", "location": [24.7954, 85.0030]}
    ],
    "Sakawrhmuituai Tiang": [
        {"name": "Hotel Ransam", "website": "https://hotelransam.in/", "location": [23.7272, 92.7175]},
        {"name": "Hotel Regency", "website": "https://regencyaizawl.com/", "location": [23.7365, 92.7173]}
    ],
    "Vangchhia": [
        {"name": "Hotel Regency", "website": "https://regencyaizawl.com/", "location": [23.7742, 93.2194]}
    ],

    # Nagaland
     "Dzükou Valley": [
        {"name": "The Himbs Hotel", "website": "https://thehimbshotel.com/", "location": [25.6438, 94.1226]}
    ],
    "Dzuleke": [
        {"name": "Zone Niathu by The Park", "website": "https://www.zonebythepark.com/dimapur-hotels/zone-niathu-by-the-park-dimapur", "location": [25.7265, 93.8749]},
        {"name": "Cedar Hotel", "website": "https://hotelcedar.in/", "location": [25.7462, 93.8725]}
    ],
    "Longkhum": [
        {"name": "Whispering Winds", "website": "https://pro.unogreencard.com/XH8IUB", "location": [26.3447, 94.5302]}
    ],
    "Mokokchung": [
        {"name": "Whispering Winds", "website": "https://pro.unogreencard.com/XH8IUB", "location": [26.3213, 94.5285]},
        {"name": "JN Hotel", "website": "https://jnhotelkhma.wixsite.com/jnhotel", "location": [26.3241, 94.5257]}
    ],
    "Mon": [
        {"name": "Hotel Tragopan", "website": "https://www.hoteltragopan.in/?utm_source=google&utm_medium=wix_google_business_profile&utm_campaign=11110719042257807347", "location": [26.7407, 94.2293]},
        {"name": "Shulem Boutique Hotel", "website": "https://shulemboutiquehotel.com/", "location": [26.7421, 94.2330]}
    ],
    "Shilloi Lake": [
        {"name": "Oak House", "website": "https://oakhouse.in/", "location": [25.4762, 94.3179]},
        {"name": "Zone Niathu by The Park", "website": "https://www.zonebythepark.com/dimapur-hotels/zone-niathu-by-the-park-dimapur", "location": [25.6862, 93.7752]}
    ],

    # Odisha
    "Baisipalli Wildlife Sanctuary": [
        {"name": "Satkosia Hill View Resort", "website": "https://www.satkosiahillviewresort.com/", "location": [20.3875, 846743]}
    ],
    "Bargarh": [
        {"name": "Hotel Ganapathi", "website": "https://www.hotelganapathi.com/", "location": [21.3336, 83.6195]},
        {"name": "Hotel Arman", "website": "https://hotelarmanbarpali.com/", "location": [21.3328, 83.6106]}
    ],
    "Daringbadi": [
        {"name": "Deers Eco Home Resort", "website": "https://www.ecohome.org.in/", "location": [19.9124, 84.1449]},
        {"name": "Hotel Utopia", "website": "https://hotelutopia.in/", "location": [19.9124, 84.1449]}
    ],
    "Debrigarh Wildlife Sanctuary": [
        {"name": "Hotel Silver Moon", "website": "https://www.hotelsilvermoon.com/", "location": [21.5022, 83.7789]},
        {"name": "Regenta Inn Sambalpur By Royal Orchid Hotels", "website": "https://www.royalorchidhotels.com/", "location":[214669, 83.9727]}
    ],
    "Gopalpur-on-Sea": [
        {"name": "Gopalpur Palm Resort", "website": "https://www.swostihotels.com/gopalpur-palm-resort/", "location": [19.2513, 84.9107]},
        {"name": "Saanaira Resorts & Spa", "website": "https://saanairaresorts.com/", "location": [19.2576, 84.9072]}
    ],
    "Khandadhar Falls": [
        {"name": "Laasa Rooms", "website": "https://lasarooms.com/room.php", "location": [21.8485, 85.1660]}
    ],

    # Kerala 
    "Ramkkalmedu": [
        {"name": "Kgees- Hill Town Hotel", "website": "https://kgeeshilltown.in/", "location": [25.6438, 94.1226]},
        {"name": "Peakaavu Cottages", "website": "https://cottages.peakaavu.com/", "location": [25.6438, 94.1226]}
    ],
    "Bekal Fort": [
        {"name": "Gateway Bekal", "website": "https://www.gateway-hotels.com/en-in/hotels/gateway-bekal?utm_medium=Local&utm_source=Google&utm_campaign=Gateway-Bekal", "location": [25.7265, 93.8749]},
        {"name": "Sree Gokulam Nalanda Resorts", "website": "https://www.gokulamhotels.com/gokulam-park-nalanda-resort-nileshwaram-cottage.html", "location": [25.7462, 93.8725]}
    ],
    "Jatayu's earth center": [
        {"name": "Hotel Raj Regency", "website": "https://hotelrajregency.com/", "location": [26.3447, 94.5302]},
        {"name": "RAK Palace Inn", "website": "https://rakpalaceinn.com/", "location": [26.3447, 94.5302]}
    ],
    "Kappad Beach": [
        {"name": "Vasco Da Gama Beach Resort and Spa", "website": "https://www.vascodagamabeachresort.com/", "location": [26.3213, 94.5285]},
        {"name": "Renai Kappad Beach Resort", "website": "https://www.renaicochin.in/kappad-beach-resort/", "location": [26.3241, 94.5257]}
    ],
    "Anchuthengu and Anjengo Fort": [
        {"name": "Lake Palace Hotel", "website": "https://www.lakepalace.in/en.html", "location": [26.7407, 94.2293]},
        {"name": "Hotel Savithri", "website": "https://hotelsavithri.com/index.php", "location": [26.7421, 94.2330]}
    ],
    "Edappally Church Complex ": [
        {"name": "Elixir Cliff Beach Resort and Spa", "website": "https://www.elixircliff.com/", "location": [25.4762, 94.3179]},
        {"name": "Hotel Vakkom Palazzo", "website": "https://vakkompalazzo.com/", "location": [25.6862, 93.7752]}
    ],

    # West Bengal
    "Chatakpur": [
        {"name": "The Local Tribe", "website": "https://thelocaltribe.in/", "location": [27.0333, 88.2802]},
        {"name": "Topgyel Homestay", "website": "https://topgyelhomestay.in/", "location": [27.0333, 88.2802]}
    ],
    "Gorubathan": [
        {"name": "Turibari Leisure Point", "website": "https://turibariecoresort.com/", "location": [27.0544, 88.7459]},
        {"name": "Sinclairs Retreat Dooars", "website": "https://www.sinclairshotels.com/dooars", "location": [26.7118, 88.7742]}
    ],
    "Lepchajagat": [
        {"name": "Mount Villa Boutique Hotel & Restaurant", "website": "https://www.mountvilladarj.com/", "location": [26.9946, 88.2463]},
        {"name": "Sterling Darjeeling", "website": "https://www.sterlingholidays.com/resorts-hotels/darjeeling", "location": [27.0587, 88.2653]}
    ],
    "Rishikhola": [
        {"name": "KOLAKHAM - THE HIMALAYAN RETREATs", "website": "https://thehimalayanretreat.com/", "location": [27.1729, 88.6586]},
        {"name": "Preisha Hotel & Resorts", "website": "https://preishahotels.com/", "location": [27.1689, 88.6601]}
    ],
    "Takdah": [
        {"name": "Tinchuley Ratna Vajra Vatika Resort", "website": "https://ratnavajravatika.com/", "location": [27.0244, 88.3683]},
        {"name": "Takdah Heritage Colonial Bungalow No. 12", "website": "https://www.takdahhotels.com/sonepur-maharaja-bungalow-takdah/", "location": [27.0305, 88.3716]}
    ],
    "Tinchuley": [
        {"name": "Tinchuley Ratna Vajra Vatika Resort", "website": "https://ratnavajravatika.com/", "location": [27.0244, 88.3683]},
        {"name": "Takdah Heritage Colonial Bungalow No. 12", "website": "https://www.takdahhotels.com/sonepur-maharaja-bungalow-takdah/", "location": [27.0305, 88.3716]}
    ]
}   

transportation_data = {
    # Uttarakhand
    "Uttarakhand": [
        {
            "city": "Dehradun",
            "services": [
                {"type": "All", "operator": "Yadav Packers and Movers", "website": "https://yadavpackersandmovers.com/", "contact": "+91-1234567890", "location": [30.3165, 78.0322]},
                {"type": "Taxi", "operator": "UK Hills Travels", "website": "https://ukhillstravels.com/", "contact": "+91-0987654321", "location": [30.3170, 78.0320]},
                {"type": "Rental Car", "operator": "RJ Travels", "website": "https://therjtravel.com/", "contact": "+91-1122334455", "location": [30.3168, 78.0316]}
            ]
        },
        {
            "city": "Nainital",
            "services": [
                {"type": "Taxi", "operator": "Nainital Taxis", "website": "https://nainitaltaxi.in/", "contact": "+91-2233445566", "location": [29.3919, 79.4548]},
                {"type": "Bus", "operator": "Fasttrack Travels", "website": "https://www.fasttrackbus.in/", "contact": "+91-6677889900", "location": [29.3920, 79.4550]},
                {"type": "Rental Car", "operator": "Travel Nainital", "website": "https://www.travelnainital.com/car-rental", "contact": "+91-3344556677", "location": [29.3915, 79.4535]}
            ]
        }
    ],

    # Karnataka
    "Karnataka": [
        {
            "city": "Bangalore",
            "services": [
                {"type": "Taxi", "operator": "Bangalore Cabs", "website": "https://bangalorecabservices.com/", "contact": "+91-9988776655", "location": [12.9716, 77.5946]},
                {"type": "Bus", "operator": "Bangalore Metropolitan Transport Corporation", "website": "https://mybmtc.karnataka.gov.in/english", "contact": "+91-7766554433", "location": [12.9718, 77.5945]},
                {"type": "Rental Car", "operator": "Nature's Drive", "website": "https://www.indusgo.in/", "contact": "+91-2233445566", "location": [12.9700, 77.5900]}
            ]
        },
        {
            "city": "Mysore",
            "services": [
                {"type": "Taxi", "operator": "Mysore Cabs", "website": "https://mysoregadiwala.com/", "contact": "+91-4455667788", "location": [12.2958, 76.6394]},
                {"type": "Bus", "operator": "Mysore Transport", "website": "https://mybmtc.karnataka.gov.in/english", "contact": "+91-9988776655", "location": [12.2960, 76.6400]},
                {"type": "Rental Car", "operator": "Heritage Rentals", "website": "https://www.zoomcar.com/in/mysore", "contact": "+91-5566778899", "location": [12.2965, 76.6380]}
            ]
        }
    ],

    # Himachal Pradesh
    "Himachal Pradesh": [
        {
            "city": "Shimla",
            "services": [
                {"type": "Taxi", "operator": "Shimla Taxi Service", "website": "https://www.shimlataxi.in/", "contact": "+91-1234567891", "location": [31.1048, 77.1734]},
                {"type": "Bus", "operator": "Himachal Transport", "website": "https://www.hrtchp.com/hrtc_info/", "contact": "+91-2345678901", "location": [31.1050, 77.1750]},
                {"type": "Rental Car", "operator": "Self Drive Car Rental", "website": "https://www.selfdriveshimla.com/", "contact": "+91-3456789012", "location": [31.1030, 77.1720]}
            ]
        },
        {
            "city": "Manali",
            "services": [
                {"type": "Taxi", "operator": "Manali Cabs", "website": "https://manalicabs.in/", "contact": "+91-4567890123", "location": [32.2396, 77.1887]},
                {"type": "Bus", "operator": "Himachal Transport", "website": "https://www.hrtchp.com/hrtc_info/", "contact": "+91-5678901234", "location": [32.2400, 77.1900]},
                {"type": "Rental Car", "operator": "Car rental service", "website": "https://6690202caf16c.site123.me/", "contact": "+91-6789012345", "location": [32.2380, 77.1870]}
            ]
        }
    ],

    # Goa
    "Goa": [
        {
            "city": "Panaji",
            "services": [
                {"type": "Taxi", "operator": "Goa TexiNCabs", "website": "https://www.goataxincabs.com/", "contact": "+91-9012345678", "location": [15.4909, 73.8288]},
                {"type": "Bus", "operator": "Goa Bus", "website": "https://goadarshanbus.com/", "contact": "+91-0123456789", "location": [15.4910, 73.8290]},
                {"type": "Rental Car", "operator": "Goa Rentals", "website": "https://gogoacarrentals.com/", "contact": "+91-1234567890", "location": [15.4920, 73.8300]}
            ]
        },
        {
            "city": "Margao",
            "services": [
                {"type": "Taxi", "operator": "Margao Taxis", "website": "https://www.goataxincabs.com/", "contact": "+91-2345678901", "location": [15.2934, 74.0218]},
                {"type": "Bus", "operator": "Goa Bus ", "website": "https://goadarshanbus.com/", "contact": "+91-3456789012", "location": [15.2930, 74.0220]},
                {"type": "Rental Car", "operator": "Coastal Rentals", "website": "https://gogoacarrentals.com/", "contact": "+91-4567890123", "location": [15.2940, 74.0230]}
            ]
        }
    ],

    # Gujarat
    "Gujarat": [
        {
            "city": "Ahmedabad",
            "services": [
                {"type": "Taxi", "operator": "Buzzway:Luxury Cab Hire", "website": "https://buzzway.in/", "contact": "+91-9876543210", "location": [23.0225, 72.5714]},
                {"type": "Bus", "operator": "Gujarat State Road Transport Corporation", "website": "https://www.gsrtc.in/", "contact": "+91-9999999999", "location": [23.0226, 72.5715]},
                {"type": "Rental Car", "operator": "ACR car rental", "website": "https://carrentalinahmedabad.com/", "contact": "+91-8888888888", "location": [23.0230, 72.5700]}
            ]
        },
        {
            "city": "Surat",
            "services": [
                {"type": "Taxi", "operator": "Surat Taxi Hire", "website": "https://www.surattaxihire.com/", "contact": "+91-9123456789", "location": [21.1702, 72.8311]},
                {"type": "Bus", "operator": "Surat Central GSRTC Bus Station", "website": "http://www.gsrtc.in/", "contact": "+91-8778888888", "location": [21.1703, 72.8310]},
                {"type": "Rental Car", "operator": "Dhaval Travels(Car Rent Services)", "website": "https://mybusinesscard.co.in/dhaval-travels-car-rental-services/", "contact": "+91-9666666666", "location": [21.1705, 72.8305]}
            ]
        },
        {
            "city": "Vadodara",
            "services": [
                {"type": "Taxi", "operator": "Baroda Taxi Service", "website": "https://www.smeettravels.com/?utm_source=google&utm_medium=wix_google_business_profile&utm_campaign=1530634545899497664", "contact": "+91-8234567890", "location": [22.3078, 73.1812]},
                {"type": "Bus", "operator": "Vadodara Transport", "website": "http://www.gsrtc.in/", "contact": "+91-8444444444", "location": [22.3080, 73.1800]},
                {"type": "Rental Car", "operator": "Vadodara Car Rental", "website": "http://www.vadodaracarrental.com/", "contact": "+91-9555555555", "location": [22.3082, 73.1795]}
            ]
        },
        {
            "city": "Rajkot",
            "services": [
                {"type": "Taxi", "operator": "Rajkot Taxi", "website": "http://rajkottaxi.in/", "contact": "+91-9324567890", "location": [22.3039, 70.8022]},
                {"type": "Bus", "operator": "Rajkot Transport", "website": "http://www.gsrtc.in/", "contact": "+91-8234567890", "location": [22.3040, 70.8030]},
                {"type": "Rental Car", "operator": "PRIYANSH TOURS AND TRAVELS CAR RENTAL", "website": "http://www.priyanshtaxi.com/", "contact": "+91-9444444444", "location": [22.3045, 70.8000]}
            ]
        },
        {
            "city": "Gandhinagar",
            "services": [
                {"type": "Taxi", "operator": "Aayush cab service", "website": "http://aayush27787.com/", "contact": "+91-9412345678", "location": [23.2156, 72.6369]},
                {"type": "Bus", "operator": "Gandhinagar Transport", "website": "http://www.gsrtc.in/", "contact": "+91-8222222222", "location": [23.2160, 72.6370]},
                {"type": "Rental Car", "operator": "Rajkamal car rental", "website": "http://directory.mynahub.com/profile/9638835111", "contact": "+91-9333333333", "location": [23.2165, 72.6355]}
            ]
        }
    ],

    # Maharashtra
    "Maharashtra": [
        {
            "city": "Mumbai",
            "services": [
                {"type": "Taxi", "operator": "Comfort Cars Cab & Taxi service", "website": "https://www.comfortcarss.com/mumbai", "contact": "+91-9123456789", "location": [19.0760, 72.8777]},
                {"type": "Bus", "operator": "Maharashtra State Road Transport Corporation", "website": "https://msrtc.maharashtra.gov.in/GeneralPages/Home.aspx", "contact": "+91-9820466099", "location": [19.0765, 72.8770]},
                {"type": "Rental Car", "operator": "MyChoize - Self Drive Car Rentals", "website": "https://www.google.com/aclk?sa=l&ai=DChcSEwjMmcGN4NKJAxUYGHsHHWsILRAYABAGGgJ0bQ&co=1&ase=2&gclid=Cj4KCQiA0MG5BhD1ARItAEcZtwRPyKBgUQBwCRRtD904eZmW5vQ2zbcXnTytU1sDYxFcMdWVOkz2XR--GgLwFhAC8P8HAQ&label=free_ps_website&sig=AOD64_2zX-NcJfvwGMQ3slmCXO7fYCPO_w&bp=1&nis=4&adurl", "contact": "+91-9988776655", "location": [19.0750, 72.8780]}
            ]
        },
        {
            "city": "Pune",
            "services": [
                {"type": "Taxi", "operator": "Taxi Service Pune Punam Cab", "website": "http://punamcabpune.in/", "contact": "+91-9234567890", "location": [18.5204, 73.8567]},
                {"type": "Bus", "operator": "Maharashtra State Road Transport Corporation", "website": "https://msrtc.maharashtra.gov.in/GeneralPages/Home.aspx", "contact": "+91-9000000000", "location": [18.5210, 73.8570]},
                {"type": "Rental Car", "operator": "Siddhi Car Rental", "website": "https://www.instagram.com/rentalcarpune/", "contact": "+91-9777777777", "location": [18.5220, 73.8550]}
            ]
        },
        {
            "city": "Nagpur",
            "services": [
                {"type": "Taxi", "operator": "Divyani Taxi Service - Nagpur", "website": "https://divyanitaxiservice.com/", "contact": "+91-9123456789", "location": [21.1458, 79.0882]},
                {"type": "Bus", "operator": "Maharashtra State Road Transport Corporation", "website": "https://msrtc.maharashtra.gov.in/GeneralPages/Home.aspx", "contact": "+91-9222222222", "location": [21.1460, 79.0890]},
                {"type": "Rental Car", "operator": "SS Car Rental Service", "website": "https://sscarrentalnagpur.com/", "contact": "+91-9444444444", "location": [21.1465, 79.0900]}
            ]
        },
        {
            "city": "Aurangabad",
            "services": [
                {"type": "Taxi", "operator": "JB Cabs", "website": "http://www.aurangabadtaxiservice.in/", "contact": "+91-9324567890", "location": [19.8762, 75.3433]},
                {"type": "Bus", "operator": "Maharashtra State Road Transport Corporation", "website": "https://msrtc.maharashtra.gov.in/GeneralPages/Home.aspx", "contact": "+91-9888888888", "location": [19.8770, 75.3400]},
                {"type": "Rental Car", "operator": "JB Car Rental", "website": "http://www.aurangabadtaxiservice.in/", "contact": "+91-9333333333", "location": [19.8750, 75.3450]}
            ]
        }
    ],

    # Tamil Nadu
    "Tamil Nadu": [
        {
            "city": "Chennai",
            "services": [
                {"type": "Taxi", "operator": "CHENNAI TAXI SERVICE", "website": "https://chennaitaxiservice.com/", "contact": "+91-9444444444", "location": [13.0827, 80.2707]},
                {"type": "Bus", "operator": "MTC Chennai", "website": "https://mtcbus.tn.gov.in/", "contact": "+91-9087888899", "location": [13.0830, 80.2710]},
                {"type": "Rental Car", "operator": "IndusGO Rent a Car Velachery", "website": "https://www.indusgo.in/tamilnadu/chennai", "contact": "+91-9123456789", "location": [13.0850, 80.2700]}
            ]
        },
        {
            "city": "Coimbatore",
            "services": [
                {"type": "Taxi", "operator": "Coimbatore Taxi services", "website": "http://www.taxicoimbatore.com/", "contact": "+91-9655555555", "location": [11.0168, 76.9558]},
                {"type": "Bus", "operator": "MTC Chennai", "website": "https://mtcbus.tn.gov.in/", "contact": "+91-9600000000", "location": [11.0170, 76.9500]},
                {"type": "Rental Car", "operator": "IndusGO Rent a Car Velachery", "website": "https://www.indusgo.in/tamilnadu/chennai", "contact": "+91-9866666666", "location": [11.0180, 76.9520]}
            ]
        },
        {
            "city": "Madurai",
            "services": [
                {"type": "Taxi", "operator": "Madurai Call Taxi", "website": "https://www.maduraicalltaxi.com/", "contact": "+91-9755555555", "location": [9.9252, 78.1198]},
                {"type": "Bus", "operator": "MTC Chennai", "website": "https://mtcbus.tn.gov.in/", "contact": "+91-9777777777", "location": [9.9260, 78.1200]},
                {"type": "Rental Car", "operator": "IndusGO Rent a Car Velachery", "website": "https://www.indusgo.in/tamilnadu/chennai", "contact": "+91-9799999999", "location": [9.9250, 78.1210]}
            ]
        },
        {
            "city": "Tiruchirappalli",
            "services": [
                {"type": "Taxi", "operator": "Trichy Call Taxi & Travels", "website": "http://www.trichycalltaxi.com/", "contact": "+91-9177777777", "location": [10.7905, 78.7047]},
                {"type": "Bus", "operator": "MTC Chennai", "website": "https://mtcbus.tn.gov.in/", "contact": "+91-9123456789", "location": [10.7920, 78.7050]},
                {"type": "Rental Car", "operator": "IndusGO Rent a Car Velachery", "website": "https://www.indusgo.in/tamilnadu/chennai", "contact": "+91-9366666666", "location": [10.7900, 78.7060]}
            ]
        }
    ],

    # West Bengal
    "West Bengal": [
        {
            "city": "Kolkata",
            "services": [
                {"type": "Taxi", "operator": "Bharat Taxi", "website": "http://www.bharattaxi.com/kolkata", "contact": "+91-9000000000", "location": [22.5726, 88.3639]},
                {"type": "Bus", "operator": "WBTC", "website": "https://wbtconline.in/home", "contact": "+91-9999999999", "location": [22.5730, 88.3640]},
                {"type": "Rental Car", "operator": "CAR RENTAL KOLKATA", "website": "https://www.carrentalkolkata.com/", "contact": "+91-9234567890", "location": [22.5750, 88.3650]}
            ]
        },
        {
            "city": "Howrah",
            "services": [
                {"type": "Taxi", "operator": "Yatra Cab Service", "website": "https://www.yatra.com/", "contact": "+91-9822334455", "location": [22.5958, 88.2636]},
                {"type": "Bus", "operator": "WBTC", "website": "https://wbtconline.in/home", "contact": "+91-9811111111", "location": [22.5970, 88.2650]},
                {"type": "Rental Car", "operator": "Guddu travels car rental", "website": "https://www.facebook.com/profile.php?id=100070697990304&mibextid=ZbWKwL", "contact": "+91-9888776655", "location": [22.5960, 88.2640]}
            ]
        },
        {
            "city": "Durgapur",
            "services": [
                {"type": "Taxi", "operator": "Durgapur cab service", "website": "http://dcscabs.com/", "contact": "+91-9155555555", "location": [23.5070, 87.2910]},
                {"type": "Bus", "operator": "WBTC", "website": "https://wbtconline.in/home", "contact": "+91-9234567890", "location": [23.5100, 87.2900]},
                {"type": "Rental Car", "operator": "Durgapur cab service", "website": "http://dcscabs.com/", "contact": "+91-9444444444", "location": [23.5120, 87.2920]}
            ]
        },
        {
            "city": "Asansol",
            "services": [
                {"type": "Taxi", "operator": "Ghumaakar Cabs", "website": "https://www.ghumaakar.com/", "contact": "+91-9777777777", "location": [23.6824, 86.9988]},
                {"type": "Bus", "operator": "WBTC", "website": "https://wbtconline.in/home", "contact": "+91-9888888888", "location": [23.6830, 86.9990]},
                {"type": "Rental Car", "operator": "Asansol Car Rental", "website": "https://asansolcarrentalservive.in/", "contact": "+91-9393939393", "location": [23.6840, 86.9950]}
            ]
        }
    ],

    # Kerala
    "Kerala": [
        {
            "city": "Thiruvananthapuram",
            "services": [
                {"type": "Taxi", "operator": "Thiruvananthapuram Cabs", "website": "https://www.thiruvananthapuramcabs.com/", "contact": "+91-9444444444", "location": [8.5241, 76.9366]},
                {"type": "Bus", "operator": "KSRTC", "website": "https://www.ksrtc.in/", "contact": "+91-9999999999", "location": [8.5250, 76.9370]},
                {"type": "Rental Car", "operator": "Apple Cars - Self Drive", "website": "https://applecarrentals.com/", "contact": "+91-9123456789", "location": [8.5260, 76.9380]}
            ]
        },
        {
            "city": "Kochi",
            "services": [
                {"type": "Taxi", "operator": "Cochin Royara Cabs", "website": "https://royaracabs.com/", "contact": "+91-9888888888", "location": [9.9312, 76.2673]},
                {"type": "Bus", "operator": "Kochi Transport", "website": "https://www.kochitransport.com/", "contact": "+91-9234567890", "location": [9.9320, 76.2680]},
                {"type": "Rental Car", "operator": "TRANZ CARS", "website": "https://tranzcars.com/", "contact": "+91-9444444444", "location": [9.9330, 76.2690]}
            ]
        },
        {
            "city": "Kozhikode",
            "services": [
                {"type": "Taxi", "operator": "CALICUT TAXIS", "website": "http://www.calicuttaxi.in/", "contact": "+91-9777777777", "location": [11.2588, 75.7804]},
                {"type": "Bus", "operator": "Kozhikode Transport", "website": "https://www.kozhikodetransport.com/", "contact": "+91-9888888888", "location": [11.2590, 75.7800]},
                {"type": "Rental Car", "operator": "Kozhikode Rentals", "website": "https://www.kozhikoderentals.com/", "contact": "+91-9393939393", "location": [11.2600, 75.7810]}
            ]
        },
        {
            "city": "Kollam",
            "services": [
                {"type": "Taxi", "operator": "Kollam Cabs", "website": "https://kollamtaxiservices.com/", "contact": "+91-9222334455", "location": [8.8910, 76.6140]},
                {"type": "Bus", "operator": "Kollam Transport", "website": "https://www.kollamtransport.com/", "contact": "+91-9333333333", "location": [8.8920, 76.6150]},
                {"type": "Rental Car", "operator": "Kollam Rentals", "website": "https://www.kollamentals.com/", "contact": "+91-9366666666", "location": [8.8900, 76.6160]}
            ]
        }
    ]
}



# Place data by state
places_data = {
    "Uttarakhand": ["Dhanaulti Hill station", "Lansdowne", "Chaukori hill station", "Nelong valley", "Harsil valley", "Chamoli"],
    "Karnataka": ["Devaramane Hill", "Kalasa town", "Sasihitlu beach", "Kemmangundi Hill station", "Honnemaradu", "Kavledurga fort"],
    "Himachal Pradesh": ["Hatu peak Narkanda", "Chitkul", "Pabbar valley", "Shangarh", "Shoja Village", "Barot valley"],
    "Rajasthan": ["Khejarla fort", "Thar Desert", "Khimsar village", "Sambhar lake", "Banswara", "Kumbhalgarh Fort"],
    "Meghalaya": ["Mawlynnong", "Mawphlang Sacred Forest", "Ranikor", "Garden of Caves", "Dawki River", "Laitkynsew"],
    "Goa": ["Salaulim dam", "Cola beach", "Cabo de Rama beach", "Devil’s Finger Cave", "Sanguem village", "Butterfly beach"],
    "Gujarat": ["Girmal Waterfall", "Bechtel beach", "KadiyaDhro", "Wilson Hill", "Zarwani Waterfall", "Keliya dam"],
    "Jammu and Kashmir": ["Gurez Valley", "TarsarMarsar Trek", "Sanasar", "Chatpal", "Bhaderwah", "Pari Mahal"],
    "West Bengal" : ["Tinchuley", "Takdah", "Rishikhola", "Lepchajagat", "Gorubathan", "Chatakpur"],
    "Kerala" : ["Anchuthengu and Anjengo", "Ramakkalmedu", "Edappally Church Complex", "Kappad Beach", "Jatayu Earth's Center", "Bekal Fort"]
}

# Initialize the geolocator
geolocator = Nominatim(user_agent="route_mapper")

# Function to get the latitude and longitude of a state
def get_location(state_name):
    location = geolocator.geocode(state_name + ", India")
    if location:
        return (location.latitude, location.longitude)
    else:
        raise ValueError(f"Could not find the state: {state_name}")

# Create a graph
def create_graph():
    G = nx.Graph()

    states = [
        "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
        "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand",
        "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur",
        "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab",
        "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura",
        "Uttar Pradesh", "Uttarakhand", "West Bengal", "Jammu and Kashmir"
    ]

    # Add nodes to the graph for each state
    for state in states:
        G.add_node(state, pos=get_location(state))

    # Add edges to form a connected graph
    edges = [
        ("Andhra Pradesh", "Tamil Nadu"), ("Andhra Pradesh", "Karnataka"), ("Andhra Pradesh", "Odisha"),
        ("Arunachal Pradesh", "Assam"), ("Assam", "West Bengal"), ("Assam", "Meghalaya"),
        ("Bihar", "West Bengal"), ("Bihar", "Jharkhand"), ("Bihar", "Uttar Pradesh"),
        ("Chhattisgarh", "Madhya Pradesh"), ("Chhattisgarh", "Odisha"), ("Chhattisgarh", "Jharkhand"),
        ("Goa", "Maharashtra"), ("Gujarat", "Rajasthan"), ("Gujarat", "Maharashtra"),
        ("Haryana", "Punjab"), ("Haryana", "Uttar Pradesh"), ("Himachal Pradesh", "Punjab"),
        ("Jharkhand", "West Bengal"), ("Karnataka", "Maharashtra"), ("Karnataka", "Goa"),
        ("Karnataka", "Kerala"), ("Kerala", "Tamil Nadu"), ("Madhya Pradesh", "Rajasthan"),
        ("Madhya Pradesh", "Maharashtra"), ("Manipur", "Nagaland"), ("Manipur", "Mizoram"),
        ("Meghalaya", "Tripura"), ("Mizoram", "Tripura"), ("Nagaland", "Arunachal Pradesh"),
        ("Odisha", "West Bengal"), ("Punjab", "Haryana"), ("Punjab", "Rajasthan"),
        ("Rajasthan", "Uttar Pradesh"), ("Sikkim", "West Bengal"), ("Tamil Nadu", "Telangana"),
        ("Telangana", "Andhra Pradesh"), ("Telangana", "Maharashtra"), ("Tripura", "Assam"),
        ("Uttar Pradesh", "Bihar"), ("Uttar Pradesh", "Madhya Pradesh"), ("Uttarakhand", "Himachal Pradesh"),
        ("Uttarakhand", "Uttar Pradesh"), ("West Bengal", "Jharkhand"), ("Jammu and Kashmir", "Punjab")
    ]

    # Add edges to the graph
    G.add_edges_from(edges)
    return G

# Create all possible routes including the intermediate states
def create_routes(G, start, end, intermediates):
    if not intermediates:
        return list(nx.all_simple_paths(G, source=start, target=end))

    all_routes = []
    for intermediate in intermediates:
        # Find all routes from start to the intermediate state
        to_intermediate = list(nx.all_simple_paths(G, source=start, target=intermediate))
        # Find all routes from the intermediate state to the end state
        from_intermediate = list(nx.all_simple_paths(G, source=intermediate, target=end))
        # Combine these routes
        for route1 in to_intermediate:
            for route2 in from_intermediate:
                if route1[-1] == route2[0]:
                    combined_route = route1 + route2[1:]
                    if combined_route not in all_routes:
                        all_routes.append(combined_route)
    return all_routes

# Generate map with routes
def plot_routes_on_map(routes, G):
    m = folium.Map(location=[20.5937, 78.9629], zoom_start=5)
    pos = nx.get_node_attributes(G, 'pos')

    for idx, route in enumerate(routes):
        route_coords = [pos[state] for state in route]
        color = ["blue", "green", "red", "purple", "orange"][idx % 5]
        folium.PolyLine(locations=route_coords, color=color, weight=2.5, opacity=1).add_to(m)
        folium.Marker(location=route_coords[0], popup=f"Start: {route[0]}").add_to(m)
        folium.Marker(location=route_coords[-1], popup=f"End: {route[-1]}").add_to(m)

    for state, coords in pos.items():
        folium.Marker(location=coords, popup=state).add_to(m)

    static_dir = os.path.join(os.path.dirname(__file__), 'static')
    if not os.path.exists(static_dir):
        os.makedirs(static_dir)

    map_file = os.path.join(static_dir, 'top_5_routes.html')
    m.save(map_file)
    return 'top_5_routes.html'