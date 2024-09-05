import networkx as nx
import folium
from geopy.geocoders import Nominatim
import os

hotel_data = {
    # Uttarakhand
    "Dhanaulti Hill station": [
        {"name": "Hotel Apple Orchard", "website": "https://www.appleorcharddhanaulti.com/", "location": [30.4256, 78.1076]},
        {"name": "Hotel Drive Inn", "website": "https://www.hoteldriveinndhanaulti.com/", "location": [30.4319, 78.1097]},
        {"name": "Hotel Crown Plaza", "website": "https://www.crownplazadhanaulti.com/", "location": [30.4333, 78.1054]}
    ],
    "Lansdowne": [
        {"name": "Blue Pine Resort", "website": "https://www.bluepineresort.com/", "location": [29.8378, 78.6853]},
        {"name": "Samskara Resort", "website": "https://www.samskararesort.com/", "location": [29.8413, 78.6764]},
        {"name": "Kasang Regency", "website": "https://www.kasangregency.com/", "location": [29.8352, 78.6789]}
    ],
    "Chaukori hill station": [
        {"name": "Ojaswi Resort", "website": "https://www.ojaswiresort.com/chaukori/", "location": [29.8477, 80.0354]},
        {"name": "Kafal Resort", "website": "https://www.kafalresort.com/", "location": [29.8441, 80.0369]},
        {"name": "The Himalayan View", "website": "https://www.himalayanviewchaukori.com/", "location": [29.8500, 80.0300]}
    ],
    "Nelong valley": [
        {"name": "Tapovan Cottage", "website": "https://tapovancottage.com/", "location": [30.7747, 79.9499]},
        {"name": "Himalayan Retreat", "website": "https://www.himalayanretreat.com/", "location": [30.7800, 79.9500]},
        {"name": "Valley View Inn", "website": "https://www.valleyviewinn.com/", "location": [30.7700, 79.9400]}
    ],
    "Harsil valley": [
        {"name": "Snowpod Harsil", "website": "https://snowpodharsil.com/", "location": [30.6227, 78.8958]},
        {"name": "Harsil Lodge", "website": "https://www.harsillodge.com/", "location": [30.6200, 78.9000]},
        {"name": "Harsil Retreat", "website": "https://www.harsilretreat.com/", "location": [30.6250, 78.8900]}
    ],
    "Chamoli": [
        {"name": "Hareli Inn", "website": "https://harelainn.com/", "location": [30.4565, 79.3155]},
        {"name": "Chamoli Heights", "website": "https://www.chamoliheights.com/", "location": [30.4600, 79.3100]},
        {"name": "Mountain View Hotel", "website": "https://www.mountainviewchamoli.com/", "location": [30.4550, 79.3200]}
    ],

    # Karnataka
    "Devaramane Hill": [
        {"name": "Guddadamane Homestay", "website": "https://www.guddadamanehomestay.com/", "location": [13.2820, 75.2350]},
        {"name": "Hill View Lodge", "website": "https://www.hillviewlodge.com/", "location": [13.2800, 75.2300]},
        {"name": "Nature's Retreat", "website": "https://www.naturesretreat.com/", "location": [13.2750, 75.2400]}
    ],
    "Kalasa town": [
        {"name": "Mayura Hotel", "website": "https://www.kstdc.co/mayura-hotels/", "location": [13.5662, 75.6337]},
        {"name": "Kalasa Retreat", "website": "https://www.kalasaretreat.com/", "location": [13.5700, 75.6300]},
        {"name": "The Serenity", "website": "https://www.theserenity.com/", "location": [13.5650, 75.6200]}
    ],
    "Sasihitlu beach": [
        {"name": "Beachside Resort", "website": "https://www.beachside.com/", "location": [13.1080, 74.8700]},
        {"name": "Sasihitlu Haven", "website": "https://www.sasihitlu.com/", "location": [13.1100, 74.8750]}
    ],
    "Kemmangundi Hill station": [
        {"name": "Kemmangundi Lodge", "website": "https://www.kemmangundilodge.com/", "location": [13.3189, 75.5884]},
        {"name": "Hilltop Retreat", "website": "https://www.hilltopretreat.com/", "location": [13.3200, 75.5900]}
    ],
    "Honnemaradu": [
        {"name": "Honnemaradu Eco Resort", "website": "https://www.honnemaradu.com/", "location": [13.2700, 75.1600]},
        {"name": "Riverside Retreat", "website": "https://www.riversideretreat.com/", "location": [13.2750, 75.1650]}
    ],
    "Kavledurga fort": [
        {"name": "Fort View Lodge", "website": "https://www.fortviewlodge.com/", "location": [13.8260, 75.3580]},
        {"name": "Kavledurga Retreat", "website": "https://www.kavledurgaretreat.com/", "location": [13.8200, 75.3600]}
    ],

    # Himachal Pradesh
    "Hatu peak Narkanda": [
        {"name": "Hatu Peak Hotel", "website": "https://www.hatupeakhotel.com/", "location": [31.3142, 77.4278]},
        {"name": "Narkanda Lodge", "website": "https://www.narkandalodge.com/", "location": [31.3100, 77.4200]}
    ],
    "Chitkul": [
        {"name": "Chitkul Retreat", "website": "https://www.chitkulretreat.com/", "location": [31.2510, 78.6760]},
        {"name": "The Chitkul Inn", "website": "https://www.chitkulinn.com/", "location": [31.2500, 78.6700]}
    ],
    "Pabbar valley": [
        {"name": "Pabbar Valley Resort", "website": "https://www.pabbarvalleyresort.com/", "location": [31.2590, 77.7250]},
        {"name": "Valley View Lodge", "website": "https://www.valleyviewlodge.com/", "location": [31.2600, 77.7200]}
    ],
    "Shangarh": [
        {"name": "Shangarh Lodge", "website": "https://www.shangarhlodge.com/", "location": [31.3120, 77.4500]},
        {"name": "Himalayan Retreat", "website": "https://www.himalayanretreat.com/", "location": [31.3150, 77.4600]}
    ],
    "Shoja Village": [
        {"name": "Shoja Village Hotel", "website": "https://www.shojavillagehotel.com/", "location": [31.2650, 77.5050]},
        {"name": "Mountain View Resort", "website": "https://www.mountainviewshoja.com/", "location": [31.2700, 77.5100]}
    ],
    "Barot valley": [
        {"name": "Barot Valley Lodge", "website": "https://www.barotvalleylodge.com/", "location": [31.8680, 76.6210]},
        {"name": "The Valley Retreat", "website": "https://www.thevalleyretreat.com/", "location": [31.8700, 76.6200]}
    ],

    # Rajasthan
    "Khejarla fort": [
        {"name": "Khejarla Fort Hotel", "website": "https://www.khejarla.com/", "location": [27.5133, 73.1256]},
        {"name": "Fort View Resort", "website": "https://www.fortviewresort.com/", "location": [27.5100, 73.1300]}
    ],
    "Thar Desert": [
        {"name": "Desert Safari Camp", "website": "https://www.desertsafaricamp.com/", "location": [26.9250, 70.9010]},
        {"name": "Thar Desert Lodge", "website": "https://www.thardesertlodge.com/", "location": [26.9200, 70.9000]}
    ],
    "Khimsar village": [
        {"name": "Khimsar Fort Hotel", "website": "https://www.khimsarfort.com/", "location": [27.1444, 73.3861]},
        {"name": "Village Retreat", "website": "https://www.villageretreat.com/", "location": [27.1400, 73.3800]}
    ],
    "Sambhar lake": [
        {"name": "Sambhar Lake Resort", "website": "https://www.sambharlakeresort.com/", "location": [26.9560, 75.2950]},
        {"name": "Lake View Lodge", "website": "https://www.lakeviewlodge.com/", "location": [26.9600, 75.3000]}
    ],
    "Banswara": [
        {"name": "Banswara Hotel", "website": "https://www.banswarahotel.com/", "location": [23.5461, 74.3176]},
        {"name": "Royal Retreat", "website": "https://www.royalretreatbanswara.com/", "location": [23.5500, 74.3200]}
    ],
    "Kumbhalgarh Fort": [
        {"name": "Kumbhalgarh Fort Hotel", "website": "https://www.kumbhalgarhfort.com/", "location": [25.0895, 73.4717]},
        {"name": "Fort View Resort", "website": "https://www.fortviewkumbhalgarh.com/", "location": [25.0900, 73.4700]}
    ],

    # Meghalaya
    "Mawlynnong": [
        {"name": "Mawlynnong Homestay", "website": "https://www.mawlynnonghomestay.com/", "location": [25.3051, 91.5824]},
        {"name": "Green Village Resort", "website": "https://www.greenvillageresort.com/", "location": [25.3100, 91.5800]}
    ],
    "Mawphlang Sacred Forest": [
        {"name": "Sacred Forest Lodge", "website": "https://www.sacredforestlodge.com/", "location": [25.3000, 91.5700]},
        {"name": "Forest Retreat", "website": "https://www.forestretreat.com/", "location": [25.3050, 91.5750]}
    ],
    "Ranikor": [
        {"name": "Ranikor Lodge", "website": "https://www.ranikorlodge.com/", "location": [25.2268, 91.6238]},
        {"name": "Ranikor Retreat", "website": "https://www.ranikorretreat.com/", "location": [25.2300, 91.6200]}
    ],
    "Garden of Caves": [
        {"name": "Cave Garden Resort", "website": "https://www.cavegardenresort.com/", "location": [25.2280, 91.6350]},
        {"name": "Garden View Lodge", "website": "https://www.gardenviewlodge.com/", "location": [25.2300, 91.6300]}
    ],
    "Dawki River": [
        {"name": "Dawki River Resort", "website": "https://www.dawkiriverresort.com/", "location": [25.2910, 92.2345]},
        {"name": "River View Lodge", "website": "https://www.riverviewlodge.com/", "location": [25.2900, 92.2300]}
    ],
    "Laitkynsew": [
        {"name": "Laitkynsew Lodge", "website": "https://www.laitkynsewlodge.com/", "location": [25.2970, 91.5840]},
        {"name": "Laitkynsew Retreat", "website": "https://www.laitkynsewretreat.com/", "location": [25.3000, 91.5800]}
    ],

    # Goa
    "Salaulim dam": [
        {"name": "Salaulim Resort", "website": "https://www.salaulimresort.com/", "location": [15.3452, 74.0818]},
        {"name": "Dam View Lodge", "website": "https://www.damviewlodge.com/", "location": [15.3500, 74.0800]}
    ],
    "Cola beach": [
        {"name": "Cola Beach Resort", "website": "https://www.colabeachresort.com/", "location": [15.0712, 74.0227]},
        {"name": "Beachside Lodge", "website": "https://www.beachsidecolaresort.com/", "location": [15.0700, 74.0250]}
    ],
    "Cabo de Rama beach": [
        {"name": "Cabo de Rama Lodge", "website": "https://www.caboderamalodge.com/", "location": [15.0190, 74.0320]},
        {"name": "Beach View Resort", "website": "https://www.beachviewcabo.com/", "location": [15.0200, 74.0300]}
    ],
    "Devil’s Finger Cave": [
        {"name": "Cave Lodge", "website": "https://www.cavelodge.com/", "location": [15.2890, 74.0320]},
        {"name": "Devil’s Finger Resort", "website": "https://www.devilsfinger.com/", "location": [15.2900, 74.0350]}
    ],
    "Sanguem village": [
        {"name": "Sanguem Lodge", "website": "https://www.sanguemlodge.com/", "location": [15.2667, 74.2028]},
        {"name": "Village Retreat", "website": "https://www.villageretreatsanguem.com/", "location": [15.2700, 74.2000]}
    ],
    "Butterfly beach": [
        {"name": "Butterfly Beach Resort", "website": "https://www.butterflybeachresort.com/", "location": [15.0140, 74.0745]},
        {"name": "Beachside Lodge", "website": "https://www.beachsidebutterfly.com/", "location": [15.0150, 74.0700]}
    ],

    # Gujarat
    "Girmal Waterfall": [
        {"name": "Girmal Resort", "website": "https://www.girmalresort.com/", "location": [21.3280, 74.3512]},
        {"name": "Waterfall View Lodge", "website": "https://www.waterfallviewlodge.com/", "location": [21.3300, 74.3500]}
    ],
    "Bechtel beach": [
        {"name": "Bechtel Beach Resort", "website": "https://www.bechtelbeachresort.com/", "location": [20.8323, 72.5400]},
        {"name": "Beachside Lodge", "website": "https://www.beachtelbeach.com/", "location": [20.8300, 72.5450]}
    ],
    "KadiyaDhro": [
        {"name": "KadiyaDhro Resort", "website": "https://www.kadiyadhro.com/", "location": [22.7765, 72.6458]},
        {"name": "Dhro Lodge", "website": "https://www.dhrolodge.com/", "location": [22.7800, 72.6400]}
    ],
    "Wilson Hill": [
        {"name": "Wilson Hill Lodge", "website": "https://www.wilsonhilllodge.com/", "location": [21.4254, 72.6796]},
        {"name": "Hilltop Retreat", "website": "https://www.hilltopwilson.com/", "location": [21.4200, 72.6750]}
    ],
    "Zarwani Waterfall": [
        {"name": "Zarwani Resort", "website": "https://www.zarwanifalls.com/", "location": [22.2166, 73.0998]},
        {"name": "Waterfall Lodge", "website": "https://www.waterfallzarwani.com/", "location": [22.2200, 73.1000]}
    ],
    "Keliya dam": [
        {"name": "Keliya Dam Resort", "website": "https://www.keliyadam.com/", "location": [21.7417, 73.0747]},
        {"name": "Dam View Lodge", "website": "https://www.damviewkeliya.com/", "location": [21.7400, 73.0700]}
    ],

    # Jammu and Kashmir
    "Gurez Valley": [
        {"name": "Gurez Lodge", "website": "https://www.gurezlodge.com/", "location": [34.1567, 73.7495]},
        {"name": "Valley View Resort", "website": "https://www.valleyviewgurez.com/", "location": [34.1600, 73.7500]}
    ],
    "TarsarMarsar Trek": [
        {"name": "Tarsar Marsar Lodge", "website": "https://www.tarsarmarsarlodge.com/", "location": [34.1881, 74.0641]},
        {"name": "Trek View Resort", "website": "https://www.trekviewtarsarmarsar.com/", "location": [34.1900, 74.0600]}
    ],
    "Sanasar": [
        {"name": "Sanasar Resort", "website": "https://www.sanasarresort.com/", "location": [33.6352, 75.3246]},
        {"name": "Sanasar Lodge", "website": "https://www.sanasarlodge.com/", "location": [33.6300, 75.3200]}
    ],
    "Chatpal": [
        {"name": "Chatpal Lodge", "website": "https://www.chatpallodge.com/", "location": [33.7280, 75.2950]},
        {"name": "Chatpal Retreat", "website": "https://www.chatpalretreat.com/", "location": [33.7300, 75.2900]}
    ],
    "Bhaderwah": [
        {"name": "Bhaderwah Resort", "website": "https://www.bhaderwahresort.com/", "location": [32.9800, 75.5167]},
        {"name": "Valley Lodge", "website": "https://www.valleybhaderwah.com/", "location": [32.9800, 75.5200]}
    ],
    "Pari Mahal": [
        {"name": "Pari Mahal Lodge", "website": "https://www.parimahallodge.com/", "location": [34.0830, 74.7974]},
        {"name": "Mahal View Resort", "website": "https://www.mahalviewresort.com/", "location": [34.0800, 74.8000]}
    ]
}

transportation_data = {
    # Uttarakhand
    "Uttarakhand": [
        {
            "city": "Dehradun",
            "services": [
                {"type": "Taxi", "operator": "Uttarakhand Cabs", "website": "https://www.uttarakhandcabs.com/", "contact": "+91-1234567890", "location": [30.3165, 78.0322]},
                {"type": "Bus", "operator": "Uttarakhand State Transport", "website": "https://www.uttarakhandtransport.com/", "contact": "+91-0987654321", "location": [30.3170, 78.0320]},
                {"type": "Rental Car", "operator": "Himalayan Rentals", "website": "https://www.himalayanrentals.com/", "contact": "+91-1122334455", "location": [30.3168, 78.0316]}
            ]
        },
        {
            "city": "Nainital",
            "services": [
                {"type": "Taxi", "operator": "Nainital Cabs", "website": "https://www.nainitalcabs.com/", "contact": "+91-2233445566", "location": [29.3919, 79.4548]},
                {"type": "Bus", "operator": "Nainital Transport", "website": "https://www.nainitaltransport.com/", "contact": "+91-6677889900", "location": [29.3920, 79.4550]},
                {"type": "Rental Car", "operator": "Lakeview Rentals", "website": "https://www.lakeviewrentals.com/", "contact": "+91-3344556677", "location": [29.3915, 79.4535]}
            ]
        }
    ],

    # Karnataka
    "Karnataka": [
        {
            "city": "Bangalore",
            "services": [
                {"type": "Taxi", "operator": "Bangalore Cabs", "website": "https://www.bangalorecabs.com/", "contact": "+91-9988776655", "location": [12.9716, 77.5946]},
                {"type": "Bus", "operator": "Bangalore Metropolitan Transport Corporation", "website": "https://www.bmtc.gov.in/", "contact": "+91-7766554433", "location": [12.9718, 77.5945]},
                {"type": "Rental Car", "operator": "Nature's Drive", "website": "https://www.naturesdrive.com/", "contact": "+91-2233445566", "location": [12.9700, 77.5900]}
            ]
        },
        {
            "city": "Mysore",
            "services": [
                {"type": "Taxi", "operator": "Mysore Cabs", "website": "https://www.mysorecabs.com/", "contact": "+91-4455667788", "location": [12.2958, 76.6394]},
                {"type": "Bus", "operator": "Mysore Transport", "website": "https://www.mysoretransport.com/", "contact": "+91-9988776655", "location": [12.2960, 76.6400]},
                {"type": "Rental Car", "operator": "Heritage Rentals", "website": "https://www.heritagerentals.com/", "contact": "+91-5566778899", "location": [12.2965, 76.6380]}
            ]
        }
    ],

    # Himachal Pradesh
    "Himachal Pradesh": [
        {
            "city": "Shimla",
            "services": [
                {"type": "Taxi", "operator": "Shimla Cabs", "website": "https://www.shimlacabs.com/", "contact": "+91-1234567891", "location": [31.1048, 77.1734]},
                {"type": "Bus", "operator": "Himachal Transport", "website": "https://www.himachaltransport.com/", "contact": "+91-2345678901", "location": [31.1050, 77.1750]},
                {"type": "Rental Car", "operator": "Mountain Drive", "website": "https://www.mountaindrive.com/", "contact": "+91-3456789012", "location": [31.1030, 77.1720]}
            ]
        },
        {
            "city": "Manali",
            "services": [
                {"type": "Taxi", "operator": "Manali Cabs", "website": "https://www.manalicabs.com/", "contact": "+91-4567890123", "location": [32.2396, 77.1887]},
                {"type": "Bus", "operator": "Manali Transport", "website": "https://www.manalitransport.com/", "contact": "+91-5678901234", "location": [32.2400, 77.1900]},
                {"type": "Rental Car", "operator": "Snowline Rentals", "website": "https://www.snowlinerentals.com/", "contact": "+91-6789012345", "location": [32.2380, 77.1870]}
            ]
        }
    ],

    # Goa
    "Goa": [
        {
            "city": "Panaji",
            "services": [
                {"type": "Taxi", "operator": "Panaji Cabs", "website": "https://www.panajicabs.com/", "contact": "+91-9012345678", "location": [15.4909, 73.8288]},
                {"type": "Bus", "operator": "Goa Transport", "website": "https://www.goatransport.com/", "contact": "+91-0123456789", "location": [15.4910, 73.8290]},
                {"type": "Rental Car", "operator": "Goa Rentals", "website": "https://www.goarentals.com/", "contact": "+91-1234567890", "location": [15.4920, 73.8300]}
            ]
        },
        {
            "city": "Margao",
            "services": [
                {"type": "Taxi", "operator": "Margao Taxis", "website": "https://www.margaotaxis.com/", "contact": "+91-2345678901", "location": [15.2934, 74.0218]},
                {"type": "Bus", "operator": "Margao Transport", "website": "https://www.margaotransport.com/", "contact": "+91-3456789012", "location": [15.2930, 74.0220]},
                {"type": "Rental Car", "operator": "Coastal Rentals", "website": "https://www.coastalrentals.com/", "contact": "+91-4567890123", "location": [15.2940, 74.0230]}
            ]
        }
    ],
    "Gujarat": [
        {
            "city": "Ahmedabad",
            "services": [
                {"type": "Taxi", "operator": "Ahmedabad Cabs", "website": "https://www.ahmedabadcabs.com/", "contact": "+91-9876543210", "location": [23.0225, 72.5714]},
                {"type": "Bus", "operator": "Gujarat State Road Transport Corporation", "website": "https://www.gsrtc.in/", "contact": "+91-9999999999", "location": [23.0226, 72.5715]},
                {"type": "Rental Car", "operator": "Gujarat Rentals", "website": "https://www.gujaratrentals.com/", "contact": "+91-8888888888", "location": [23.0230, 72.5700]}
            ]
        },
        {
            "city": "Surat",
            "services": [
                {"type": "Taxi", "operator": "Surat Cabs", "website": "https://www.suratcabs.com/", "contact": "+91-9123456789", "location": [21.1702, 72.8311]},
                {"type": "Bus", "operator": "Surat Transport", "website": "https://www.surattransport.com/", "contact": "+91-8778888888", "location": [21.1703, 72.8310]},
                {"type": "Rental Car", "operator": "Surat Rentals", "website": "https://www.suratrentals.com/", "contact": "+91-9666666666", "location": [21.1705, 72.8305]}
            ]
        },
        {
            "city": "Vadodara",
            "services": [
                {"type": "Taxi", "operator": "Vadodara Cabs", "website": "https://www.vadodaracabs.com/", "contact": "+91-8234567890", "location": [22.3078, 73.1812]},
                {"type": "Bus", "operator": "Vadodara Transport", "website": "https://www.vadodaratransport.com/", "contact": "+91-8444444444", "location": [22.3080, 73.1800]},
                {"type": "Rental Car", "operator": "City Rentals", "website": "https://www.cityrentals.com/", "contact": "+91-9555555555", "location": [22.3082, 73.1795]}
            ]
        },
        {
            "city": "Rajkot",
            "services": [
                {"type": "Taxi", "operator": "Rajkot Cabs", "website": "https://www.rajkotcabs.com/", "contact": "+91-9324567890", "location": [22.3039, 70.8022]},
                {"type": "Bus", "operator": "Rajkot Transport", "website": "https://www.rajkottransport.com/", "contact": "+91-8234567890", "location": [22.3040, 70.8030]},
                {"type": "Rental Car", "operator": "Rajkot Rentals", "website": "https://www.rajkotrentals.com/", "contact": "+91-9444444444", "location": [22.3045, 70.8000]}
            ]
        },
        {
            "city": "Gandhinagar",
            "services": [
                {"type": "Taxi", "operator": "Gandhinagar Cabs", "website": "https://www.gandhinagarcabs.com/", "contact": "+91-9412345678", "location": [23.2156, 72.6369]},
                {"type": "Bus", "operator": "Gandhinagar Transport", "website": "https://www.gandhinagartransport.com/", "contact": "+91-8222222222", "location": [23.2160, 72.6370]},
                {"type": "Rental Car", "operator": "Gandhinagar Rentals", "website": "https://www.gandhinagarrentals.com/", "contact": "+91-9333333333", "location": [23.2165, 72.6355]}
            ]
        }
    ],
    "Maharashtra": [
        {
            "city": "Mumbai",
            "services": [
                {"type": "Taxi", "operator": "Mumbai Cabs", "website": "https://www.mumbaicabs.com/", "contact": "+91-9123456789", "location": [19.0760, 72.8777]},
                {"type": "Bus", "operator": "BEST Bus", "website": "https://www.bestbus.com/", "contact": "+91-9820466099", "location": [19.0765, 72.8770]},
                {"type": "Rental Car", "operator": "Mumbai Rentals", "website": "https://www.mumbairentals.com/", "contact": "+91-9988776655", "location": [19.0750, 72.8780]}
            ]
        },
        {
            "city": "Pune",
            "services": [
                {"type": "Taxi", "operator": "Pune Cabs", "website": "https://www.punecabs.com/", "contact": "+91-9234567890", "location": [18.5204, 73.8567]},
                {"type": "Bus", "operator": "Pune Mahanagar Parivahan Mahamandal Ltd", "website": "https://www.pmtpml.com/", "contact": "+91-9000000000", "location": [18.5210, 73.8570]},
                {"type": "Rental Car", "operator": "Pune Rentals", "website": "https://www.punerentals.com/", "contact": "+91-9777777777", "location": [18.5220, 73.8550]}
            ]
        },
        {
            "city": "Nagpur",
            "services": [
                {"type": "Taxi", "operator": "Nagpur Cabs", "website": "https://www.nagpurcabs.com/", "contact": "+91-9123456789", "location": [21.1458, 79.0882]},
                {"type": "Bus", "operator": "Nagpur Municipal Transport", "website": "https://www.nmtnagpur.com/", "contact": "+91-9222222222", "location": [21.1460, 79.0890]},
                {"type": "Rental Car", "operator": "Nagpur Rentals", "website": "https://www.nagpurrentals.com/", "contact": "+91-9444444444", "location": [21.1465, 79.0900]}
            ]
        },
        {
            "city": "Aurangabad",
            "services": [
                {"type": "Taxi", "operator": "Aurangabad Cabs", "website": "https://www.aurangabadcabs.com/", "contact": "+91-9324567890", "location": [19.8762, 75.3433]},
                {"type": "Bus", "operator": "Aurangabad Transport", "website": "https://www.aurangabadtransport.com/", "contact": "+91-9888888888", "location": [19.8770, 75.3400]},
                {"type": "Rental Car", "operator": "Aurangabad Rentals", "website": "https://www.aurangabadrentals.com/", "contact": "+91-9333333333", "location": [19.8750, 75.3450]}
            ]
        }
    ],
    "Tamil Nadu": [
        {
            "city": "Chennai",
            "services": [
                {"type": "Taxi", "operator": "Chennai Cabs", "website": "https://www.chennaicabs.com/", "contact": "+91-9444444444", "location": [13.0827, 80.2707]},
                {"type": "Bus", "operator": "MTC Chennai", "website": "https://www.mtcbus.org/", "contact": "+91-9087888899", "location": [13.0830, 80.2710]},
                {"type": "Rental Car", "operator": "Chennai Rentals", "website": "https://www.chennairentals.com/", "contact": "+91-9123456789", "location": [13.0850, 80.2700]}
            ]
        },
        {
            "city": "Coimbatore",
            "services": [
                {"type": "Taxi", "operator": "Coimbatore Cabs", "website": "https://www.coimbatorecabs.com/", "contact": "+91-9655555555", "location": [11.0168, 76.9558]},
                {"type": "Bus", "operator": "Coimbatore Transport", "website": "https://www.coimbatoretransport.com/", "contact": "+91-9600000000", "location": [11.0170, 76.9500]},
                {"type": "Rental Car", "operator": "Coimbatore Rentals", "website": "https://www.coimbatorerentals.com/", "contact": "+91-9866666666", "location": [11.0180, 76.9520]}
            ]
        },
        {
            "city": "Madurai",
            "services": [
                {"type": "Taxi", "operator": "Madurai Cabs", "website": "https://www.madurai.com/", "contact": "+91-9755555555", "location": [9.9252, 78.1198]},
                {"type": "Bus", "operator": "Madurai Transport", "website": "https://www.maduraitransport.com/", "contact": "+91-9777777777", "location": [9.9260, 78.1200]},
                {"type": "Rental Car", "operator": "Madurai Rentals", "website": "https://www.madurairentals.com/", "contact": "+91-9799999999", "location": [9.9250, 78.1210]}
            ]
        },
        {
            "city": "Tiruchirappalli",
            "services": [
                {"type": "Taxi", "operator": "Trichy Cabs", "website": "https://www.trichycabs.com/", "contact": "+91-9177777777", "location": [10.7905, 78.7047]},
                {"type": "Bus", "operator": "Trichy Transport", "website": "https://www.trichytransport.com/", "contact": "+91-9123456789", "location": [10.7920, 78.7050]},
                {"type": "Rental Car", "operator": "Trichy Rentals", "website": "https://www.trichyrentals.com/", "contact": "+91-9366666666", "location": [10.7900, 78.7060]}
            ]
        }
    ],
    "West Bengal": [
        {
            "city": "Kolkata",
            "services": [
                {"type": "Taxi", "operator": "Kolkata Cabs", "website": "https://www.kolkata.com/", "contact": "+91-9000000000", "location": [22.5726, 88.3639]},
                {"type": "Bus", "operator": "Kolkata Transport", "website": "https://www.kolkatabuses.com/", "contact": "+91-9999999999", "location": [22.5730, 88.3640]},
                {"type": "Rental Car", "operator": "Kolkata Rentals", "website": "https://www.kolkatarentals.com/", "contact": "+91-9234567890", "location": [22.5750, 88.3650]}
            ]
        },
        {
            "city": "Howrah",
            "services": [
                {"type": "Taxi", "operator": "Howrah Cabs", "website": "https://www.howrahcabs.com/", "contact": "+91-9822334455", "location": [22.5958, 88.2636]},
                {"type": "Bus", "operator": "Howrah Transport", "website": "https://www.howrahtransport.com/", "contact": "+91-9811111111", "location": [22.5970, 88.2650]},
                {"type": "Rental Car", "operator": "Howrah Rentals", "website": "https://www.howrahrentals.com/", "contact": "+91-9888776655", "location": [22.5960, 88.2640]}
            ]
        },
        {
            "city": "Durgapur",
            "services": [
                {"type": "Taxi", "operator": "Durgapur Cabs", "website": "https://www.durgapurcabs.com/", "contact": "+91-9155555555", "location": [23.5070, 87.2910]},
                {"type": "Bus", "operator": "Durgapur Transport", "website": "https://www.durgapurtransport.com/", "contact": "+91-9234567890", "location": [23.5100, 87.2900]},
                {"type": "Rental Car", "operator": "Durgapur Rentals", "website": "https://www.durgapurrentals.com/", "contact": "+91-9444444444", "location": [23.5120, 87.2920]}
            ]
        },
        {
            "city": "Asansol",
            "services": [
                {"type": "Taxi", "operator": "Asansol Cabs", "website": "https://www.asansolcabs.com/", "contact": "+91-9777777777", "location": [23.6824, 86.9988]},
                {"type": "Bus", "operator": "Asansol Transport", "website": "https://www.asansoltransport.com/", "contact": "+91-9888888888", "location": [23.6830, 86.9990]},
                {"type": "Rental Car", "operator": "Asansol Rentals", "website": "https://www.asansolrentals.com/", "contact": "+91-9393939393", "location": [23.6840, 86.9950]}
            ]
        }
    ],
    "Kerala": [
        {
            "city": "Thiruvananthapuram",
            "services": [
                {"type": "Taxi", "operator": "Thiruvananthapuram Cabs", "website": "https://www.thiruvananthapuramcabs.com/", "contact": "+91-9444444444", "location": [8.5241, 76.9366]},
                {"type": "Bus", "operator": "KSRTC", "website": "https://www.ksrtc.in/", "contact": "+91-9999999999", "location": [8.5250, 76.9370]},
                {"type": "Rental Car", "operator": "Thiruvananthapuram Rentals", "website": "https://www.thiruvananthapuramrentals.com/", "contact": "+91-9123456789", "location": [8.5260, 76.9380]}
            ]
        },
        {
            "city": "Kochi",
            "services": [
                {"type": "Taxi", "operator": "Kochi Cabs", "website": "https://www.kochicabs.com/", "contact": "+91-9888888888", "location": [9.9312, 76.2673]},
                {"type": "Bus", "operator": "Kochi Transport", "website": "https://www.kochitransport.com/", "contact": "+91-9234567890", "location": [9.9320, 76.2680]},
                {"type": "Rental Car", "operator": "Kochi Rentals", "website": "https://www.kochinentals.com/", "contact": "+91-9444444444", "location": [9.9330, 76.2690]}
            ]
        },
        {
            "city": "Kozhikode",
            "services": [
                {"type": "Taxi", "operator": "Kozhikode Cabs", "website": "https://www.kozhikodecabs.com/", "contact": "+91-9777777777", "location": [11.2588, 75.7804]},
                {"type": "Bus", "operator": "Kozhikode Transport", "website": "https://www.kozhikodetransport.com/", "contact": "+91-9888888888", "location": [11.2590, 75.7800]},
                {"type": "Rental Car", "operator": "Kozhikode Rentals", "website": "https://www.kozhikoderentals.com/", "contact": "+91-9393939393", "location": [11.2600, 75.7810]}
            ]
        },
        {
            "city": "Kollam",
            "services": [
                {"type": "Taxi", "operator": "Kollam Cabs", "website": "https://www.kollamcabs.com/", "contact": "+91-9222334455", "location": [8.8910, 76.6140]},
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