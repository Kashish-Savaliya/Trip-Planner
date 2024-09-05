BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "app_hist_back" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "head" text NOT NULL, "info" text NOT NULL, "place_id" bigint NOT NULL REFERENCES "app_place" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "app_nearby_place" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "placename" varchar(100) NOT NULL, "desc" text NOT NULL, "main_place_id" bigint NOT NULL REFERENCES "app_place" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "app_place" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "place_name" varchar(100) NOT NULL, "story" text NOT NULL, "image1" varchar(100) NOT NULL, "image2" varchar(100) NOT NULL, "image3" varchar(100) NOT NULL, "state_id" bigint NOT NULL REFERENCES "app_state" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "app_review" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "location" varchar(50) NOT NULL, "rating" varchar(10) NOT NULL, "review" text NOT NULL);
CREATE TABLE IF NOT EXISTS "app_state" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "state_name" varchar(50) NOT NULL, "direction" varchar(50) NOT NULL);
CREATE TABLE IF NOT EXISTS "app_travel_and_cost" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "category" varchar(20) NOT NULL, "title" varchar(100) NOT NULL, "description" text NOT NULL, "cost" varchar(100) NOT NULL, "additional_info" text NOT NULL, "main_place_id" bigint NOT NULL REFERENCES "app_place" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "app_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "email" varchar(254) NOT NULL UNIQUE, "location" varchar(100) NOT NULL, "is_active" bool NOT NULL, "is_staff" bool NOT NULL, "last_login" datetime NULL, "password" varchar(128) NOT NULL);
CREATE TABLE IF NOT EXISTS "auth_group" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(150) NOT NULL UNIQUE);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "auth_permission" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "codename" varchar(100) NOT NULL, "name" varchar(255) NOT NULL);
CREATE TABLE IF NOT EXISTS "auth_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "password" varchar(128) NOT NULL, "last_login" datetime NULL, "is_superuser" bool NOT NULL, "username" varchar(150) NOT NULL UNIQUE, "last_name" varchar(150) NOT NULL, "email" varchar(254) NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "date_joined" datetime NOT NULL, "first_name" varchar(150) NOT NULL);
CREATE TABLE IF NOT EXISTS "auth_user_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "django_admin_log" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "object_id" text NULL, "object_repr" varchar(200) NOT NULL, "action_flag" smallint unsigned NOT NULL CHECK ("action_flag" >= 0), "change_message" text NOT NULL, "content_type_id" integer NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "action_time" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "django_content_type" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app_label" varchar(100) NOT NULL, "model" varchar(100) NOT NULL);
CREATE TABLE IF NOT EXISTS "django_migrations" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "applied" datetime NOT NULL);
CREATE TABLE IF NOT EXISTS "django_session" ("session_key" varchar(40) NOT NULL PRIMARY KEY, "session_data" text NOT NULL, "expire_date" datetime NOT NULL);
INSERT INTO "app_hist_back" ("id","head","info","place_id") VALUES (1,'Ancient Significance','Gurez Valley has a rich historical and cultural heritage, with its roots tracing back to ancient times. It was part of the ancient Dardistan region, home to the Dards, an Indo-Aryan ethnic group. The Dard people are mentioned in several ancient texts, including the Mahabharata and the works of Herodotus, the Greek historian.',1),
 (2,'Strategic Location:','The valley''s strategic location made it an important trade route between Kashmir and Gilgit-Baltistan. It was part of the ancient Silk Route, facilitating the movement of goods and culture between Central Asia and the Indian subcontinent.',1),
 (3,'Cultural Heritage','The people of Gurez, known as Dard-Shin, have a distinct culture, language, and traditions. They speak Shina, an ancient Dardic language, and have preserved their unique cultural identity despite the influences of neighboring regions.',1),
 (4,'Ancient Significance','The Kashmir Valley, where the Tarsar Marsar trek is located, has a rich history dating back thousands of years. It has been a significant center of Hinduism and Buddhism before the advent of Islam. The region is known for its ancient temples, monasteries, and a deep cultural heritage',2),
 (5,'Local Legends and Folklore','The lakes and surrounding areas are steeped in local legends and folklore. It is believed that the lakes have mystical powers and are considered sacred by the locals. The beauty and serenity of the lakes have inspired many local tales and songs.',2),
 (6,'Mughal Era','During the Mughal era, the Kashmir Valley was a favorite retreat for the Mughal emperors. They were enchanted by the natural beauty of the region, including the areas around the Tarsar and Marsar lakes. The Mughal influence can still be seen in the region''s architecture and gardens.',2),
 (7,'Ancient Origins','The region around Sanasar has been inhabited for centuries, primarily by local hill tribes. The lush meadows, dense forests, and fertile land made it an attractive settlement for ancient communities.',3),
 (8,'Name and Legend','Sanasar gets its name from the two local lakes, Sana and Sar. According to local folklore, the lakes are named after two mythical brothers, Sana and Sar, who are believed to have discovered the place.',3),
 (9,'Ancient Roots','Like much of the Kashmir Valley, Chatpal has a long history of human habitation. The region has been influenced by various cultures and civilizations over the centuries, including Hinduism, Buddhism, and Islam.',4),
 (10,'Local Tribes','The area around Chatpal has been traditionally inhabited by Gujjar and Bakarwal tribes. These nomadic tribes have a rich cultural heritage and have lived in harmony with nature, relying on livestock herding and small-scale agriculture.',4),
 (11,'Ancient Roots','Bhaderwah''s history dates back to ancient times. It is believed to have been part of the Mahajanapadas during the Vedic period. The region has seen various dynasties and rulers over the centuries, contributing to its rich historical tapestry.',5),
 (12,'Medieval Era','During the medieval period, Bhaderwah was ruled by various local chieftains and small kingdoms. The town has been influenced by different cultures and religions, including Hinduism and Islam. The presence of ancient temples and mosques reflects this diverse cultural heritage.',5),
 (13,'Dogra Rule','Bhaderwah came under Dogra rule in the 19th century when it was annexed by the Dogra rulers of Jammu and Kashmir. The Dogra dynasty, known for its administrative and military prowess, left a lasting impact on the region. Bhaderwah served as an important administrative and cultural center during this period.',5),
 (14,'Mughal Era','Pari Mahal was built during the Mughal era by Dara Shikoh, the eldest son of the Mughal Emperor Shah Jahan, who is famously known for constructing the Taj Mahal. Dara Shikoh was a scholar and a mystic, deeply interested in Sufism and Persian literature.',6),
 (15,'Construction:','The construction of Pari Mahal is believed to have taken place in the mid-17th century. It was initially built as a library and a retreat for Dara Shikoh to study and promote the teachings of Sufism and Persian culture. The structure served as a center for learning and discussions on philosophy, astronomy, and literature.',6),
 (16,'Symbolic Architecture and Design','Pari Mahal''s design is notable for its unique blend of Persian and Mughal architectural styles, featuring seven terraces that symbolize the seven layers of heaven in Islamic cosmology. The palace is set amidst a beautifully landscaped garden and overlooks Dal Lake, integrating natural beauty with architectural elegance. The design elements and the location reflect Dara Shikoh''s deep appreciation for Persian aesthetics and his vision of blending spirituality with nature.',6),
 (17,'Strategic Location and Historical Trade Routes','Chatpal is strategically located along historical trade routes that connected the Kashmir Valley to regions like Ladakh and Central Asia. This positioning made Chatpal an important transit point for trade and cultural exchanges. The area''s location facilitated the movement of goods such as spices, textiles, and precious stones, contributing to its historical significance as a bustling trade hub in ancient times.',4),
 (18,'Historical Significance and Colonial Influence','During the British colonial era, Sanasar was recognized for its potential as a summer retreat and a recreational spot. The British saw the region’s cool climate and scenic beauty as ideal for creating a hill station, similar to other parts of the Indian subcontinent. Although the extensive development plans were not fully realized, the British influence is still evident in some of the architectural styles and local infrastructure. Sanasar’s status as a potential hill station reflects its historical appeal and strategic importance during the colonial period.',3),
 (19,'Location and Geography:','Girmal Waterfall is situated in the lush green forests of the Dang district, near the Girmal village. It is part of the Shoolpaneshwar Wildlife Sanctuary, which is known for its rich biodiversity and scenic landscapes.
The waterfall is one of the highest in Gujarat, with water cascading down from a height of about 100 feet into a deep gorge.',7),
 (20,'Tribal Heritage','The Dang district is predominantly inhabited by tribal communities, such as the Bhil, Kunbi, and Warli tribes. These communities have a rich cultural heritage and a deep connection with nature.
The area around Girmal Waterfall is often associated with local legends and folklore. The tribes believe that the waterfall and the surrounding forests are home to various deities and spirits. Traditional rituals and festivals are often held near the waterfall to honor these beliefs.',7),
 (21,'Ecological Significance:','Girmal Waterfall plays a crucial role in the local ecosystem. As a major water source in the region, it supports the diverse flora and fauna of the Shoolpaneshwar Wildlife Sanctuary. The waterfall helps maintain the ecological balance by contributing to the river systems that nourish the surrounding vegetation and wildlife. The mist created by the falling water provides a unique microhabitat, fostering the growth of various plant species and supporting wildlife such as birds and insects. This ecological role underscores the importance of preserving natural landmarks like Girmal Waterfall for maintaining regional biodiversity.',7),
 (22,'Location and Geography','Bechtel Beach is situated along the Arabian Sea coast, near the town of Dwarka in the Devbhumi Dwarka district of Gujarat.
The beach is named after the Bechtel Corporation, a large American engineering, procurement, construction, and project management company, which had projects in the region. However, the connection to Bechtel Corporation is more anecdotal and not well-documented in local history.',8),
 (23,'Proximity to Dwarka','Dwarka is one of the four Char Dham pilgrimage sites and holds immense religious significance for Hindus. It is believed to be the kingdom of Lord Krishna, and the Dwarkadhish Temple is a major attraction.
The proximity of Bechtel Beach to Dwarka makes it an attractive spot for pilgrims and tourists looking for a peaceful coastal experience after visiting the holy sites.',8),
 (24,'Indigenous and Early Settlement History','Before European settlers arrived, the region around Bechtel Beach was inhabited by the Ohlone people, a group of Native American tribes. They lived along the coast and relied on the rich marine environment for sustenance.

In the late 18th and early 19th centuries, Spanish explorers and missionaries established missions in the area, including Mission San Francisco de Asís (Mission Dolores) in San Francisco. This period marked significant changes in the local landscape and indigenous ways of life.',8),
 (25,'Ancient Inhabitants','The Kutch region, including areas like Kadiya Dhro, has been inhabited since ancient times. Evidence of early human settlements and activities can be found in the form of rock carvings, petroglyphs, and ancient artifacts.
These ancient inhabitants were likely drawn to the area due to the availability of natural resources and the strategic advantages offered by the rugged terrain.',9),
 (26,'Cultural Significance','Local folklore and traditions often incorporate elements of the natural landscape. Kadiya Dhro, with its unique rock formations, holds a place in the cultural memory of the local communities.
Stories and legends about the origins of the rocks and their significance are part of the oral traditions passed down through generations.',9),
 (27,'Historical Significance','Ancient History: The region around Junagadh has a rich historical background with ancient sites, including the Gir Forest and the Upleta Caves. Historical references to the area often include the Gir Forest’s role in the conservation of wildlife and the significance of ancient settlements and trade routes in Gujarat.

Colonial and Post-Colonial Era: During the colonial period, the Western Ghats, including areas around Junagadh, were explored for their natural resources and biodiversity. In the post-colonial era, there has been a focus on conservation and tourism, leading to increased recognition of sites like Kadiya Dhro.',9),
 (28,'British Colonial Era','Wilson Hill is named after Lord Wilson, who served as the Governor of Bombay (now Mumbai) from 1923 to 1928. During the British colonial period, hill stations were developed as retreats for British officials and their families to escape the heat of the Indian plains.
The establishment of Wilson Hill as a hill station was part of this trend, providing a cool and scenic refuge in the Western Ghats',10),
 (29,'Development as a Hill Station','The development of Wilson Hill as a hill station began during the early 20th century. The British administration recognized the location’s potential due to its pleasant climate, lush greenery, and panoramic views.
Infrastructure such as roads, rest houses, and viewpoints were developed to facilitate the influx of visitors, particularly British officials and their families',10),
 (30,'Location and Geography','Willson Hills is situated in the Gir Forest area, near the town of Sasan Gir in the Junagadh district. The hills are part of the Western Ghats, which are known for their lush greenery, rich biodiversity, and scenic landscapes.

The region''s elevation provides a cooler climate compared to the surrounding plains, making it a favored spot for relaxation and natural exploration.',10),
 (31,'Ancient Kingdoms','Polo Forest has a history that dates back to the 10th century. It was once part of the prosperous kingdom of the Parihar Rajputs. The region was known for its strategic importance and natural defenses provided by the dense forests and hilly terrain.',11),
 (32,'Solanki Dynasty','During the 10th to 15th centuries, the Solanki dynasty, also known as the Chalukyas of Gujarat, played a significant role in the development of the region. The Solankis were great patrons of art, architecture, and culture, and they built numerous temples and structures in the area.',11),
 (33,'Location and Geography','Polo Forest is situated in the Aravalli Hills of the Sabarkantha district, near the town of Vijaynagar. The forest is part of the broader Aravalli Range, which is one of the oldest mountain ranges in India. The terrain is characterized by rugged hills, dense forests, and seasonal streams.

The region’s elevation and natural features contribute to its cool climate and lush vegetation, making it an attractive destination for nature enthusiasts and history buffs alike',11),
 (34,'Architectural Features','Design: The fort is built in a keyhole shape, which is a unique architectural style, and it covers around 40 acres of land.
Defense Mechanisms: The fort includes strong defense features like:
o	Observational Towers: These towers have apertures designed for shooting at the enemies from different angles.
o	Underground Tunnels: These were possibly used for emergency escape routes and secretive military operations.
o	Water Tank: There is a large water tank within the fort premises with a flight of steps leading to it.
o	Bastions: The fort has several bastions which offer a panoramic view of the surroundings, especially the sea.',12),
 (35,'Cultural Significance','Movies and Media: Bekal Fort gained significant attention after being featured in the famous song "Uyire" from the Bollywood movie "Bombay" directed by Mani Ratnam. Since then, it has been a favored location for filmmakers and photographers.
Festivals: Various cultural events and festivals are organized at Bekal Fort, showcasing the local traditions and art forms of Kerala.',12),
 (36,'Historical and Mythological Importance','Jatayu''s Heroism: According to the Ramayana, Jatayu fought bravely against Ravana to protect Sita. The center commemorates this act of heroism and sacrifice, making it a site of cultural and mythological significance.
Legend: It is believed that Jatayu fell on the rocks at Chadayamangalam after being wounded by Ravana, marking the spot as a sacred and historic site.',13),
 (37,'Cultural and Historical Impact','Strategic Importance: The fort’s strategic location on the western coast made it a critical point for defense and trade. Its position allowed control over maritime routes and played a role in the regional power dynamics of the time.
Tourist Attraction: Today, Bekal Fort is a popular tourist destination, known for its historical significance and scenic beauty. It offers insights into the military architecture and history of the region.',12),
 (38,'Vasco da Gama’s Arrival','Kappad Beach is renowned for being the place where Vasco da Gama, the Portuguese explorer, first landed in India on May 20, 1498, along with 170 men. This event marked the beginning of the European colonial era in India and opened the sea route from Europe to India.',14),
 (39,'Historical Monument','There is a stone monument at the beach to commemorate Vasco da Gama’s landing, which is inscribed with the date of his arrival.',14),
 (40,'Gateway of European Merchant','Kappad was to be the gateway of European merchants who flocked in for spice trade, which eventually ended up in Colonial rule.',14),
 (41,'Cultural and Spiritual Significance','Pilgrimage: The site attracts pilgrims and tourists who are interested in Hindu mythology and the Ramayana epic. It offers a spiritual connection to the legendary tale of Jatayu and Lord Rama.
Festivals and Events: The site hosts various cultural events and festivals that celebrate the Ramayana and the story of Jatayu. These events often include performances, storytelling, and reenactments.',13),
 (42,'Educational and Cultural Initiatives','Museums and Exhibits: The site includes exhibits and displays that provide information about the Ramayana, the legend of Jatayu, and the cultural significance of the site.
Conservation Efforts: There are ongoing efforts to preserve the natural environment and promote sustainable tourism practices.',13),
 (43,'Historical Background','Establishment: The original church is believed to have been established in AD 593. The current structure dates back to 1080 AD.
Dedication: The church is dedicated to St. George, a highly revered saint in the Christian tradition.
Renovations: The church has undergone several renovations and expansions over the centuries, blending various architectural styles.',15),
 (44,'Architectural Features','Old Church: The original church structure, preserved as a historical monument, showcases traditional Kerala architecture with intricate wooden carvings and mural paintings.
New Church: The new, larger church building, constructed adjacent to the old church, features a modern architectural style with spacious interiors, stained glass windows, and a grand altar.
Facade and Towers: The church complex boasts a stunning facade with twin bell towers and a central dome, creating an imposing and majestic presence',15),
 (45,'Religious and Cultural Significance','Feast of St. George: The annual feast of St. George, celebrated on April 23, is a major event attracting thousands of pilgrims. The festivities include processions, special prayers, cultural programs, and a grand feast.
Devotional Practices: The church is a center of various devotional practices, including Novenas, Holy Mass, and the Rosary. Devotees often visit the church to seek blessings and fulfill vows',15),
 (46,'Cultural Significance','1.Festivals:
o	Local Festivals: The region celebrates various local festivals with traditional music, dance, and cultural programs, offering visitors a glimpse into the rich cultural heritage of Kerala.
2.Folk Tales and Legends:
o	Kuravan and Kurathi: The story of the tribal couple is deeply embedded in local folklore, adding a layer of cultural and historical significance to the place.',16),
 (47,'Mythological Connection','Legend of Lord Rama: The name “Ramakkalmedu” translates to “Rama''s Stone Mound” in Malayalam. According to local legend, the area is associated with Lord Rama, a major deity in Hindu mythology.
Mythological Story: It is said that Lord Rama, during his exile, stopped at this location and left behind a large stone mound. This stone mound is believed to be a part of the legend surrounding Rama’s journey, although specific details and the exact nature of the legend can vary in different local narratives',16),
 (48,'Historical Context','Colonial Period: During the colonial era, the region was influenced by various European powers, including the British. However, Ramakkalmedu was primarily known for its natural beauty rather than its historical political significance.
Cultural Heritage: The region is part of the broader cultural landscape of Kerala, known for its rich traditions, including folk music, dance forms like Kathakali and Mohiniyattam, and religious festivals.',16),
 (49,'Historical Significance','Anchuthengu: Anchuthengu is a coastal town known for its historical significance and beautiful beach. The name "Anchuthengu" means "Five Coconut Trees," referring to the trees that were once prominent in the area.
Anjengo Fort: The fort is a significant historical landmark built by the British East India Company in the 17th century. It is often referred to as Anjengo Fort or Anchuthengu Fort',17),
 (50,'Architectural Features','Design: The fort is an example of British colonial military architecture, featuring a rectangular layout with high walls and bastions. The design includes typical defensive features such as cannons and watchtowers.
Interior: The fort’s interior includes remnants of old buildings, including a church, and a cemetery, which offer insights into the colonial past',17),
 (51,'Cultural Significance','Trade and Administration: The fort was a hub for trade and administration. It facilitated British control over the region''s trade and contributed to the establishment of British colonial rule in Kerala.
Local Heritage: Anchuthengu is part of the broader cultural landscape of Kerala, which is rich in history, art, and traditions. The area reflects the colonial influence and the region’s historical importance as a trading hub.',17),
 (52,'Ancient Significance','Dhanaulti was developed during the British colonial period as a summer retreat. Its cool climate and scenic beauty made it an attractive location for British officials seeking respite from the heat of the plains.
The area has a rich local heritage with influences from the Garhwali and Kumaoni cultures. It has been inhabited for centuries, and the local traditions and practices reflect the historical depth of the region.',18),
 (53,'Local Culture','The people of Dhanaulti, predominantly Garhwali, have a lifestyle that incorporates traditional practices and customs. The architecture, festivals, and daily life of the local population are deeply rooted in their cultural heritage.
Dhanaulti celebrates various local festivals such as "Holi," "Diwali," and "Dussehra" with traditional ceremonies, music, and dance. The local fairs and festivals often include folk performances and cultural exhibitions.',18),
 (54,'Natural Beauty','Dhanaulti is known for its stunning natural beauty, including lush green forests, panoramic views of the Himalayas, and serene surroundings. The hill station offers breathtaking vistas of the Doon Valley and the distant peaks of the Himalayan range.
The region is ideal for outdoor activities such as trekking, camping, and nature walks. It is also a popular destination for those seeking a peaceful retreat in the lap of nature.',18),
 (55,'Ancient Significance','Lansdowne was established as a cantonment town by the British in 1887. It was named after Lord Lansdowne, the then Viceroy of India. The town was developed as a summer retreat and a military base due to its pleasant climate and strategic location during the British era.
The Garhwal Rifles, a renowned regiment of the Indian Army, was headquartered in Lansdowne, and the military presence has shaped the town''s development and character.',19),
 (56,'Local Culture','The local culture of Lansdowne is influenced by the Garhwali community, known for its traditional lifestyle and customs. The town’s architecture, festivals, and daily life reflect the cultural heritage of the region.
Lansdowne celebrates various local festivals such as “Diwali,” “Holi,” and “Dussehra” with traditional fervor. These festivals often include local music, dance, and cultural events that highlight the region’s rich heritage.',19),
 (57,'Natural Beauty','Lansdowne is known for its picturesque landscapes, including dense oak and pine forests, rolling hills, and serene views of the Himalayan foothills. The town offers a peaceful retreat with numerous opportunities for nature walks and outdoor activities.
Key attractions in Lansdowne include the Tip-in-Top viewpoint, which provides panoramic views of the surrounding hills; the ancient Bhulla Lake, a popular spot for boating; and the Garhwal Rifles Regimental War Memorial, which commemorates the sacrifices of soldiers.',19),
 (58,'Ancient Significance','Chaukori was relatively unknown until it gained popularity in the late 20th century as a quiet retreat. Its strategic location offers stunning views of the Himalayan peaks, making it a favored spot for nature lovers and peace seekers.
The area has been influenced by the Garhwali and Kumaoni cultures. The local traditions and customs reflect a blend of these cultural influences, with a focus on the region’s natural beauty and traditional lifestyle.',20),
 (59,'Local Culture','The inhabitants of Chaukori primarily belong to the Kumaoni community. Their lifestyle is characterized by traditional practices, local festivals, and an agricultural way of life. The architecture in Chaukori reflects local styles with a focus on natural materials.
Chaukori celebrates various local festivals such as “Holi,” “Diwali,” and “Ganga Dussehra” with traditional rituals, music, and dance. These festivals offer a glimpse into the vibrant cultural life of the region.',20),
 (60,'Natural Beauty','Chaukori is renowned for its breathtaking views of the Himalayan peaks, including Nanda Devi, Panchchuli, and the Trishul. The area is surrounded by lush green forests, terraced fields, and pristine landscapes, making it a popular destination for nature enthusiasts.
Key attractions in Chaukori include the serene tea gardens, the breathtaking views from the various viewpoints, and the tranquil environment that offers a respite from the hustle and bustle of city life.',20),
 (61,'Ancient Significance','Nelong Valley holds historical significance due to its proximity to the Indo-Tibetan border. It was historically a strategic location due to its position on ancient trade routes between India and Tibet.
For many years, Nelong Valley was a restricted area due to its sensitive border location. Access was limited to only a few travelers and researchers. It was opened to tourists in recent years, which has gradually increased its popularity.',21),
 (62,'Local Culture','The valley has been influenced by both Garhwali and Tibetan cultures. The local population traditionally includes people from the Garhwali community, known for their unique customs and lifestyle.
The area''s cultural practices reflect a blend of Himalayan traditions, including local festivals and rituals that showcase the region''s heritage.',21),
 (63,'Natural Beauty','Nelong Valley is renowned for its breathtaking natural beauty. It features snow-capped peaks, alpine meadows, and glacial streams. The valley is surrounded by high mountains, including the majestic peaks of the Garhwal Himalayas.
The valley''s high-altitude environment is home to unique flora and fauna. It is a habitat for several rare and endangered species, making it a point of interest for wildlife enthusiasts and nature lovers.',21),
 (64,'Ancient Significance','Harsil has been a part of ancient pilgrimage routes and trade paths in the Garhwal region. Its location along the Bhagirathi River makes it historically significant due to its proximity to sacred rivers and ancient temples.
During the British period, Harsil was noted for its natural beauty and was visited by British officials seeking a serene retreat. The British influence can still be seen in some of the architecture and layout of the area.',22),
 (65,'Local Culture','The local population in Harsil primarily consists of Garhwali people, who follow traditional Himalayan customs and lifestyle. The region is known for its hospitality, and local festivals and fairs reflect the rich cultural heritage of the Garhwal region.
Harsil celebrates various local festivals, including "Dussehra," "Holi," and "Diwali," with traditional ceremonies, music, and dance. The festivals offer insight into the vibrant cultural life of the region.',22),
 (66,'Natural Beauty','Harsil is renowned for its breathtaking natural beauty, including lush green meadows, dense forests, and stunning views of the surrounding Himalayan peaks. The valley is a popular destination for nature lovers and adventure enthusiasts.
Key attractions in Harsil include the serene landscapes along the Bhagirathi River, apple orchards, and the charming local village life. The area is also known for its trekking trails and opportunities for nature walks.',22),
 (67,'Ancient Significance','Chamoli has been a significant location since ancient times, with historical connections to the Garhwal region. It is situated on ancient trade routes that connected the plains with Tibet and the upper Himalayas.
The town played an important role during the British era and in post-independence India. It is known for its involvement in the environmental and social movements of the 20th century, including the Chipko Movement, which was a significant environmental protest aimed at protecting forests from commercial logging.',23),
 (68,'Local Culture','The inhabitants of Chamoli primarily belong to the Garhwali community, known for their traditional Himalayan way of life. The local culture is marked by customs, festivals, and traditions that have been preserved over generations.
Chamoli celebrates various festivals such as “Nanda Devi Mela,” which is a significant religious and cultural event held every 12 years in honor of the goddess Nanda Devi. Other local festivals include “Holi,” “Diwali,” and “Dussehra,” each celebrated with traditional music, dance, and rituals.',23),
 (69,'Natural Beauty','Chamoli is surrounded by stunning natural beauty, including lush green forests, terraced fields, and majestic views of the Himalayan peaks. The town is also close to several prominent trekking routes and natural attractions.
Key attractions in Chamoli include the picturesque surroundings of the town, the sacred temples like the Nanda Devi Temple, and the nearby Valley of Flowers National Park and Hemkund Sahib, which are renowned for their natural beauty and religious significance.',23),
 (70,'Ancient Significance','Devaramane is often associated with Lord Kumara Swamy (Murugan), a popular deity in South India. The name "Devaramane" itself translates to "the house of the gods." It is believed that the hills are blessed by divine presence, and the surrounding forests and streams add to the spiritual ambiance of the place.
The Devaramane Hills are home to an ancient temple dedicated to Lord Kalabhairava, an incarnation of Lord Shiva. The temple is a significant pilgrimage spot for locals, who believe that the deity protects the region and blesses the devotees. The temple''s architecture is traditional, with intricate carvings and a peaceful atmosphere, reflecting the ancient heritage of the area.',24),
 (71,'Cultural Significance','The surrounding villages of Devaramane have preserved their traditional way of life, with agriculture and coffee cultivation being the primary occupations. The locals celebrate various festivals with traditional customs, and the temple plays a central role in these celebrations.
The annual festival at the Kalabhairava Temple is a significant event, attracting devotees from nearby regions. The festival involves traditional rituals, music, and dance, reflecting the rich cultural heritage of the area.',24),
 (72,'Natural Beauty','Devaramane Hills are known for their unspoiled natural beauty, characterized by rolling hills, dense forests, and panoramic views of the surrounding valleys. The area is rich in biodiversity, making it a paradise for nature lovers and trekkers.
The hills are a popular trekking destination, offering trails that lead through dense forests, open grasslands, and rocky terrain. The trek is moderately challenging, making it suitable for both beginners and experienced trekkers. The summit offers stunning views of the Western Ghats and the surrounding coffee plantations.',24),
 (73,'Ancient Significance','Kalasa is often referred to as "Kalasapura," which means "the abode of the sacred pot." The town is named after the mythological pot of nectar, “Amrit,” which is said to have fallen here during a celestial event. According to Hindu mythology, the town was sanctified when the pot of nectar fell on it, making the place holy.
The most prominent landmark in Kalasa is the Kalaseshwara Temple, dedicated to Lord Shiva. The temple is believed to have been established by Sage Agastya and holds significant religious importance. Devotees believe that offering prayers at this temple purifies one’s soul and grants blessings. The architecture of the temple reflects traditional South Indian styles, with intricate carvings and a serene atmosphere.',25),
 (74,'Cultural Significance','Kalasa is associated with the revered sage Agastya, who, according to legend, was sent to the south by the gods to balance the tilt of the earth caused by the gathering of too many deities in the north. Sage Agastya is believed to have performed penance at Kalasa, and the town’s spiritual ambiance is attributed to his presence.
The town is known for its vibrant festivals, particularly the annual Rathotsava (chariot festival), which draws pilgrims from across the region. The festival is a grand event where the deity is taken on a procession through the town, accompanied by music, dance, and traditional rituals.',25),
 (75,'Natural Beauty','Kalasa is surrounded by the Western Ghats, which provide a stunning backdrop of rolling hills, dense forests, and pristine rivers. The town is also close to the Kudremukh National Park, which is rich in biodiversity and offers opportunities for trekking and wildlife exploration.
 Kalasa is in the heart of Karnataka’s coffee country, and the surrounding area is dotted with coffee plantations. Visitors can explore these plantations, learn about coffee cultivation, and enjoy the fresh mountain air.',25),
 (76,'Ancient Significance','Sasihitlu Beach, located near Mangalore in Karnataka, holds historical significance due to its association with the ancient trade routes and maritime history of the region. Historically, the beach was part of a thriving coastal trade network, connecting the Arabian Sea to the inland areas of India. The region around Sasihitlu has been a center for maritime activities since ancient times, serving as a key point for traders and explorers traveling between India and various destinations across the Arabian Sea. Additionally, the beach and its surroundings have been influenced by various dynasties, including the Kadambas and the Vijayanagar Empire, which utilized the coast for trade and strategic purposes.',26),
 (77,'Cultural Significance','Sasihitlu is a small village with a predominantly fishing community. The local culture is deeply connected to the sea, with traditional fishing methods still in practice. The villagers are known for their warm hospitality, and visitors can experience the local way of life by interacting with the community.
The region around Sasihitlu is known for its vibrant festivals, particularly those related to the sea and fishing. Traditional rituals and ceremonies are often performed to appease the sea gods and ensure a bountiful catch. These cultural practices provide insight into the deep-rooted traditions of the coastal communities.',26),
 (78,'Natural Beauty','Sasihitlu Beach is uniquely positioned at the confluence of the Nandini River and the Arabian Sea. This creates a scenic environment with calm waters, sandy shores, and an abundance of natural beauty. The beach is characterized by its white sand, shallow waters, and serene atmosphere, making it a perfect spot for a peaceful retreat.
Unlike the more commercialized beaches in the region, Sasihitlu Beach remains relatively untouched by tourism. This has helped preserve its natural beauty, with clean sands and clear waters. The beach is surrounded by lush greenery, including coconut palms and casuarina trees, adding to its tranquil charm.',26),
 (79,'Ancient Significance','Kemmangundi has a significant royal connection as it was once the summer retreat of Krishnaraja Wodeyar IV, the Maharaja of Mysore. The Maharaja was known for his love of nature and is credited with developing Kemmangundi into a hill station. He was so enchanted by the beauty of the place that he often visited to escape the summer heat of the plains.
The Maharaja established the famous “Raj Bhavan,” a charming guesthouse, and laid out beautiful gardens, known as the "Rock Garden," which are still well-maintained and open to the public. The garden features manicured lawns, colorful flower beds, and stunning views of the surrounding hills.',27),
 (80,'Cultural Significance','The surrounding areas of Kemmangundi are inhabited by local communities who have preserved their traditional way of life. Agriculture is the main occupation, and the locals celebrate various festivals with traditional music, dance, and rituals.',27),
 (81,'Natural Beauty','One of the most famous spots in Kemmangundi is Z Point, a vantage point that offers breathtaking views of the Western Ghats, especially at sunrise and sunset. The trek to Z Point is a popular activity, leading through a narrow, rocky path amidst dense vegetation.
Kemmangundi is also known for Hebbe Falls, a spectacular waterfall that drops from a height of about 168 meters (551 feet). The waterfall is located within a coffee estate and is accessible via a short trek or by hiring a jeep. The falls are divided into two stages, Dodda Hebbe (Big Falls) and Chikka Hebbe (Small Falls), and are surrounded by dense forests.
 The region is also known for its horticultural activities, with numerous coffee estates, fruit orchards, and gardens dotting the landscape. Visitors can explore these estates and learn about the cultivation of coffee, spices, and other crops that thrive in the region’s climate.',27),
 (82,'Ancient Significance','Honnemaradu is situated on the banks of the Sharavathi River, which is one of the major rivers in Karnataka. The area became more prominent with the construction of the Linganamakki Dam in 1964, which was built to support the Sharavathi Hydroelectric Project, one of the largest power generation projects in the state.
The creation of the reservoir led to the submergence of several villages and vast tracts of forest land, transforming the region into a large, tranquil lake with numerous small islands. Honnemaradu was one such village that became part of this vast backwater area, emerging as a serene spot for nature lovers.',28),
 (83,'Cultural Significance','The area around Honnemaradu is inhabited by local communities who have traditionally depended on the river and forest for their livelihood. With the rise of ecotourism, there has been a shift towards tourism-related activities, providing new opportunities for the local population.
Organizations and eco-groups in Honnemaradu emphasize sustainable tourism and environmental conservation. Visitors are encouraged to minimize their ecological footprint, respect the local culture, and contribute to the preservation of the area''s natural beauty.',28),
 (84,'Natural Beauty','The name "Honnemaradu" is derived from the mesmerizing golden hues that reflect off the waters during sunrise and sunset, creating a magical atmosphere that has enchanted visitors for decades.
Honnemaradu is particularly known for its adventure sports, especially non-motorized water activities like kayaking, canoeing, windsurfing, and coracle rides. The calm and expansive waters of the reservoir make it an ideal spot for these activities. Additionally, the area is perfect for camping, with opportunities to sleep under the stars and experience the wilderness up close.',28),
 (85,'Ancient Significance','Kavaledurga Fort was originally built in the 9th century by the Nayakas of Keladi, a dynasty that played a crucial role in the history of Karnataka. The Keladi Nayakas were initially feudatories of the Vijayanagara Empire but later became independent rulers, establishing their capital at Keladi and subsequently at Ikkeri.
The fort was strategically located to protect the kingdom from invasions and served as a military stronghold. Its elevated position made it difficult to attack, and it was equipped with robust fortifications and watchtowers.',29),
 (86,'Cultural Heritage','Kavaledurga Fort houses several ancient temples, including the Lakshmi Narayana Temple, dedicated to Lord Vishnu, and the Shantaleshwara Temple, dedicated to Lord Shiva. These temples are significant not only for their religious importance but also for their architectural beauty. The temples are built in the typical Hoysala style, with intricate carvings and sculptures.
  The fort was also used as a retreat by the rulers and their families for spiritual practices. The presence of temples and the serene environment of the fort made it an ideal location for religious and spiritual activities.
The fort is recognized as a protected monument by the Archaeological Survey of India (ASI) and is considered an important cultural heritage site in Karnataka.',29),
 (87,'Modern-Day Significance','Kavaledurga Fort is a popular trekking destination, attracting history enthusiasts, trekkers, and nature lovers. The trek to the fort is challenging but rewarding, offering breathtaking views of the Western Ghats and a chance to explore the ruins of the fort.',29),
 (88,'Ancient Significance','Hatu Peak is steeped in mythology and is believed to be the site of the Hatu Mata temple, dedicated to the goddess Hatu Mata, a local deity. The peak is associated with the Pandavas from the Mahabharata, who are believed to have spent time in the area during their exile. The temple’s wooden architecture reflects the traditional Himachali style, with intricate carvings and designs.',30),
 (89,'Cultural Heritage','The peak and its temple are significant in the local culture, with the Hatu Mata temple being a site of pilgrimage, particularly during Navratras when devotees from surrounding areas gather to offer prayers. The temple''s architecture and the surrounding local customs offer insights into the rich cultural heritage of the Himachal region.',30),
 (90,'Natural Significance','At an elevation of about 3,400 meters, Hatu Peak offers breathtaking views of the surrounding Himalayan ranges, dense forests of deodar, and apple orchards. The peak is surrounded by a pristine environment, making it a popular destination for nature lovers and trekkers seeking the tranquility of the mountains. The natural beauty of the region, with its rich biodiversity and scenic vistas, contributes significantly to the ecological significance of the area.',30),
 (91,'Ancient Significance','Chitkul has historically been a crucial stop on the ancient trade route connecting India with Tibet. The village''s strategic location made it an important hub for trade and cultural exchanges between the two regions.
Due to its proximity to the Indo-Tibetan border, Chitkul has always had strategic significance. It has played a role in the geopolitical landscape of the region, particularly during times of conflict and change.',31),
 (92,'Local Culture','The residents of Chitkul primarily belong to the Kinnauri community, known for their distinct cultural practices, traditional wooden houses, and vibrant festivals. The local architecture and way of life are deeply rooted in centuries-old traditions.
Chitkul celebrates various local festivals with traditional fervor. The most notable is the “Chitkul Festival” which features cultural performances, traditional dances, and local rituals, reflecting the rich cultural heritage of the region.',31),
 (93,'Natural Beauty','Chitkul is renowned for its breathtaking natural beauty, including snow-capped peaks, lush meadows, and the Baspa River. The village offers spectacular views of the surrounding Himalayan ranges and is a popular destination for nature lovers and adventure enthusiasts.',31),
 (94,'Ancient Significance','Pabbar Valley has historically been a part of trade routes connecting India with Tibet. The valley''s strategic location made it a crucial point for cultural and economic exchanges between the two regions.
The valley has been influenced by various rulers and empires over the centuries, including the Kullu and Chamba states. The region’s history is rich with tales of trade, conquest, and cultural interactions.',32),
 (95,'Local Culture','The inhabitants of Pabbar Valley, predominantly belonging to the Kinnauri and Rajput communities, have a distinct lifestyle characterized by traditional wooden houses, local festivals, and a vibrant cultural heritage. The valley’s isolation has helped preserve its unique cultural practices.
The valley celebrates several traditional festivals and fairs, such as the “Faguli” festival, which marks the end of winter and the arrival of spring. These festivals showcase the rich cultural tapestry of the region, including traditional music, dance, and local rituals.',32),
 (96,'Natural Beauty','Pabbar Valley is renowned for its stunning natural beauty, including lush green meadows, dense forests, and snow-capped peaks. The valley is crisscrossed by the Pabbar River, which adds to its picturesque charm. The area offers numerous trekking and hiking opportunities.
The valley is less frequented by tourists compared to other parts of Himachal Pradesh, making it a pristine destination for those seeking solitude and natural beauty.',32),
 (97,'Ancient Significance','Shangarh, located in the Sainj Valley of Himachal Pradesh, is a place of profound ancient significance. It''s believed to have connections to the Mahabharata era. According to local legends, Shangarh was part of the Pandavas'' journey during their exile. The vast meadow in Shangarh, known as the "Shangarh meadow," is said to have been created by the Pandavas, who cleared the area to build a shelter. Additionally, the region is home to ancient temples, such as the Shangchul Mahadev Temple, which is dedicated to Lord Shiva and holds great spiritual importance in the local community.',33),
 (98,'Local Culture','The inhabitants of Shangarh are predominantly from the Kinnauri and Rajput communities. They maintain traditional lifestyles characterized by wooden houses, local crafts, and a strong connection to their heritage.
Shangarh celebrates several local festivals and rituals that reflect the cultural heritage of the region. Festivals such as “Chaitra” and “Dussehra” are celebrated with traditional fervor, featuring folk music, dance, and local customs',33),
 (99,'Natural Beauty','Shangarh is renowned for its stunning natural beauty, including terraced fields, lush green meadows, and snow-capped peaks. The village is set against the backdrop of the Sainj River, adding to its picturesque charm.
The village offers various opportunities for trekking, nature walks, and outdoor activities. Its relatively untouched environment provides a peaceful retreat from the more tourist-heavy areas of Himachal Pradesh.',33),
 (100,'Ancient Significance','While the village itself is tranquil and remote, it is believed to be part of the ancient trade routes that connected the Himalayan regions. The area around Shoja is dotted with temples and shrines that reflect the deep spiritual roots of the region. One such temple is the Raghupur Fort, which is believed to have historical ties to the rulers of the region, though much of its history is shrouded in mystery. The fort''s ruins indicate that Shoja was strategically important in ancient times, possibly serving as a lookout point or a defensive structure. The village, with its pristine surroundings and traditional Himachali architecture, preserves the essence of ancient Himachali culture and spirituality, making it a place of quiet historical importance',34),
 (101,'Local Culture','The residents of Shoja maintain a traditional lifestyle characterized by wooden houses, local crafts, and a strong connection to their cultural heritage. The village''s architecture and way of life are reflective of the historical influences of the region.
Shoja celebrates several local festivals and customs, which are an integral part of the community’s cultural life. Festivals such as “Dussehra” and “Losar” are celebrated with traditional rituals, music, and dance, highlighting the cultural richness of the region.',34),
 (102,'Natural Beauty','Shoja is renowned for its breathtaking natural beauty, including dense forests, terraced fields, and panoramic views of the Himalayan ranges. The village is surrounded by lush greenery and offers numerous opportunities for outdoor activities such as trekking and nature walks.
The village''s pristine environment makes it an ideal destination for eco-tourism and adventure enthusiasts seeking a tranquil retreat away from the more crowded tourist spots.',34),
 (103,'Ancient Significance','Barot Valley was originally developed by the British as a hydroelectric power project in the early 20th century. The Uhl Hydroelectric Project was one of the earliest hydroelectric projects in India, and Barot served as a base for this venture.
The valley has been inhabited for centuries and has historically been a part of the trade routes connecting India with Tibet. The region’s isolation has preserved many of its traditional practices and way of life.',35),
 (104,'Local Culture','The inhabitants of Barot Valley primarily belong to the Gaddi community, known for their traditional pastoral lifestyle. The local architecture and customs reflect the cultural influences of the broader Kangra and Mandi regions.
Barot celebrates various local festivals and fairs, including traditional celebrations like “Faguli” and “Dussehra,” which are marked by local music, dance, and rituals.',35),
 (105,'Natural Beauty','Barot Valley is known for its stunning natural beauty, including lush green meadows, dense forests, and scenic river views. The valley is surrounded by the Dhauladhar and Pir Panjal ranges, offering breathtaking vistas.
The valley is a haven for nature lovers and adventure enthusiasts. It offers opportunities for trekking, fishing, camping, and exploring the untouched beauty of the region.',35),
 (106,'Ancient Significance','Khejarla Fort, constructed in the 15th century by Rao Maldev, is a testament to the strategic and architectural prowess of the Rajput rulers. Originally built to fortify the region and assert dominance, the fort''s strategic location and robust design reflect its historical importance in defending against invasions. Over time, it has witnessed shifts in power and ownership, mirroring the broader historical changes in the region.',36),
 (107,'Cultural Significance','The fort embodies the opulent lifestyle and grandeur of the Rajput era. Its architectural elements, including intricate carvings, frescoes, and sprawling courtyards, are representative of Rajput and Mughal architectural styles. The fort''s conversion into a heritage hotel in recent years has allowed visitors to experience the cultural richness and royal heritage of Rajasthan firsthand',36),
 (108,'Natural Significance','Nestled in the picturesque landscape of Rajasthan, Khejarla Fort is surrounded by the arid beauty of the desert. The fort''s elevated position offers stunning views of the surrounding countryside, highlighting the stark yet captivating natural beauty of the region. The landscape around the fort includes rugged terrain and sparse vegetation, typical of Rajasthan''s desert environment.',36),
 (109,'Ancient Significance','The Thar Desert, also known as the Great Indian Desert, has been a critical area in the history of Rajasthan. It has long served as a natural barrier and a crossroads for trade and cultural exchanges between India, Central Asia, and the Middle East. Historical trade routes like the Silk Road passed through this region, influencing the local economy and culture. The desert''s harsh conditions have shaped the resilience and adaptability of the communities that have thrived there for centuries.',37),
 (110,'Cultural Significance','The Thar Desert is deeply intertwined with the cultural heritage of Rajasthan. It is renowned for its vibrant folk traditions, including music, dance, and festivals. The desert’s communities celebrate traditional festivals such as the Desert Festival in Jaisalmer, which showcases local arts, crafts, and performances. The unique lifestyle, clothing, and cuisine of the desert people, including the colorful turbans and traditional Rajasthani dishes, reflect the rich cultural tapestry of the region.',37),
 (111,'Natural Significance','The Thar Desert''s landscape is characterized by vast stretches of sand dunes, arid plains, and sparse vegetation. It is home to a range of unique flora and fauna adapted to the harsh desert conditions, such as the desert fox, blackbuck antelope, and various species of reptiles and birds. The desert''s natural beauty is highlighted by its mesmerizing sunsets, star-studded skies, and serene sand dunes, making it a captivating destination for nature enthusiasts.',37),
 (112,'Ancient Significance','Khimsar village is renowned for its historical connections, primarily through the Khimsar Fort, which dates back to the 16th century. Built by Rao Karamsi, a Rajput ruler of the Nagaur princely state, the fort played a crucial role in regional politics and defense. It reflects the strategic importance of the area during the era of Rajput dominance and its military significance.',38),
 (113,'Cultural Significance','The village is steeped in traditional Rajasthani culture, reflected in its vibrant festivals, crafts, and lifestyle. The Khimsar Fort has been transformed into a heritage hotel, offering visitors a chance to experience royal hospitality and traditional Rajasthani cuisine. The village''s cultural richness is also highlighted through local crafts and folk music, which continue to thrive and attract cultural tourism.',38),
 (114,'Natural Significance','Khimsar is situated in a picturesque desert landscape, showcasing the arid beauty of Rajasthan. The surrounding area features scenic sand dunes and sparse vegetation typical of the Thar Desert. The natural environment provides opportunities for desert safaris and birdwatching, as the region is home to various desert-dwelling flora and fauna.',38),
 (115,'Ancient Significance','Sambhar Lake is the largest saline lake in India and has been a significant site since ancient times. It is mentioned in various historical texts, including the Mahabharata. The lake has been a crucial source of salt for centuries, influencing the local economy and trade. The surrounding region has a long history of salt production, with traditional methods still in use today.',39),
 (116,'Cultural Significance','Sambhar Lake plays a vital role in the local culture of Rajasthan. It is intertwined with traditional practices and rituals, particularly those related to salt harvesting. The lake and its surroundings are also known for their unique folk traditions, including local festivals and ceremonies that celebrate the region’s heritage. The area attracts numerous visitors for its cultural and religious significance.',39),
 (117,'Natural Significance','The lake is an important ecological site, providing habitat for various migratory birds and wildlife. It is a key stopover point for migratory birds traveling along the Central Asian flyway. The lake''s saline waters and surrounding landscape create a unique natural environment that supports a variety of flora and fauna adapted to arid conditions. The natural beauty of the lake, especially during sunrise and sunset, is a highlight for nature enthusiasts and photographers.',39),
 (118,'Ancient Significance','Banswara, often referred to as the "City of Hundred Islands," has a rich historical background. Founded in the 16th century by Maharawal Jagmal Singh, a Rajput ruler, the town served as an important regional center during the medieval period. It played a role in regional politics and military history, with several historical structures and monuments reflecting its past prominence.',40),
 (119,'Cultural Significance','The town is renowned for its vibrant culture and traditions. Banswara is known for its unique blend of Rajput and tribal cultures, which is reflected in its festivals, art, and crafts. The local communities celebrate various traditional festivals, such as the Mewar Festival and the Banswara Fair, showcasing traditional Rajasthani music, dance, and crafts. The town''s cultural heritage includes intricate textiles and traditional artwork, contributing to its distinct cultural identity.',40),
 (120,'Natural Significance','Banswara is surrounded by lush landscapes and natural beauty, making it a picturesque destination. The region is characterized by rolling hills, serene lakes, and dense forests. Key natural attractions include the Mahi Dam and the tranquil surroundings of the area, which are ideal for nature enthusiasts and those seeking a peaceful retreat. The natural environment also supports diverse flora and fauna, adding to the area''s ecological significance.',40),
 (121,'Ancient Significance','Kumbhalgarh Fort, a UNESCO World Heritage Site, is a formidable 15th-century fortification built by Rana Kumbha, a prominent Rajput ruler of the Mewar dynasty. It served as a key defensive stronghold and a retreat for the Mewar royal family during times of conflict. The fort’s impressive walls and strategic location highlight its importance in Rajput military history and its role in protecting the region from invasions.',41),
 (122,'Cultural Significance','The fort embodies the grandeur of Rajput architecture and the rich cultural heritage of the Mewar region. Its construction reflects the skill and artistry of Rajput builders, with intricate carvings, temples, and palaces within its walls. Kumbhalgarh Fort is also associated with various legends and historical events, which contribute to its cultural importance and make it a symbol of Rajput pride and resilience.',41),
 (123,'Natural Significance','Set against the backdrop of the Aravalli Range, Kumbhalgarh Fort is surrounded by stunning natural landscapes, including dense forests and rugged hills. The fort''s location provides breathtaking views of the surrounding terrain, enhancing its natural appeal. The fort’s walls, extending over 36 kilometers, are one of the longest in the world and blend harmoniously with the natural environment, offering a unique combination of history and nature.',41),
 (124,'Ancient Significance','The Salaulim Dam, located in the Sanguem district of Goa, is historically significant as it was constructed in the 1970s and early 1980s as part of the Salaulim Irrigation Project. The dam was built to address water scarcity in the region, playing a crucial role in transforming the agricultural landscape by providing a reliable source of water for irrigation, drinking, and industrial use. It represents a major infrastructural achievement in Goa’s history, showcasing the state''s efforts toward sustainable water management and development.',42),
 (125,'Cultural Significance','The dam has cultural importance to the local communities, as it has significantly impacted their way of life, particularly the agrarian societies dependent on consistent water supply. The dam''s construction led to the relocation of several villages, and it stands as a testament to the local communities'' adaptation and resilience. Additionally, the surrounding area is culturally significant, with nearby ancient temples and villages that reflect Goa’s rich heritage and traditions.',42),
 (126,'Natural Significance','Nestled amidst the Western Ghats, the Salaulim Dam is surrounded by lush greenery and offers stunning views of the reservoir and its catchment area. It supports a diverse range of flora and fauna, making it an important ecological zone. The dam''s reservoir is home to several species of fish and birds, contributing to local biodiversity. The serene surroundings and scenic beauty have made it a popular spot for nature lovers and tourists, blending human engineering with natural landscapes.',42),
 (127,'Ancient Significance','Cola Beach, a hidden gem in South Goa, carries historical importance due to its relatively undisturbed state compared to other popular beaches in Goa. While it may not be tied to a specific historical event, the beach represents the less-explored side of Goa, reminiscent of its past before tourism became widespread. The area surrounding Cola Beach retains traces of traditional Goan fishing communities, reflecting the way of life that has persisted for generations along the Goan coast.',43),
 (128,'Cultural Significance','Culturally, Cola Beach provides insight into the traditional Goan lifestyle, where local communities continue to practice fishing, coconut farming, and small-scale agriculture. The beach area is also reflective of the local Goan culture, with its laid-back atmosphere and simplicity, attracting those who seek a more authentic experience away from the commercialized tourist spots. The rustic shacks, local seafood, and occasional cultural events give visitors a taste of the quiet, traditional Goan way of life.',43),
 (129,'Natural Significance','Cola Beach is known for its stunning natural beauty, characterized by its golden sands, clear blue waters, and a unique freshwater lagoon formed by the flowing river meeting the sea. The beach is surrounded by coconut groves and lush green hills, offering a serene and secluded environment for visitors. The natural landscape of Cola Beach provides a habitat for a variety of coastal flora and fauna, making it a haven for birdwatchers and nature enthusiasts. Its relatively untouched environment makes it ideal for relaxation, meditation, and nature walks, allowing visitors to experience Goa''s natural beauty in its purest form.',43),
 (130,'Ancient Significance','Cabo de Rama Beach is located near the historic Cabo de Rama Fort, which has significant historical importance in Goa. The fort, built by the Portuguese in the 16th century, played a strategic role in defending the region against invaders. The beach, while not directly historical, is closely associated with the fort, representing a period of colonial influence and military significance in Goa''s history.',44),
 (131,'Cultural Significance','The beach area reflects the traditional Goan way of life, influenced by its proximity to the historic fort and the local fishing communities. The presence of local fishermen and traditional fishing boats adds to the cultural atmosphere of the beach. The nearby fort also contributes to the cultural landscape, attracting visitors interested in Goa’s colonial past and traditional coastal lifestyles.',44),
 (132,'Natural Significance','Cabo de Rama Beach is renowned for its scenic beauty, featuring golden sands and clear blue waters framed by rocky outcrops and lush greenery. The natural landscape around the beach includes rugged cliffs and panoramic views of the Arabian Sea, offering a tranquil and picturesque setting. The beach’s relatively untouched environment makes it a peaceful retreat for nature lovers and provides a great spot for relaxation, swimming, and enjoying the natural surroundings.',44),
 (133,'Mythical  Significance','Devil’s Finger Cave, located in Goa, is notable for its intriguing and somewhat mysterious history. It is named after a prominent rock formation that resembles a finger, and there are various local legends and stories associated with the cave. While it may not be linked to major historical events, the cave’s name and lore contribute to its historical allure, reflecting the region’s rich tapestry of myths and folklore.',45),
 (134,'Cultural Significance','The cave holds cultural importance due to the local legends and traditions associated with it. Stories of the cave being a site for ancient rituals or supernatural occurrences are passed down through generations. It also represents the way local communities integrate natural landmarks into their cultural narratives and folklore, highlighting the blend of nature and cultural storytelling in Goa.',45),
 (135,'Natural Significance','Devil’s Finger Cave is renowned for its striking geological formations and natural beauty. The cave features impressive rock formations, including the eponymous "Devil’s Finger," which attracts visitors and geologists interested in the area''s natural landscape. The surrounding environment, with lush vegetation and rugged terrain, adds to the cave’s appeal as a natural attraction. Its unique geological features and serene setting make it a fascinating site for nature enthusiasts and those interested in exploring Goa’s natural heritage.',45),
 (136,'Colonial History','Like much of Goa, Sanguem was under Portuguese rule for several centuries. The village bears marks of this colonial past, with some old Portuguese-style houses and churches still standing. The influence of the Portuguese is also reflected in the local customs, cuisine, and architecture.
Historically, Sanguem was an important agricultural area, known for its rice paddies, spice plantations, and betel nut cultivation. The region’s fertile land made it a significant contributor to Goa''s agrarian economy during the colonial period.',46),
 (137,'Cultural Heritage','Sanguem is less urbanized compared to other parts of Goa, which has allowed it to preserve its traditional Goan lifestyle. The village is known for its warm hospitality, vibrant festivals, and a slow-paced way of life that is deeply connected to the land and nature.
The village is home to several temples and churches that reflect the religious diversity of the area. These sites often serve as cultural hubs where local traditions and community events are celebrated.',46),
 (138,'Natural Significance','The natural environment of Sanguem is characterized by its lush landscapes, rolling hills, and proximity to the Western Ghats. The surrounding area is known for its scenic beauty, including lush green fields and rivers, which support local agriculture and contribute to the village’s serene setting. The natural landscape also offers opportunities for eco-tourism and outdoor activities, making Sanguem a gateway to exploring the verdant and diverse ecosystems of South Goa.',46),
 (139,'Ancient Significance','Butterfly Beach was largely unknown for many years due to its remote location, accessible only by boat or a challenging trek through the forest. Its relative inaccessibility kept it hidden from the typical tourist routes, preserving its pristine condition.
The beach earned its name from the numerous butterflies that can be seen fluttering around the area, especially during the morning hours. The beach is surrounded by dense forest, which provides a natural habitat for these colorful insects.',46),
 (140,'Cultural Significance','The cultural significance of Butterfly Beach lies in its unique charm and the local folklore associated with it. The beach is often seen as a hidden gem, symbolizing the untouched and natural beauty of Goa. Local legends and stories about the beach add to its mystique and appeal. It is a favorite among those seeking a tranquil escape and a glimpse into the less commercialized aspects of Goan life.',47),
 (141,'Natural Beauty','Butterfly Beach is renowned for its stunning natural beauty, characterized by its crescent-shaped shoreline, clear blue waters, and surrounding lush greenery. The beach is named for the butterflies that are often seen fluttering around the area, adding to its picturesque and serene environment. The beach is also known for its gentle waves and relatively untouched landscape, which make it an ideal spot for relaxation, swimming, and enjoying the natural surroundings. The rugged terrain and the limited access to the beach help preserve its pristine condition, making it a pristine example of Goa’s natural coastal beauty.',47),
 (142,'Ancient Significance','Mawlynnong, a village in Meghalaya, is known for its rich heritage and its role in the history of the Khasi Hills. The village has been an important settlement in the Khasi region for centuries, maintaining traditional practices and customs that reflect the history of the Khasi people. It is noted for its preservation of indigenous cultural traditions and its historical role as a key community in the region.',48),
 (143,'Cultural Significance','Mawlynnong is celebrated for its vibrant cultural heritage and community-driven practices. Known as "Asia''s Cleanest Village," it exemplifies the strong community spirit and commitment to maintaining traditional values. The village is deeply rooted in Khasi traditions, with unique practices such as the traditional "living root bridges" and the annual cultural festivals that showcase local music, dance, and handicrafts. The village’s emphasis on environmental stewardship and traditional practices underscores its cultural richness.',48),
 (144,'Natural Significance','The natural beauty of Mawlynnong is remarkable, characterized by lush greenery, rolling hills, and pristine landscapes. The village is situated in the East Khasi Hills, offering breathtaking views of the surrounding forests and valleys. It is renowned for its unique living root bridges, which are natural bridges made from the roots of rubber trees, and the nearby scenic viewpoints like the Sky View, which provides panoramic vistas of the landscape. The area''s biodiversity and commitment to conservation make it a noteworthy example of sustainable living in harmony with nature.',48),
 (145,'Ancient Significance','The Mawphlang Sacred Forest, located in Meghalaya, is an ancient forest that has been preserved by the Khasi community for centuries. It holds historical importance as it has been a site for traditional rituals and spiritual practices of the Khasi people. The forest is believed to have been protected due to its sacred status, reflecting the long-standing cultural reverence for nature within the Khasi tradition.',49),
 (146,'Cultural Significance','The forest is deeply intertwined with Khasi culture and religion. It is considered a sacred space where various rites and ceremonies are performed, including offerings to ancestral spirits. The local Khasi community holds the forest in high esteem, and traditional practices are observed to maintain its sanctity. The forest''s preservation underscores the Khasi people''s commitment to maintaining their cultural heritage and spiritual connection with nature.',49),
 (147,'Natural Significance','Mawphlang Sacred Forest is renowned for its rich biodiversity and pristine environment. It is home to a variety of flora and fauna, including rare and endemic species. The forest is characterized by its dense vegetation, ancient trees, and a natural ecosystem that has remained largely undisturbed. Its lush green landscape and ecological importance make it a valuable site for conservation and an exemplary model of traditional environmental stewardship.',49),
 (148,'Ancient Significance','Ranikor, a small town in Meghalaya, holds historical importance as a strategic trading and administrative center during the colonial era. It was known for its role in regional trade routes and its interactions with various historical rulers and colonial powers. The town’s history is reflected in its colonial-era architecture and historical landmarks.',50),
 (149,'Cultural Significance','Ranikor is notable for its vibrant local culture and traditions. The town is predominantly inhabited by the Khasi community, and it showcases traditional Khasi customs, festivals, and practices. The local culture is deeply rooted in indigenous beliefs and practices, with the town hosting various cultural events and festivals that celebrate Khasi heritage.',50),
 (150,'Natural Significance','The natural beauty of Ranikor is characterized by its lush landscapes, scenic river valleys, and verdant surroundings. The town is situated along the banks of the Ranikor River, which adds to its natural charm. The surrounding areas offer opportunities for eco-tourism, with dense forests and picturesque views providing a serene environment for nature enthusiasts and travelers.',50),
 (151,'Ancient Significance','The Garden of Caves, located in Meghalaya, is an area rich in historical and archaeological significance. The caves are believed to have been used by ancient civilizations and local tribes for various purposes, including habitation and religious ceremonies. These caves provide valuable insights into the region''s early human settlements and their ways of life.',51),
 (152,'Cultural Significance','The Garden of Caves holds cultural importance as it reflects the traditions and practices of the indigenous Khasi and Jaintia tribes. The caves are linked to various local myths, legends, and cultural narratives, making them an integral part of the region''s cultural heritage. They are often associated with traditional stories and local folklore, which are passed down through generations.',51),
 (153,'Natural Significance','The Garden of Caves is notable for its stunning natural formations, including limestone caves, stalactites, and stalagmites. The area showcases unique geological features formed over millennia, creating a mesmerizing underground landscape. The caves, surrounded by lush greenery and pristine environments, offer a glimpse into the natural beauty and geological diversity of Meghalaya.',51),
 (154,'Ancient Significance','The Dawki River, also known as the Umngot River, holds historical importance as a key trade route and border river between India and Bangladesh. Historically, it has facilitated trade and cultural exchange between the two regions. The river''s strategic location has made it a significant landmark in the geopolitical and economic history of the area.',52),
 (155,'Cultural Significance','The Dawki River is deeply embedded in the local culture and traditions of the Khasi community. It is associated with various local festivals and rituals, reflecting the river’s role in the cultural practices of the indigenous people. The river is also celebrated in local folklore and traditions, symbolizing life and prosperity for the communities residing along its banks.',52),
 (156,'Natural Significance','The Dawki River is renowned for its crystal-clear waters, which provide a unique visual experience where boats appear to float on the riverbed. This clarity is a rare natural phenomenon that enhances the river''s aesthetic appeal. The surrounding landscape, characterized by lush greenery and rolling hills, adds to the river''s natural beauty, making it a popular destination for eco-tourism and outdoor activities. The river''s pristine environment and the biodiversity of the area contribute significantly to the region’s ecological balance.',52),
 (157,'Ancient Significance','Laitkynsew, a village in Meghalaya, holds historical importance due to its traditional role in the region’s socio-political landscape. The village has been a part of the Khasi Hills'' historical narrative, reflecting the area''s historical interactions and regional developments over time. Its historical significance is also tied to the broader history of the Khasi people and their settlement patterns.',53),
 (158,'Cultural Significance','Laitkynsew is culturally significant as it represents the rich traditions and customs of the Khasi community. The village is known for preserving traditional Khasi practices and festivals. Local customs, including traditional ceremonies, folklore, and festivals, are actively maintained, offering visitors a glimpse into the cultural heritage of the Khasi people. The village’s cultural landscape is characterized by its adherence to traditional values and practices.',53),
 (159,'Natural Significance','The natural beauty of Laitkynsew is highlighted by its lush landscapes, rolling hills, and verdant forests. The village is situated in the picturesque Khasi Hills, providing stunning views and a serene environment. The natural environment supports a diverse range of flora and fauna, making it a haven for nature lovers and eco-tourists. The surrounding hills and natural features contribute to the village’s appeal as a destination for exploring Meghalaya’s scenic beauty.',53),
 (160,'Historical Significance','Meghamalai has a relatively recent history compared to other regions in Tamil Nadu. The area was developed as a plantation region during British colonial rule, with tea, coffee, and cardamom estates established by the British planters in the early 20th century. The estates are still operational today and contribute to the local economy. The presence of colonial-era bungalows and remnants of old British infrastructure hints at its colonial past, making it a place of historical interest, especially for those fascinated by the colonial heritage of India.',54),
 (161,'Cultural Significance','Meghamalai is home to several indigenous communities and small villages that offer a glimpse into the traditional way of life in the hills. The local culture is influenced by a mix of Tamil and tribal heritage. The communities practice agriculture, tea plantation work, and local crafts. Visitors can experience the local culture through interactions with the residents, who are known for their hospitality. The region also hosts a few small temples, reflecting the spiritual and cultural traditions of the local people.',54),
 (162,'Natural Significance','The natural significance of Meghamalai lies in its pristine environment and diverse ecosystems. The area is part of the Western Ghats, a UNESCO World Heritage Site, recognized for its exceptional biodiversity. Meghamalai is home to various species of flora and fauna, including several endemic and endangered species. The landscape is characterized by rolling hills, mist-covered forests, tea gardens, and waterfalls, creating a unique habitat for wildlife such as elephants, leopards, gaur, and numerous bird species. The region''s natural beauty, combined with its pleasant climate, makes it a haven for nature enthusiasts, bird watchers, and trekkers.',54),
 (163,'Historical Significance','Historically, the Javadi Hills have served as a natural barrier and a refuge for local tribes and communities. The hills were part of the territories ruled by various South Indian dynasties, such as the Cholas, Pandyas, and Pallavas. The region was sparsely populated due to its rugged terrain and dense forests. During the British colonial period, the hills were relatively unexplored, with only a few settlements established for forestry and plantation activities. The Javadi Hills also hold archaeological significance, with ancient temples and structures that date back several centuries.',55),
 (164,'Cultural Significance','The Javadi Hills are home to various indigenous communities, primarily the Malayali tribe, who have lived in harmony with nature for generations. These communities have a unique cultural identity, marked by their traditional customs, rituals, and handicrafts. The local tribes primarily engage in agriculture, honey collection, and weaving, maintaining a close connection with the forest ecosystem. Visitors to the Javadi Hills can experience the local culture by interacting with these communities, exploring their villages, and learning about their sustainable practices and way of life.',55),
 (165,'Natural Significance','The natural beauty of the Javadi Hills is highlighted by its dense forests, abundant wildlife, and diverse flora. The hills are covered with a mix of tropical deciduous and evergreen forests, home to a variety of plant species, including medicinal herbs and rare orchids. The area is also rich in wildlife, with species such as deer, wild boar, leopards, and numerous bird species inhabiting the forests. The hills offer scenic views, waterfalls, streams, and trekking trails, making them a haven for nature enthusiasts, bird watchers, and adventure seekers.',55),
 (166,'Historical Significance','Valparai’s history is closely linked with the colonial period, particularly with British planters who developed the area for tea and coffee cultivation in the 19th century. The hill station was developed in the early 20th century by British entrepreneur Sir Carver Marsh, who was instrumental in establishing the tea and coffee estates that dominate the landscape today. The colonial influence is still evident in Valparai, with its old bungalows, tea factories, and estates that carry a legacy of the British plantation era. The region played a significant role in the plantation economy of South India during British rule.',56),
 (167,'Cultural Significance','Valparai is home to a diverse population, including the indigenous tribal communities such as the Malayali and Irula tribes, as well as settlers who work in the tea and coffee plantations. The culture here is a blend of tribal traditions and the customs of the plantation workers. The local festivals, cuisine, and handicrafts reflect this unique mix of traditions. Visitors can experience the local culture through interactions with plantation workers, tribal communities, and by visiting local temples and markets. The tea estates themselves have become a cultural landmark, symbolizing the area''s rich history of plantation life.',56),
 (168,'Natural Significance','The natural significance of Valparai lies in its location within the Anamalai Tiger Reserve and its proximity to the Indira Gandhi Wildlife Sanctuary. The region is part of the Western Ghats, a UNESCO World Heritage Site known for its exceptional biodiversity. Valparai is home to numerous species of wildlife, including the endangered lion-tailed macaque, elephants, leopards, gaur, and a variety of bird species. The lush tea gardens, coffee plantations, waterfalls, and pristine forests provide a stunning backdrop for trekking, bird watching, and nature photography, making Valparai a paradise for nature enthusiasts.',56),
 (169,'Historical Significance','Kumbakonam''s history dates back over two millennia, flourishing under various South Indian dynasties, including the Cholas, Pandyas, and Vijayanagar Empire. It served as a prominent center for art, culture, and education during the Chola period, with many of its temples built or renovated during this era. Kumbakonam was also a significant trade center, strategically located on the ancient trade routes between the East and West. The city''s name is believed to have originated from the "Mahamaham," a Hindu festival held every 12 years, which attracts millions of pilgrims to its sacred tank. Throughout its history, Kumbakonam has remained a hub of religious and cultural activity.',57),
 (170,'Cultural Significance','Kumbakonam is a melting pot of Tamil culture, with its numerous temples, festivals, and traditional practices reflecting the rich cultural heritage of the region. The city is home to over a hundred temples, each with its unique architectural style, legends, and rituals. Major festivals like Mahamaham, Navaratri, and Panguni Uthiram are celebrated with great fervor, featuring elaborate processions, classical music, and dance performances. The city''s markets are famous for traditional brassware, silk sarees, and exquisite handicrafts, reflecting its vibrant cultural traditions. Kumbakonam is also known for its distinctive cuisine, especially its aromatic filter coffee, and traditional vegetarian dishes.',57),
 (171,'Natural Significance','Kumbakonam is located in the fertile Cauvery Delta, known for its lush paddy fields, coconut groves, and scenic waterways. The city is surrounded by the tranquil backwaters of the Cauvery River, providing a serene environment for boat rides and nature walks. The Mahamaham tank, located in the heart of the city, is considered a sacred water body where the Mahamaham festival is held. The city’s proximity to the fertile delta region makes it a significant agricultural center, with extensive cultivation of crops like rice, sugarcane, and betel leaves. The natural beauty of Kumbakonam, with its rivers, canals, and green landscapes, adds to its charm as a tourist destination.',57),
 (172,'Historical Significance','Historically, Pichavaram Mangrove Forest has served as a natural protective barrier for the coastal areas of Tamil Nadu. The mangroves have played a crucial role in shielding the region from coastal erosion, cyclones, and tsunamis. The forest''s significance was particularly highlighted during the 2004 Indian Ocean Tsunami when the dense mangrove vegetation significantly reduced the impact of the waves on the nearby villages. Additionally, the Pichavaram region has been an important location for traditional fishing communities for centuries, providing a sustainable source of livelihood for local fishermen.',58),
 (173,'Cultural Significance','The Pichavaram Mangrove Forest holds cultural importance for the local fishing communities who have lived in harmony with the ecosystem for generations. These communities practice sustainable fishing techniques and have developed a unique lifestyle centered around the mangroves. The forest is also associated with several local legends and religious beliefs, reflecting its importance in the cultural fabric of the region. Festivals, rituals, and traditional practices are intertwined with the natural environment, showcasing the deep cultural connection between the people and the mangroves.',58),
 (174,'Natural Significance','Pichavaram is a biodiversity hotspot, home to a wide variety of flora and fauna, including several rare and endangered species. The mangrove forest acts as a crucial habitat for diverse marine life, birds, and animals. It is a haven for bird watchers, especially during the migratory season, with over 200 species of birds, including herons, egrets, kingfishers, and pelicans. The mangroves also serve as a natural nursery for fish, crabs, and other aquatic species. Additionally, the forest plays a vital role in carbon sequestration, coastal protection, and maintaining the ecological balance of the region.',58),
 (175,'Historical Significance','Manapad''s history dates back to the early 16th century when Portuguese traders and missionaries arrived on its shores. The village became a focal point for Catholic missionaries, notably Saint Francis Xavier, who lived and preached here in the 1540s. Several historic churches were built during this period, with the most notable being the Holy Cross Church, established in 1581. This church is believed to have a fragment of the True Cross, making it an important pilgrimage site. Manapad played a key role in the spread of Christianity in South India, and its historical churches stand as a testament to its rich colonial past.',59),
 (176,'Cultural Significance','Manapad has a unique cultural heritage shaped by its Christian population and colonial history. The village is home to several ancient churches that host vibrant religious festivals, such as the Feast of the Exaltation of the Holy Cross, attracting pilgrims from across the country. The architecture of Manapad reflects a blend of Portuguese, Dutch, and Tamil styles, seen in its churches, old houses, and fishing boats. The local community continues to practice traditional fishing, reflecting the region’s strong maritime culture. Manapad also features in Tamil literature and folklore, adding to its cultural richness.',59),
 (177,'Natural Significance','Manapad is renowned for its natural beauty, with its crescent-shaped beach, rugged cliffs, and unique rock formations providing a stunning backdrop against the blue waters of the Bay of Bengal. The coastal area is relatively untouched, offering pristine sandy shores and clear waters ideal for swimming, snorkeling, and surfing. The village is also a habitat for diverse marine life, including various species of fish, sea turtles, and seabirds. The natural landscape, with its serene beaches and dramatic cliffs, makes Manapad a perfect destination for nature lovers seeking tranquility.',59);
INSERT INTO "app_nearby_place" ("id","placename","desc","main_place_id") VALUES (1,'Habba Khatoon Peak','Named after the famous Kashmiri poetess Habba Khatoon, this pyramid-shaped peak is one of the most prominent landmarks in the valley. The poetess is said to have wandered the valley in search of her lost love, Sultan Yousuf Shah Chak.',1),
 (2,'Kishanganga River','The crystal-clear waters of the Kishanganga River flow through the valley, offering opportunities for fishing and riverside picnics.',1),
 (3,'Razdan Pass','The pass is the gateway to Gurez Valley, offering breathtaking views of the surrounding mountains and valleys.',1),
 (4,'Starting Point – Aru Valley','The trek typically starts from Aru Valley, a picturesque village near Pahalgam. Aru Valley itself is known for its scenic beauty and serves as a base camp for several treks in the region.',2),
 (5,'Tarsar Lake','The trek to Tarsar Lake involves passing through lush meadows, dense forests, and beautiful streams. Tarsar Lake is an almond-shaped alpine lake situated at an altitude of approximately 12,500 feet. The lake is surrounded by snow-capped peaks and lush green meadows, making it a perfect camping spot.',2),
 (6,'Marsar Lake','From Tarsar Lake, the trek continues to Marsar Lake, which is located at an altitude of about 13,000 feet. Unlike Tarsar, Marsar Lake is often shrouded in mist and clouds, giving it a mysterious and ethereal appearance. The lake is situated in a more secluded area, adding to its untouched beauty.',2),
 (7,'Sanasar Lake','The primary attraction, Sanasar Lake, is a man-made lake surrounded by meadows and forests. It is a popular spot for boating, picnicking, and enjoying the serene natural beauty',3),
 (8,'Sana and Sar Lakes','Apart from the main Sanasar Lake, the smaller Sana and Sar lakes also attract visitors. These lakes are surrounded by picturesque landscapes, making them perfect for nature walks and photography.',3),
 (9,'Meadows and Forests','The rolling meadows and dense forests of Sanasar offer ample opportunities for trekking, camping, and nature walks. The tranquil environment is ideal for relaxation and reconnecting with nature.',3),
 (10,'Trekking and Hiking','Chatpal offers numerous trekking and hiking opportunities. The trails take you through dense forests, over rolling meadows, and along crystal-clear streams. The treks are relatively easy, making them suitable for beginners as well as experienced hikers.',4),
 (11,'Wildlife and Bird Watching','The dense forests around Chatpal are home to a variety of wildlife, including Himalayan black bears, leopards, and various bird species. It is an excellent spot for wildlife enthusiasts and bird watchers.',4),
 (12,'Local Culture and Lifestyle','Visitors to Chatpal can experience the traditional lifestyle and culture of the local Gujjar and Bakarwal tribes. Interacting with the locals provides insights into their way of life, traditional crafts, and customs',4),
 (13,'Jai Valley','Known for its rolling meadows and beautiful landscapes, Jai Valley is a popular tourist spot near Bhaderwah.',5),
 (14,'Padri','A stunning high-altitude meadow, perfect for camping and picnicking, located about 40 kilometers from Bhaderwah.',5),
 (15,'Chinta Valley','Famous for its scenic beauty and trout fishing, Chinta Valley is a must-visit for nature lovers.',5),
 (16,'Terraced Gardens','The six terraced gardens are the highlight of Pari Mahal, each terrace featuring beautifully manicured lawns, flower beds, and water features. The gardens provide a serene and picturesque environment, perfect for leisurely walks and relaxation.',6),
 (17,'Panoramic Views','One of the major attractions of Pari Mahal is the stunning view it offers of Dal Lake, the city of Srinagar, and the surrounding mountains. The elevated location of the palace provides a unique vantage point to appreciate the natural beauty of the Kashmir Valley.',6),
 (18,'Architectural Beauty:','The arched terraces, intricate niches, and stonework reflect the architectural elegance of the Mughal era. Exploring the structure gives visitors a glimpse into the grandeur of Mughal architecture and design.',6),
 (19,'Purna Wildlife Sanctuary','Located in the predominantly tribal district of Dangs, Purna Wildlife Sanctuary, which was declared as a sanctuary in July 1990, has the thickest forest cover in the state of Gujarat. The forests have lofty teak trees rising tall and straight in the company of other associated flora viz. sadad, timru, bamboos, khair, kalam, haldu, sisham (rosewood), salai, kadaya, killai, sevan, tanachh etc. The healthy stock of lofty bamboos specially attracts your attention.',7),
 (20,'Mahal Eco Campsite','The Mahal Eco Campsite is bestowed with rivers and bamboo glides, with excellent walking and trekking options. It is located on the banks of the Purna River, in the middle of the Purna Wildlife Sanctuary and is a part of the Dang Forest Division North. It is surrounded by a vast & rich forest laced with the Purna & Gira rivers. For an eco-tourist wanting to enjoy birds of moist deciduous forest mixed with bamboo, this is the best place to visit. It''s also near the Girmar Falls which offers a breathtaking view. Best time to visit the campsite is from October to March.',7),
 (21,'Gira Waterfalls','Breathtakingly beautiful around monsoon, these seasonal (only after rains) falls are among the most picturesque sights in the district. Located about 3 km from Waghai town, the Gira waterfall is a 30 m natural drop into the Ambica River. It is open to the public and accessible by jeeps on hire.',7),
 (22,'Mandvi Fort','About 5 km from Bechtel Beach
 Built by the Kutch State''s Maharaja in the 19th century, Mandvi Fort offers a glimpse into the region''s historical architecture. The fort has several bastions, a moat, and provides a great view of the surrounding area. It''s a great place to learn about the local history and enjoy panoramic views.',8),
 (23,'Vijay Vilas Palace','Approximately 7 km from Bechtel Beach
This palace is a stunning example of Rajput architecture with its beautiful gardens, intricate carvings, and regal interiors. It was the summer retreat of the Kutch kings and is known for its grand design and tranquil surroundings. The palace grounds and its unique blend of architectural styles are worth exploring.',8),
 (24,'Kutch Museum','About 60 km from Mandvi (in Bhuj)
Located in Bhuj, this museum is one of the oldest in Gujarat. It houses a diverse collection of artifacts related to the history, culture, and art of the Kutch region, including items related to local crafts, costumes, and tribal art.',8),
 (25,'Mandvi Fort','Around 30 km from Kadiya Dhro
A historic fort built by the Kutch State’s Maharaja, featuring bastions, a moat, and commanding views of the surrounding area. It provides insights into the local history and offers panoramic vistas.',9),
 (26,'Nakhatrana','Around 40 km from Kadiya Dhro
 A small town known for its traditional Kutch architecture and vibrant local markets. It’s a good place to experience local culture and purchase traditional Kutch crafts.',9),
 (27,'Tunda Vandh','Approximately 35 km from Kadiya Dhro
 A scenic spot ideal for a quiet visit. It offers natural beauty and a tranquil environment, perfect for relaxing and enjoying the outdoors.',9),
 (28,'Tithal Beach','Approximately 55 km from Wilson Hill
 A popular beach near Valsad, known for its clean sands and calm waters. It’s a great place for a relaxing day by the sea.',10),
 (29,'Hathisingh Jain Temple (in Valsad)','Around 35 km from Wilson Hill
An important Jain temple known for its architectural beauty and serene environment. It’s a great place to explore the local religious and cultural heritage',10),
 (30,'Silvassa','Approximately 50 km from Wilson Hill
The capital of Dadra and Nagar Haveli, Silvassa is known for its natural beauty and cultural attractions. Key spots include:
1. Vanganga Lake: A scenic lake with boating facilities and beautifully landscaped gardens.
2. Dadra Garden: A well-maintained park ideal for picnics and relaxation.
3. Hirwa Van Garden: A lush green garden showcasing local flora and a pleasant atmosphere.',10),
 (31,'Ambaji Temple','About 90 km from Polo Forest
 A significant Hindu pilgrimage site dedicated to the goddess Ambaji. It’s a revered temple with a rich history and is visited by devotees from across the country.',11),
 (32,'Sardarpur','Around 70 km from Polo Forest
 A small town known for its historical significance and nearby temples. It is an excellent spot to explore the local culture and traditions.',11),
 (33,'Siddhpur','About 80 km from Polo Forest
Siddhpur is known for its historical and cultural significance, including:
1. Rani Ki Vav: An architectural marvel and UNESCO World Heritage Site.
2. Siddhpur Jain Temples: Ancient Jain temples with detailed carvings.',11),
 (34,'Kappil Beach','Distance from Bekal Fort: Approximately 6 km
Description: A serene and less crowded beach known for its picturesque setting and tranquil environment. It’s an ideal spot for a peaceful retreat and offers beautiful sunset views.',12),
 (35,'Chandragiri Fort','Distance from Bekal Fort: Approximately 10 km
Description: Another historic fort located along the banks of the Chandragiri River. It provides panoramic views of the river and the surrounding landscape.',12),
 (36,'Nileshwaram','Distance from Bekal Fort: Approximately 22 km
Description: A town known for its cultural heritage and historical landmarks. Nileshwaram offers a glimpse into the local traditions and history of the region.',12),
 (37,'Chadayamangalam','Distance from Jatayu Earth''s Center: Approximately 5 km
Description: The village where the Jatayu Rock is located. It’s a tranquil area with local attractions, including traditional Kerala homes and temples.',13),
 (38,'Sasthamcotta Lake','Distance from Jatayu Earth''s Center: Approximately 20 km
Description: The largest freshwater lake in Kerala, known for its serene environment and bird-watching opportunities. It''s a good spot for nature lovers and offers boating experiences.',13),
 (39,'Punalur','Distance from Jatayu Earth''s Center: Approximately 30 km
Description: Known for its historical significance and scenic beauty. Visit the Punalur Suspension Bridge and explore local temples and natural spots.',13),
 (40,'S.M. Street (Sweet Meat Street)','Distance from Kappad Beach: Approximately 15 km
Description: A bustling shopping street in Kozhikode known for its variety of sweets, spices, and local products. It’s a vibrant area where you can experience the local culture and cuisine.',14),
 (41,'Thusharagiri Waterfalls','Distance from Kappad Beach: Approximately 50 km
Description: A stunning waterfall located in the Western Ghats, surrounded by dense forests. It’s an ideal spot for nature lovers and those looking to enjoy a scenic waterfall.',14),
 (42,'Pazhassi Raja Museum','Distance from Kappad Beach: Approximately 16 km
Description: A museum in Kozhikode showcasing artifacts related to the local history, including items from the Pazhassi Raja era, who was a prominent figure in the region’s history.',14),
 (43,'Kochi (Cochin)','Distance from Edappally Church Complex: Approximately 10 km
Description: A major city in Kerala with various attractions including:
1. Fort Kochi: Known for its colonial architecture, Chinese fishing nets, and vibrant cultural scene.
2. Mattancherry Palace: A historical palace with rich murals and artifacts.
3. Jewish Synagogue: One of the oldest synagogues in India, located in Jew Town, Mattancherry.
4. Marine Drive: A picturesque promenade offering beautiful views of the backwaters and the city skyline.',15),
 (44,'Vypin Island','Distance from Edappally Church Complex: Approximately 20 km
Description: Known for its scenic beauty, beaches, and historical landmarks such as the Vypin Lighthouse and St. Francis Church.',15),
 (45,'Mangalavanam Bird Sanctuary','Distance from Edappally Church Complex: Approximately 12 km
Description: A small but significant bird sanctuary located in the heart of Kochi, offering a peaceful retreat and opportunities for bird-watching.',15),
 (46,'Munnar','Distance from Ramakkalmedu: Approximately 80 km
Description: A popular hill station known for its lush tea gardens, pleasant weather, and attractions such as Eravikulam National Park, Mattupetty Dam, and Attukal Waterfalls.',16),
 (47,'Vagamon','Distance from Ramakkalmedu: Approximately 50 km
Description: A serene hill station with rolling meadows, pine forests, and the Vagamon Pine Forest. It’s ideal for trekking and nature walks.',16),
 (48,'Idukki Dam','Distance from Ramakkalmedu: Approximately 60 km
Description: An impressive arch dam situated across the Periyar River. It’s a significant hydroelectric project and offers scenic views of the surrounding landscapes.',16),
 (49,'Kovalam Beach','Distance from Anchuthengu: Approximately 40 km
Description: A famous beach destination known for its crescent-shaped beaches, lighthouses, and water sports. Kovalam Beach is popular with tourists and offers various accommodation and dining options.',17),
 (50,'Ponmudi','Distance from Anchuthengu: Approximately 60 km
Description: A hill station located in the Western Ghats, known for its lush greenery, tea gardens, and scenic views. It’s an ideal spot for trekking and nature walks.',17),
 (51,'Thiruvananthapuram (Trivandrum)','Distance from Anchuthengu: Approximately 25 km
Description: The capital city of Kerala with attractions such as the Padmanabhaswamy Temple, Napier Museum, and Sree Chitra Art Gallery. The city also has a range of dining and shopping options.',17),
 (52,'Eco Park','The Eco Park - located within Dhanaulti, is one of the main attractions in Dhanaulti, consisting of two forests named Amber and Dhara. It’s an ideal place for nature walks, picnics, and enjoying the serene environment amidst deodar, oak, and rhododendron trees. The park is also home to a variety of birds.
The place is perfect for those seeking peaceful stroll in nature, enjoys fresh mountain air and beautiful scenery.',18),
 (53,'Surkanda Devi Temple','This ancient Hindu temple - 8 km from Dhanaulti, is dedicated to Goddess Surkanda, a manifestation of Shakti. The temple is located at an altitude of about 2,757 meters and requires a 2 km uphill trek from the village of Kaddukhal. The temple offers panoramic views of the surrounding Himalayan peaks.
The place is perfect for those seeking spiritual significance, the challenging trek, and enjoys the breathtaking views from the top.',18),
 (54,'Kanatal','Kanatal - 17 km from Dhanaulti, is a quiet, less-commercialized hill station known for its picturesque landscapes, apple orchards, and adventure activities like camping and trekking. The place is perfect for those seeking solitude and a break from the bustling city life and wants scenic beauty, adventure activities, and peaceful environment.',18),
 (55,'St. Mary’s Church','St. Mary’s Church - 1.5 km from Lansdowne,  is a historic church built during the British era in 1895. Although no longer functioning as a church, it has been converted into a museum that displays the history of Lansdowne and the Garhwal Rifles. The architecture of the church, with its stained glass windows and wooden interiors, is a reminder of the colonial past.
The place is perfect for those who would like to explore the historical and architectural significance of church,  Lansdowne’s colonial history and the Garhwal Rifles.',19),
 (56,'Bhulla Tal Lake','Bhulla Tal Lake - 1.5 km from Lansdowne, is a man-made lake maintained by the Indian Army. It’s a peaceful spot surrounded by lush greenery, offering boating facilities, a small park, and a bamboo machan (watchtower) for birdwatching. The lake is named "Bhulla" after the Garhwali term for younger brother, as a tribute to the soldiers of the Garhwal Rifles.
 The place is perfect for those seeking a relaxing day out with boating, picnicking, and enjoying the serene surroundings.',19),
 (57,'Tip-In-Top','Tip-In-Top - 2.5 km from Lansdowne, also known as Tiffin Top, is a popular viewpoint in Lansdowne that offers breathtaking panoramic views of the Himalayan ranges, particularly during sunrise and sunset. The spot is surrounded by dense forests of pine and oak, making it a perfect place for nature lovers and photographers.
The place is perfect for those who enjoy stunning views of the Himalayas and the surrounding valleys, and likes to experience the tranquility of nature.',19),
 (58,'Patal Bhuvaneshwar Cave Temple','Patal Bhuvaneshwar - 37 km from Chaukori, is an ancient limestone cave temple dedicated to Lord Shiva. The cave is a spiritual and geological marvel, filled with stalactites and stalagmites that resemble various Hindu deities. The descent into the cave is through a narrow tunnel, leading to a large underground chamber where the main shrine is located.
The place is perfect for those who would like to explore spiritual significance, unique cave formations, and the mystical atmosphere that surrounds this ancient temple.',20),
 (59,'Berinag','Berinag - 10 km from Chaukori, is a small hill town known for its tea gardens and stunning views of the Himalayan ranges. The town offers a peaceful environment and is ideal for nature walks and enjoying the local tea. It’s also a good spot to witness the sunrise over the snow-capped peaks.
This place is perfect for those who wants to enjoy scenic beauty, tranquil environment, and explore the local tea plantations.',20),
 (60,'Nagmandir','Nagmandir - 20 km from Chaukori (near Berinag), also known as the Snake Temple, is a famous temple dedicated to Lord Shiva in his serpent form (Nag Devta). The temple is located in a peaceful setting surrounded by thick forests. It is a place of pilgrimage, especially during Nag Panchami, and is known for its serene environment.',20),
 (61,'Harsil','Harsil - 20 km from Nelong Valley, is a quaint village located on the banks of the Bhagirathi River, surrounded by dense deodar forests and snow-clad mountains. It is known for its scenic beauty, apple orchards, and serene environment. Harsil is an excellent base for treks and exploring nearby attractions like Gangotri and the Nelong Valley.
This place could be visited for its tranquil surroundings, stunning landscapes, and as a gateway to nearby trekking routes and pilgrimage sites.',21),
 (62,'Gangotri','Gangotri - 25 km from Nelong Valley, is one of the four Char Dham pilgrimage sites and the origin of the sacred river Ganga (known as Bhagirathi in its upper reaches). The Gangotri Temple, dedicated to Goddess Ganga, is a significant spiritual destination. The region is surrounded by snow-capped peaks and offers stunning views of the Himalayas.
This place could be visited to experience the spiritual significance of one of India’s most revered pilgrimage sites, and to enjoy the breathtaking natural beauty of the area.',21),
 (63,'Bhagirathi Shila','Bhagirathi Shila - 25 km from Nelong Valley (near Gangotri), is a sacred rock located near the Gangotri Temple, believed to be the spot where King Bhagirath meditated to bring the Ganga down from heaven to earth. The rock holds significant religious importance, especially for pilgrims visiting Gangotri.
This place could be visited for its spiritual significance and to connect with the mythological history associated with the descent of the Ganga river.',21),
 (64,'Dharali','Dharali - 6 km from Harsil Valley, is a charming village known for its apple orchards, pine forests, and scenic beauty. It is also home to a small Shiva temple and serves as a base for treks to the Mukhba village, where the idol of Goddess Ganga is brought during the winter months when Gangotri is inaccessible.
This place could be visited to experience the local culture, explore the picturesque surroundings, and visit the Shiva temple.',22),
 (65,'Gangotri','Gangotri - 25 km from Harsil Valley, is one of the most important pilgrimage sites in India, known as the origin of the sacred river Ganga (Bhagirathi). The Gangotri Temple, dedicated to Goddess Ganga, is the focal point of the town, attracting pilgrims from across the country. The area is surrounded by majestic snow-capped peaks and offers breathtaking natural beauty.',22),
 (66,'Sattal','Sattal, meaning "seven lakes," is a group of seven interconnected freshwater lakes located near Harsil(3 km from Harsil Valley). These serene lakes are surrounded by dense forests and offer a peaceful environment for nature lovers. Sattal is also a great spot for birdwatching, as the area is home to a variety of bird species.
This place is perfect for those seeking for tranquil setting, natural beauty, and opportunities for birdwatching and picnicking.',22),
 (67,'Auli','Auli - 34 km from Chamoli, is a popular skiing destination in India, known for its pristine slopes and panoramic views of the Himalayan peaks, including Nanda Devi and Mana Parvat. Auli is also famous for its ropeway, which offers a breathtaking ride with stunning views of the surrounding mountains.
This place could be visited for skiing and snowboarding during winter, and for trekking, camping, and enjoying the beautiful landscapes during summer.',23),
 (68,'Vasudhara Falls','Vasudhara Falls -51 km from Chamoli (via Mana Village), is a stunning waterfall located near Mana Village, the last Indian village before the Tibetan border. The waterfall drops from a height of about 400 feet, creating a mesmerizing sight. The trek to Vasudhara Falls offers breathtaking views of the surrounding mountains and is steeped in mythological significance.
This place could be visited for the scenic beauty of the waterfall, the adventure of the trek, and the peaceful, spiritual environment.',23),
 (69,'Nanda Devi National Park','Nanda Devi National Park - 57 km from Chamoli, is a UNESCO World Heritage Site and a part of the Nanda Devi Biosphere Reserve. The park is known for its diverse flora and fauna, including rare and endangered species. The park offers stunning views of the Nanda Devi peak, the second-highest mountain in India, and is a paradise for trekkers and nature enthusiasts.',23),
 (70,'Kemmangundi (Kemmannugundi)','Kemmangundi - located at approximately 50 km, is a picturesque hill station known for its lush green landscapes, waterfalls, and panoramic views of the Western Ghats. 
It is visited for its cool climate, natural beauty, and opportunities for trekking and nature walks.',24),
 (71,'Agumbe','Agumbe - approximately at 70 km, often referred to as the "Cherrapunji of the South," is known for its lush rainforests, wildlife, and scenic beauty, biodiversity and beautiful sunsets.',24),
 (72,'Shravanabelagola','Shravanabelagola - approximately at 100 km, is a prominent Jain pilgrimage site known for its ancient temples, historical significance, architectural marvels, spiritual atmosphere, and the gigantic statue of Gomateshwara (Bahubali).',24),
 (73,'Horanadu Annapoorneshwari Temple','The Horanadu Annapoorneshwari Temple - approximately at 8 km from Kalasa, is one of the most revered temples in Karnataka, dedicated to Goddess Annapoorneshwari, the goddess of nourishment. Surrounded by the lush greenery of the Western Ghats, the temple offers a peaceful and spiritual atmosphere. Pilgrims believe that those who visit the temple will never face a scarcity of food.
Visitors are offered free meals at the temple, as Annapoorneshwari is the goddess of food.',25),
 (74,'Hanuman Gundi Falls','Hanuman Gundi Falls - approximately 25 km from Kalasa, within Kudremukh National Park, also known as Suthanabbe Falls, is a beautiful waterfall located in the lush forests of Kudremukh National Park. The waterfall cascades down from a height of about 22 meters (72 feet), creating a serene and picturesque setting. It''s a popular spot for nature lovers and a great place to relax and enjoy the cool, refreshing water.
The monsoon season enhances the beauty of the falls, making it the best time to visit.',25),
 (75,'Kudremukh National Park','Kudremukh National Park - approximately 20 km from Kalasa, is a biodiversity hotspot and part of the Western Ghats. The park is famous for its stunning landscapes, rolling hills, dense forests, and the Kudremukh peak, which resembles the face of a horse. It’s an ideal spot for trekking, wildlife spotting, and exploring the rich flora and fauna of the region.
The park is home to several species, including tigers, leopards, Malabar giant squirrels, and a variety of bird species.',25),
 (76,'Kudroli Gokarnath Temple','Kudroli Gokarnath Temple - approximately 10 km from Sasihitlu Beach, is a significant religious site dedicated to Lord Shiva. The temple is known for its modern architecture and intricate carvings. It is an important place of worship for the local community and hosts various cultural and religious events throughout the year.
Activities like participating in religious ceremonies, admiring the temple architecture, and exploring the temple''s surroundings invites visiters across India.',26),
 (77,'Tannirbhavi Beach','Tannirbhavi Beach - approximately 15 km from Sasihitlu Beach, is known for its clean sands, gentle waves, and picturesque surroundings. It is less crowded compared to other beaches in the region, making it a great spot for relaxation and leisurely walks. The beach is ideal for sunset views and has a peaceful environment for picnicking like enjoying the tranquil beach environment, taking a stroll along the shore, and photography.',26),
 (78,'St. Aloysius Chapel','St. Aloysius Chapel - approximately 12 km from Sasihitlu Beach, is renowned for its beautiful frescoes and artwork, which were created by Italian artist Antonio Moscheni in the early 20th century. The chapel is a prominent historical and architectural site in Mangaluru and offers a glimpse into the artistic heritage of the region.
Exploring the chapel''s artwork, learning about its history, and experiencing its serene ambiance attracts visiters.',26),
 (79,'Raj Bhavan','Raj Bhavan - approximately at 5 km, also known as the Governor''s House, is a historic bungalow situated at an elevation of about 1,700 meters (5,577 feet). It was originally built during the British era as a summer retreat for the then Governor of Karnataka. The building and its surroundings are surrounded by lush gardens and offer a serene atmosphere.
Raj Bhavan is accessible by road from Kemmangundi, and it''s a short drive away. The area around Raj Bhavan is ideal for a peaceful stroll and enjoying the natural beauty of the surroundings.',27),
 (80,'Hebbe Falls','Hebbe Falls - approximately at 10 km, is a stunning waterfall nestled amidst the coffee estates and dense forests near Kemmangundi. The waterfall cascades down from a height of around 168 meters (550 feet) in two stages, creating a mesmerizing view. The falls are surrounded by lush greenery, making it a popular spot for nature lovers and photography enthusiasts.It is reachable by a short trek or by hiring a jeep from Kemmangundi. The approach involves navigating through rugged terrain.',27),
 (81,'Z Point','Z Point - approximately at 8 km, offers a breathtaking panoramic view of the Western Ghats and the surrounding valleys. It is a popular trekking destination that provides a spectacular view of the sunrise and sunset. The trek to Z Point is moderately challenging, passing through dense forests and rocky trails.
The trek to Z Point begins from Kemmangundi and takes around 1-2 hours to reach. A guide is often recommended for this trek.',27),
 (82,'Sigandur Chowdeshwari Temple','Sigandur Chowdeshwari Temple - located on the banks of the Sharavathi River approximately 30 km from Honnemaradu,  is a revered temple dedicated to Goddess Chowdeshwari. It is a popular pilgrimage site among locals and attracts a significant number of devotees throughout the year. The temple is surrounded by lush greenery and offers a serene environment for visitors. To reach the temple, one must cross the river on a launch or ferry, adding to the experience.',28),
 (83,'Jog Falls','Jog Falls - approximately 25 km from Honnemaradu, is one of the highest and most spectacular waterfalls in India, plunging from a height of about 253 meters (830 feet). The waterfall is created by the Sharavathi River and consists of four distinct cascades — Raja, Rani, Roarer, and Rocket — which merge to form a majestic drop. It is especially breathtaking during the monsoon season when the water flow is at its peak. Visitors can enjoy the view from the designated viewpoints or trek down to the base of the falls.',28),
 (84,'Ikkeri and Keladi','Ikkeri and Keladi - approximately 40 km from Honnemaradu, are two historic villages located near Sagara town, known for their rich cultural heritage and temples. The Keladi Rameshwara Temple, built in the 16th century, showcases a unique blend of Hoysala and Dravidian architectural styles, with intricate carvings and beautiful sculptures. Ikkeri, once the capital of the Keladi Nayakas, is home to the Aghoreshwara Temple, an example of exquisite stone architecture.
It could be visited to explor historical temples, study architecture, and understand local history.',28),
 (85,'Nagara Fort','Nagara Fort - about 15 km from Kavaledurga Fort, also known as Bidanur Fort, is a historic site that offers insight into the region''s history. The fort is relatively small but provides a glimpse into the architectural style of the Keladi Nayakas. The fort''s location on a hilltop offers stunning views of the surrounding countryside, including lush paddy fields and backwaters of the Varahi River.',29),
 (86,'Agumbe','Agumbe - About 30 km from Kavaledurga Fort, is known as the "Cherrapunji of the South" due to its high rainfall. It is famous for its lush green rainforests, beautiful sunsets, and numerous waterfalls. It is a hotspot for trekking, birdwatching, and herpetology (study of reptiles and amphibians), especially since it''s home to the King Cobra.
Agumbe Sunset Point, Jogigundi Falls, Barkana Falls, and the Agumbe Rainforest Research Station also attract visitors.',29),
 (87,'Thirthahalli','About 18 km from Kavaledurga Fort, A quaint town on the banks of the Tunga River, Thirthahalli is known for its historical and cultural significance. It is believed to be the birthplace of Jnanpith Award-winning Kannada writer Kuvempu.
Kuvempu''s house (now a museum), Kuppalli (Kuvempu’s home village), and Rameshwara Temple are also attractive points to visit.',29),
 (88,'Ratnari Temple','Situated in the serene village of Ratnari - approximately 30 km from Hatu Peak, this ancient temple is dedicated to the Hindu deity Shiva. It is renowned for its intricate wooden carvings and stunning architecture, showcasing traditional Himachali craftsmanship. The temple is nestled amidst lush greenery and offers a peaceful environment for visitors.
•	The temple’s unique wooden architecture and peaceful, picturesque setting.',30),
 (89,'Kotkhai','Kotkhai - around 25 km from Hatu Peak,  is a charming town known for its historic significance and beautiful landscapes. The town is home to several ancient temples and offers breathtaking views of the surrounding hills and valleys. It’s a great spot to experience the local culture and history of Himachal Pradesh.
•	Historical temples and scenic beauty of the town’s surroundings.',30),
 (90,'Chirgaon','Chirgaon - approximately 18 km from Hatu Peak,  is a quaint village located at the foot of the Hatu Peak. It is known for its traditional Himachali houses and serene environment. The village offers a glimpse into rural life and provides excellent views of the surrounding mountains and forests.
One can enjoy authentic rural experience and stunning mountain views here.',30),
 (91,'Sangla Valley','Sangla Valley - approximately 40 km, is a stunning and serene destination in the Kinnaur district, known for its lush green meadows, apple orchards, and the Baspa River. The valley is characterized by its picturesque landscapes and traditional Kinnauri architecture. It offers a tranquil escape with breathtaking views of the snow-capped peaks and charming villages.
The highlight of Sangla Valley is the Baspa River, which adds a beautiful touch to the valley''s landscape. The area is perfect for nature lovers and those seeking a peaceful retreat.',31),
 (92,'Kalpa','Kalpa - approximately 40 km, is a small town in the Kinnaur district, renowned for its panoramic views of the Kinnaur Kailash range. It is a quiet and picturesque location with apple orchards and ancient temples. Kalpa offers a unique blend of natural beauty and cultural heritage, making it a great spot for relaxation and exploration.
The highlight of Kalpa is its stunning views of the Kinnaur Kailash range, especially during sunrise and sunset. The ancient temples and local apple orchards add to the charm of the town.',31),
 (93,'Rakchham','Rakchham - approximately 18 km, is a beautiful village located near Chitkul, along the Baspa River. The village is known for its picturesque landscapes, traditional wooden houses, and lush green surroundings. It is a great place to experience the local culture and enjoy the natural beauty of the region.
The highlight of Rakchham is its serene environment and scenic beauty, with the Baspa River flowing through the village and the surrounding mountain views. It offers a peaceful atmosphere ideal for nature walks and cultural experiences.',31),
 (94,'Hatkoti Temple','Hatkoti Temple - approximately 30 km from Pabbar Valley, is a revered Hindu shrine dedicated to Goddess Hatkeshwari. Situated on the banks of the Pabbar River, this ancient temple complex features intricate wooden carvings and traditional Himachali architecture. The temple is surrounded by scenic landscapes, including lush green hills and serene river views.',32),
 (95,'Rohru','Rohru - approximately 40 km from Pabbar Valley, is a charming town located along the Pabbar River, known for its beautiful landscape and apple orchards. It serves as a gateway to several trekking routes and is a popular spot for trout fishing. Rohru’s pleasant climate and picturesque surroundings make it an ideal destination for relaxation and exploration.
Primarily Trout fishing, apple orchards, trekking opportunities, and scenic beauty attracts visitors here.',32),
 (96,'Jalori Pass','Jalori Pass - approximately 50 km from Pabbar Valley, is a high-altitude mountain pass situated at an elevation of about 3,120 meters (10,236 feet). It offers breathtaking views of the surrounding peaks and valleys, and serves as a popular trekking and hiking destination. The pass is also known for its pleasant weather and panoramic vistas of the Himalayan range.',32),
 (97,'Sainj Valley','Sainj Valley - approximately 30 km from Shangarh, is a picturesque area known for its scenic landscapes, lush greenery, and serene environment. It is a perfect destination for nature lovers and those seeking tranquility away from the bustling tourist spots. The valley is adorned with traditional villages, terraced fields, and dense forests.',33),
 (98,'Tirthan Valley','Tirthan Valley - approximately 40 km from Shangarh, is renowned for its natural beauty and offers a serene escape into the Himalayas. The valley is named after the Tirthan River, which flows through it. Known for its trout fishing, trekking routes, and lush meadows, it’s a great place for adventure enthusiasts and nature lovers.',33),
 (99,'Jibhi','Jibhi - approximately 50 km from Shangarh, is a charming village nestled in the Tirthan Valley, known for its tranquil environment and traditional wooden houses. It offers a picturesque setting with its beautiful river, dense forests, and scenic hiking trails. Jibhi is a great spot for a peaceful retreat and exploring the local culture.',33),
 (100,'Jalori Pass','Jalori Pass - approximately 5 km, is a high-altitude mountain pass situated at an elevation of about 3,120 meters (10,236 feet). It is one of the most scenic and easily accessible passes in the region. The pass offers breathtaking views of the surrounding Himalayan peaks and is a popular destination for trekking and adventure enthusiasts. The journey to Jalori Pass is a thrilling drive through winding roads, dense forests, and serene meadows.',34),
 (101,'Serolsar Lake','Serolsar Lake - approximately 5 km (trek from Jalori Pass), is a serene high-altitude lake located near Jalori Pass. To reach the lake, you need to embark on a moderately challenging trek of about 5 km from Jalori Pass through dense oak and pine forests. The lake is considered sacred by locals and is known for its crystal-clear waters surrounded by lush greenery. The temple of Budhi Nagin, the goddess of snakes, is located near the lake and holds religious significance for the local communities.',34),
 (102,'Tirthan Valley','Tirthan Valley - approximately 16 km, is a hidden gem of Himachal Pradesh, known for its pristine beauty, tranquil environment, and outdoor activities. The valley is named after the Tirthan River, which flows through it, and is part of the Great Himalayan National Park, a UNESCO World Heritage Site. It offers a range of activities like trout fishing, river crossing, bird watching, and exploring traditional Himachali villages. The valley is ideal for nature lovers and those seeking a peaceful retreat.',34),
 (103,'Barot Dam (Shanan Power House)','The Barot Dam - approximately 2 km, also known as the Shanan Power House, is one of the oldest hydroelectric projects in India. Built in 1932 by the British, the power house is still operational and is an important source of electricity for the region. The dam is built across the Uhl River and is surrounded by dense forests and scenic landscapes.
A visit to Barot Dam offers a unique opportunity to witness a historical engineering marvel in a picturesque setting.',35),
 (104,'Rajgundha Valley','Rajgundha Valley - approximately 15 km (by trekking or jeep ride), is a hidden gem located near Barot, known for its lush meadows, dense forests, and serene landscapes. This small, secluded village is nestled amidst the Dhauladhar mountain range and offers a unique blend of natural beauty and tranquility. The valley is dotted with traditional Himachali houses, terraced fields, and thick cedar forests.
Rajgundha Valley is an ideal destination for trekkers, nature lovers, and those seeking solitude away from the tourist crowds.',35),
 (105,'Nargu Wildlife Sanctuary','Nargu Wildlife Sanctuary - approximately 6 km, is a protected area located near Barot Valley. Spread over a vast expanse of lush green forests, the sanctuary is home to a variety of flora and fauna, including Himalayan black bears, monals, musk deer, and leopards. The sanctuary is covered with dense forests of deodar, oak, and pine trees, and is intersected by numerous streams and rivulets.
Nargu Wildlife Sanctuary is a must-visit for wildlife enthusiasts, bird watchers, and nature lovers.',35),
 (106,'Jodhpur','Known as the "Blue City" for its distinctive blue-painted houses - approximately 40 km from Khejarla Fort, Jodhpur is a major city in Rajasthan with rich history and vibrant culture. It is home to the magnificent Mehrangarh Fort, the intricately designed Jaswant Thada, and the bustling Sardar Market.
Mehrangarh Fort, one of the largest forts in India, offers panoramic views of the city and houses a museum with an extensive collection of artifacts from Rajasthan’s royal history.',36),
 (107,'Osian','Osian - approximately 30 km from Khejarla Fort, is an ancient town known for its beautifully preserved Jain and Hindu temples, some of which date back to the 8th century. It is a serene oasis in the Thar Desert with a fascinating blend of history and architecture.
The Osian Temples, including the Jain Temple of Mahavira and the Sachiya Mata Temple, showcase intricate carvings and provide insights into the region’s spiritual heritage.',36),
 (108,'Mandore Gardens','Mandore Gardens - approximately 40 km from Khejarla Fort, is an ancient garden complex with stunning cenotaphs (royal tombs) and temples. It was once the capital of Marwar before Jodhpur. The gardens are known for their architectural beauty and historical significance.
The cenotaphs of the Marwar rulers, including the intricately carved Maharaja Jaswant Singh’s cenotaph, are notable for their impressive architecture and detailed carvings.',36),
 (109,'Jaisalmer','Often referred to as the "Golden City" due to its yellow sandstone architecture - •	approximately 40 km from the Thar Desert, Jaisalmer is a key gateway to the Thar Desert. It is famous for its well-preserved medieval architecture, including the Jaisalmer Fort, which is one of the largest forts in the world.
Jaisalmer Fort, a UNESCO World Heritage Site, stands out with its magnificent yellow sandstone walls and historical significance. The fort’s intricate havelis and bustling bazaars add to its charm.',37),
 (110,'Bada Bagh','Bada Bagh, meaning "Big Garden" - approximately 6 km from Jaisalmer, is a collection of royal cenotaphs (chhatris) built in honor of the Maharajas of Jaisalmer. It is located amidst the desert, providing a serene and picturesque setting.
The beautifully sculpted cenotaphs, with their ornate carvings and desert backdrop, offer a glimpse into the grandeur of Jaisalmer''s royal past. The site also provides stunning sunset views.',37),
 (111,'Kuldhara','Kuldhara - approximately 20 km from Jaisalmer, is a ghost village that dates back to the 13th century. Once a prosperous village, it was abandoned overnight under mysterious circumstances. Today, it is an intriguing historical site with ruins that tell the story of its sudden desertion.
The ruins of Kuldhara, with their ancient temples, wells, and houses, offer a hauntingly beautiful glimpse into a bygone era. The site’s eerie atmosphere and historical intrigue make it a unique visit.',37),
 (112,'Nagaur Fort','Nagaur Fort - approximately 50 km from Khimsar, is a massive fortification dating back to the 12th century, known for its impressive walls and expansive grounds. It was a strategic military base and served as a residence for various rulers over the centuries.
The fort features beautifully decorated palaces, grand courtyards, and a series of impressive gateways. Its historical significance and architectural beauty make it a noteworthy site.',38),
 (113,'Osian','Osian - approximately 60 km from Khimsar, is an ancient town known for its collection of well-preserved Jain and Hindu temples, dating back to the 8th century. It is a serene spot in the desert with historical and architectural significance.
The Jain Temple of Mahavira and the Sachiya Mata Temple are renowned for their intricate carvings and historical importance. The temples offer a glimpse into the region''s rich spiritual heritage.',38),
 (114,'Jaisalmer','Known as the "Golden City" - approximately 40 km from Khimsar, Jaisalmer is famous for its stunning yellow sandstone architecture and historic fortifications. It serves as a key gateway to the Thar Desert and offers a blend of history and cultural richness.
Jaisalmer Fort, a UNESCO World Heritage Site, is the main attraction with its vast fortifications and beautifully decorated havelis. The city''s vibrant bazaars and local crafts add to its charm.',38),
 (115,'Sambhar Town','Sambhar Town - approximately 15 km from Sambhar Lake, is the nearest settlement to Sambhar Lake and serves as a base for exploring the lake and its surroundings. The town has historical relevance due to its salt production and local heritage.
The Sambhar Lake Palace, which overlooks the lake, offers a glimpse into the region’s historical salt trade and local architecture.',39),
 (116,'Ratangarh Fort','Ratangarh Fort - approximately 50 km from Sambhar Lake, is a historic fortification located in the town of Ratangarh. It was built during the Rajput era and offers a historical perspective on regional defense structures.
The fort’s well-preserved walls and ramparts provide a sense of its historical significance and offer panoramic views of the surrounding landscape.',39),
 (117,'Kishangarh','Kishangarh - approximately 60 km from Sambhar Lake, is a town known for its artistic heritage and the Kishangarh Fort. The town is famous for its traditional miniature paintings and vibrant local culture.
The Kishangarh Fort, with its architectural grandeur and historical importance, and the nearby Phool Mahal (Flower Palace) are key attractions.',39),
 (118,'Mahi Dam','The Mahi Dam - approximately 20 km from Banswara, is a large reservoir built across the Mahi River, providing a scenic and serene environment. It is an important site for water conservation and irrigation, and it also offers recreational opportunities.
The dam’s picturesque surroundings, including lush greenery and calm waters, make it a popular spot for picnics and nature walks. The panoramic views from the dam are particularly beautiful, especially during the monsoon season.',40),
 (119,'Chakrarath Temple','The Chakrarath Temple - approximately 30 km from Banswara, is an ancient Hindu temple dedicated to Lord Vishnu. It is known for its architectural beauty and historical significance, with intricate carvings and a tranquil atmosphere.
The temple’s elaborate carvings and serene setting offer a peaceful retreat and a glimpse into the region’s spiritual heritage. The temple is also an important pilgrimage site for local devotees.',40),
 (120,'Tripura Sundari Temple','The Tripura Sundari Temple - approximately 45 km from Banswara, located in the village of Tripura, is a significant Hindu temple dedicated to Goddess Tripura Sundari, a revered deity in the local tradition. The temple is known for its religious importance and architectural style.
The temple’s unique architecture, combined with its spiritual ambiance, makes it a notable attraction. The site is also a focal point for local festivals and religious ceremonies, providing insight into regional spiritual practices.',40),
 (121,'Mewar Historical Library','Located in the town of Rajsamand - approximately 25 km from Kumbhalgarh Fort, the Mewar Historical Library houses a significant collection of manuscripts, historical documents, and rare books related to the history and culture of Mewar. It offers valuable insights into the region''s rich heritage.The library''s collection includes ancient manuscripts and texts that provide a deep understanding of Rajput history and culture. It is an excellent resource for history enthusiasts and researchers.',41),
 (122,'Haldighati','Haldighati - approximately 40 km from Kumbhalgarh Fort, is a historic site known for the famous Battle of Haldighati fought in 1576 between Maharana Pratap and the Mughal emperor Akbar. The area features a museum and memorial dedicated to this significant battle.
The Haldighati Museum offers exhibits related to the battle and Maharana Pratap, providing a vivid recount of the historical conflict. The site also includes a memorial to Maharana Pratap and his horse, Chetak, commemorating their bravery.',41),
 (123,'Ranakpur Jain Temple','The Ranakpur Jain Temple - approximately 90 km from Kumbhalgarh Fort, is a stunning 15th-century Jain temple dedicated to Tirthankara Adinatha. Known for its intricate marble carvings and architectural splendor, it is a significant pilgrimage site for Jain devotees.
The temple''s unique design features over 1,400 intricately carved marble pillars, each uniquely decorated. The serene ambiance and detailed craftsmanship make it a remarkable example of Jain architecture.',41),
 (124,'Netravali Wildlife Sanctuary','Netravali Wildlife Sanctuary - approximately 10 km from Salaulim Dam, is a lush green sanctuary located in South Goa, known for its rich biodiversity, dense forests, and natural beauty. It is home to a variety of wildlife, including leopards, black panthers, and a wide range of bird species.
The sanctuary is popular for its trekking trails and the famous Netravali bubbling lake, where natural gases cause water bubbles to rise to the surface, creating a unique sight. It is an ideal spot for nature enthusiasts and bird watchers.',42),
 (125,'Tambdi Surla Temple','The Tambdi Surla Temple - approximately 30 km from Salaulim Dam, is a 12th-century Shiva temple built in the Kadamba architectural style. It is the oldest temple in Goa that has survived the ravages of time and remains a significant religious and historical site.
Surrounded by the dense jungles of the Bhagwan Mahavir Wildlife Sanctuary, the temple is renowned for its intricate carvings and serene setting. It provides a unique glimpse into Goa’s ancient history and architectural heritage.',42),
 (126,'Bhagwan Mahavir Wildlife Sanctuary and Mollem National Park','This sanctuary and national park, located in the foothills of the Western Ghats - approximately 35 km from Salaulim Dam, is the largest wildlife preserve in Goa. It is known for its diverse flora and fauna, including Bengal tigers, leopards, elephants, and rare bird species.
The sanctuary offers lush greenery, stunning waterfalls like Dudhsagar, and numerous trekking routes. The Dudhsagar Waterfall, one of the highest in India, is a must-see attraction, drawing nature lovers and adventure seekers alike.',42),
 (127,'Agonda Beach','Agonda Beach - approximately 10 km from Cola Beach, is a serene and picturesque beach known for its golden sands, gentle waves, and tranquil atmosphere. It is ideal for those looking to relax and enjoy the natural beauty of Goa away from the crowded beaches.
The beach is perfect for swimming, sunbathing, and yoga sessions. It is also a designated nesting site for Olive Ridley sea turtles, offering a unique opportunity to witness these creatures during the nesting season.',43),
 (128,'Palolem Beach','Palolem Beach - approximately 20 km from Cola Beach, is a popular destination known for its crescent-shaped shoreline, calm waters, and lively atmosphere. It offers various water sports, boat trips to spot dolphins, and a vibrant nightlife scene.
The beach’s calm waters make it ideal for swimming and kayaking. Its lively ambiance, with numerous beachside shacks and cafes, provides a blend of relaxation and entertainment, catering to diverse preferences.',43),
 (129,'Cotigao Wildlife Sanctuary','Cotigao Wildlife Sanctuary - approximately 35 km from Cola Beach, is the second-largest wildlife sanctuary in Goa, known for its dense forests, towering trees, and rich biodiversity. It provides a unique opportunity to explore the region''s natural beauty and wildlife.
The sanctuary offers nature trails, watchtowers for wildlife spotting, and a serene environment ideal for birdwatching and trekking. It’s a great destination for nature lovers looking to experience Goa''s less commercialized, natural side.',43),
 (130,'Cabo de Rama Fort','Cabo de Rama Fort - approximately 2 km from Cabo de Rama Beach, is a historical fort perched on a hill overlooking the Arabian Sea. Built by the Portuguese in the 16th century, it offers stunning panoramic views and has been a significant military outpost throughout its history.
The fort provides breathtaking views of the coastline and sea, making it an ideal spot for photography and sunset watching. The fort’s ruins, old cannons, and chapel reflect its historical importance and colonial architecture.',44),
 (131,'Betul Beach','Betul Beach - approximately 10 km from Cabo de Rama Beach, is a charming and relatively secluded beach with a quiet atmosphere. It’s known for its scenic beauty and is a great spot for experiencing traditional Goan coastal life.
The beach is ideal for a peaceful escape, with fewer crowds and a picturesque setting. The nearby Betul River offers opportunities for river cruises and exploration.',44),
 (132,'Dudhsagar Waterfalls','Dudhsagar Waterfalls - approximately 45 km from Cabo de Rama Beach, is one of India’s highest and most impressive waterfalls, located on the Mandovi River. It is surrounded by dense forests and offers a spectacular sight of cascading water.
The four-tiered waterfall is a popular spot for trekking and adventure. The impressive height and volume of water, especially during the monsoon season, make it a must-visit destination for nature lovers and adventure seekers.',44),
 (133,'Bambolim Beach','Bambolim Beach - approximately 15 km from Devil’s Finger Cave, is a tranquil and less crowded beach located near the capital city of Panaji. It is known for its gentle waves and serene environment, making it ideal for a peaceful retreat.
The beach offers a calm atmosphere with scenic views of the Arabian Sea and is a great spot for relaxation and leisurely walks. It’s a good choice for those seeking a quiet beach experience away from the busier tourist areas.',45),
 (134,'Miramar Beach','Miramar Beach - approximately 20 km from Devil’s Finger Cave, is a popular urban beach situated near Panaji. It is known for its wide sandy stretch and vibrant atmosphere, with various eateries and entertainment options.
The beach’s lively ambiance, combined with beautiful sunset views, makes it a popular spot for locals and tourists. It’s ideal for evening strolls, casual dining, and enjoying the bustling beach environment.',45),
 (135,'Chorla Ghat','Chorla Ghat -  approximately 30 km from Devil’s Finger Cave, is a picturesque mountain pass located in the Western Ghats, known for its lush greenery, waterfalls, and diverse flora and fauna. It is a popular destination for nature lovers and trekkers.
The ghat offers stunning views of the surrounding hills and valleys, as well as opportunities for trekking and nature exploration. The area is rich in biodiversity and provides a serene escape into the natural beauty of Goa’s highlands.',45),
 (136,'Tambdi Surla Temple','Tambdi Surla Temple - approximately 20 km from Sanguem Village, is an ancient 12th-century Shiva temple located in the Bhagwan Mahavir Wildlife Sanctuary. It is known for its intricate Kadamba architecture and historical significance.
The temple’s architectural beauty and serene setting amidst the sanctuary make it a notable historical and cultural site. Visitors can explore the temple''s detailed carvings and enjoy the surrounding natural beauty.',46),
 (137,'Bhagwan Mahavir Wildlife Sanctuary','Bhagwan Mahavir Wildlife Sanctuary - approximately 25 km from Sanguem Village, is the largest wildlife preserve in Goa, home to a diverse range of flora and fauna, including Bengal tigers, leopards, and various bird species.
The sanctuary offers numerous trekking trails, bird-watching opportunities, and the stunning Dudhsagar Waterfall. The diverse ecosystems within the sanctuary provide a rich experience for nature enthusiasts and wildlife photographers.',46),
 (138,'Dudhsagar Waterfalls','Dudhsagar Waterfalls - approximately 30 km from Sanguem Village, is one of India’s highest and most spectacular waterfalls, cascading down from a height of 310 meters. It is located within the Bhagwan Mahavir Wildlife Sanctuary.
The waterfall’s grandeur and the surrounding lush green landscape make it a popular destination for trekking and photography. The falls are especially impressive during the monsoon season when the water flow is at its peak.',46),
 (139,'Canacona Market','Canacona Market - approximately 10 km from Butterfly Beach, is a local market offering a variety of goods, including fresh produce, local handicrafts, and souvenirs. It provides a glimpse into the local culture and daily life of the Goan community.
The market is a great place to experience local life, shop for traditional Goan items, and sample local street food.',47),
 (140,'Netravali Wildlife Sanctuary','Netravali Wildlife Sanctuary - approximately 35 km from Butterfly Beach, is known for its rich biodiversity, including dense forests, diverse wildlife, and the unique Netravali bubbling lake.
The sanctuary offers trekking trails, bird-watching opportunities, and the chance to see rare species of flora and fauna. The bubbling lake is a fascinating natural phenomenon where gases create bubbles in the water.',47),
 (141,'Cotigao Wildlife Sanctuary','Cotigao Wildlife Sanctuary - approximately 40 km from Butterfly Beach, is one of Goa’s largest wildlife sanctuaries, known for its dense forests and rich wildlife. It is a haven for nature lovers and wildlife enthusiasts.
The sanctuary offers walking trails, watchtowers for wildlife spotting, and a peaceful environment for observing nature. It’s an excellent location for bird-watching and exploring Goa’s natural landscape.',47),
 (142,'Living Root Bridges','The Living Root Bridges - approximately 25 km from Mawlynnong, are a series of traditional bridges made from the roots of rubber trees, skillfully guided and nurtured by local Khasi people. These natural bridges span across streams and rivers, showcasing an extraordinary example of eco-engineering and sustainable living.
The root bridges, especially the double-decker bridge in Nongriat, are renowned for their unique construction and durability. They offer a fascinating insight into the ingenuity of traditional Khasi craftsmanship and provide picturesque settings for visitors.',48),
 (143,'Dawki','Dawki - approximately 40 km from Mawlynnong, is a picturesque town situated near the Bangladesh border, known for the Umngot River, which is famous for its crystal-clear waters. The river creates an illusion of floating boats due to its transparency, making it a popular spot for boating and photography.
The transparent waters of the Umngot River are a major attraction, providing stunning views and a unique boating experience. The surrounding landscape and the river’s clarity make it a must-visit for nature enthusiasts.',48),
 (144,'Shillong','Shillong - approximately 80 km from Mawlynnong, the capital of Meghalaya, is a vibrant hill station known for its pleasant climate, colonial architecture, and scenic beauty. It offers a range of attractions including lakes, waterfalls, and gardens.
Key attractions in Shillong include the Umiam Lake, Shillong Peak, and Elephant Falls. The city''s blend of natural beauty, cultural heritage, and urban charm provides a diverse experience for visitors.',48),
 (145,'Laitlum Canyons','Laitlum Canyons - approximately 30 km from Mawphlang Sacred Forest, is a stunning natural landscape characterized by deep gorges, rolling hills, and panoramic views of the surrounding valleys. It offers a breathtaking vantage point for viewing the rugged terrain and lush greenery of the region.
The canyons provide spectacular viewpoints that are perfect for photography and nature walks. The expansive vistas and serene environment make it a popular destination for those seeking tranquility and natural beauty.',49),
 (146,'Elephant Falls','Elephant Falls - approximately 40 km from Mawphlang Sacred Forest, is a picturesque waterfall located near Shillong. The falls are named for a rock formation resembling an elephant, which has since eroded. The cascading waters and lush surroundings create a serene and scenic spot.
The multi-tiered waterfall and the surrounding verdant landscape offer excellent opportunities for photography and relaxation. The falls are accessible via a short trek, making them a popular spot for visitors exploring the Shillong area.',49),
 (147,'Shillong Peak','Shillong Peak - approximately 40 km from Mawphlang Sacred Forest, is the highest point in Shillong, offering panoramic views of the city and the surrounding hills. It is a popular vantage point for enjoying the breathtaking landscapes of Meghalaya.
The peak provides a sweeping view of Shillong and the distant plains of Bangladesh. The clear skies and scenic vistas make it an ideal location for sightseeing and experiencing the natural beauty of the region.',49),
 (148,'Nohkalikai Falls','Nohkalikai Falls - approximately 35 km from Ranikor, is one of the tallest waterfalls in India, cascading from a height of about 1115 feet. It is located near Cherrapunji and is renowned for its stunning beauty and the legend associated with it.
The falls are particularly impressive during the monsoon season when the water flow is at its peak. The lush surroundings and the drop into a deep pool create a dramatic and picturesque setting, making it a popular spot for photography and sightseeing.',50),
 (149,'Mawsmai Cave','Mawsmai Cave - approximately 40 km from Ranikor, is a popular limestone cave located near Cherrapunji. It features impressive stalactites and stalagmites formations and is a key attraction for those interested in exploring natural cave systems.
The cave''s intricate mineral formations and the underground passageways offer a fascinating experience for visitors. The well-lit pathways make it accessible for tourists and enhance the exploration of the cave''s natural wonders.',50),
 (150,'Dawki','Dawki - approximately 55 km from Ranikor, is a scenic town known for the Umngot River, famous for its crystal-clear waters. The town is close to the Bangladesh border and is known for its beautiful river cruises and picturesque landscapes.
The clear waters of the Umngot River create an illusion of floating boats, making it a unique and popular destination for boating and photography. The surrounding landscape, with its serene environment, adds to the charm of the area.',50),
 (151,'Laitlum Canyons','Laitlum Canyons - approximately 20 km from the Garden of Caves, is a dramatic landscape featuring deep gorges and panoramic views of the surrounding hills. The area is renowned for its breathtaking natural beauty and is a popular spot for trekking and sightseeing.
The canyons provide stunning vistas of the rolling hills and valleys, making it an ideal location for photography and nature walks. The expansive views and serene environment make it a must-visit for nature enthusiasts.',51),
 (152,'Elephant Falls','Elephant Falls - approximately 30 km from the Garden of Caves, is a picturesque waterfall located near Shillong, known for its multi-tiered cascade and lush surroundings. The falls are named after a rock formation that once resembled an elephant.
The waterfall’s multiple tiers and the verdant landscape create a scenic and tranquil setting. It is a popular destination for visitors seeking natural beauty and a peaceful retreat.',51),
 (153,'Shillong Peak','Shillong Peak - approximately 35 km from the Garden of Cave, is the highest point in Shillong, offering panoramic views of the city and the surrounding areas. It provides a stunning vantage point for observing the natural beauty of Meghalaya.
The peak offers expansive views of Shillong and the distant plains of Bangladesh. The clear vistas and serene atmosphere make it an excellent spot for sightseeing and experiencing the region’s natural splendor.',51),
 (154,'Shnongpdeng','Shnongpdeng - approximately 10 km from Dawki River, is a scenic village located along the Umngot River, known for its pristine riverbanks and beautiful landscapes. It offers a tranquil environment and is popular for river activities such as boating and camping.
The village provides stunning views of the crystal-clear waters of the Umngot River and opportunities for serene river cruises and camping. The calm and picturesque setting makes it an ideal spot for relaxation and nature enthusiasts.',52),
 (155,'Jaflong','Jaflong - approximately 15 km from Dawki River, is a small town located near the Dawki River, known for its scenic beauty and the serene river environment. It is situated on the India-Bangladesh border and offers unique views of the river and the surrounding landscape.
The area around Jaflong offers beautiful views of the river and the lush green landscape. It is also a great spot for photography and exploring the natural beauty of the border region.',52),
 (156,'Cherrapunji','Cherrapunji- approximately 60 km from Dawki River, one of the wettest places on Earth, is renowned for its lush landscapes, numerous waterfalls, and dense forests. It is famous for attractions such as the Nohkalikai Falls and Mawsmai Cave.
The natural beauty of Cherrapunji, including its waterfalls and caves, provides a stunning contrast to the river’s crystal-clear waters. The area offers a range of outdoor activities and breathtaking views, making it a popular destination for travelers seeking diverse natural experiences.',52),
 (157,'Nongriat Village','Nongriat Village - approximately 25 km from Laitkynsew, is famous for its living root bridges, a unique example of traditional Khasi engineering. These bridges are crafted from the roots of rubber trees and are an integral part of the village’s landscape.
The double-decker living root bridge in Nongriat is particularly notable for its impressive construction and beauty. The hike to the village and the bridges offers a memorable experience, showcasing the ingenuity and harmony between the Khasi people and their environment.',53),
 (158,'Mawsmai Cave','Mawsmai Cave - approximately 30 km from Laitkynsew, is a popular limestone cave near Cherrapunji, featuring stunning stalactites and stalagmites formations. It is known for its extensive cave system and natural underground beauty.
The cave’s unique mineral formations and well-lit pathways make it a fascinating site for exploration. The cave’s natural beauty and geological significance provide a captivating experience for visitors interested in spelunking and natural wonders.',53),
 (159,'Nohkalikai Falls','Nohkalikai Falls - approximately 17 km from Laitkynsew, is one of the tallest waterfalls in India, with water cascading from a height of about 1115 feet. It is surrounded by lush forests and cliffs, offering a breathtaking view, especially during the monsoon season.
The stunning height and force of the waterfall, along with the deep emerald pool it forms at the bottom, make it a spectacular natural sight and a prime location for photography.',53),
 (160,'Suruli Falls','Suruli Falls - approximately 35 km from Meghamalai, is a stunning 2-tiered waterfall that cascades down from a height of 150 feet. It is located in the Western Ghats and is surrounded by dense forests and lush greenery. The falls are also known for their medicinal properties, as the water flows through forests filled with herbs.
A popular spot for picnics and nature walks, Suruli Falls offers an opportunity to enjoy the natural beauty and take a refreshing dip in its cool waters.',54),
 (161,'Vaigai Dam','The Vaigai Dam - around 45 km from Meghamalai, built across the Vaigai River, is a significant source of irrigation for the region and a popular picnic spot. The dam''s scenic surroundings, lush gardens, and children’s park make it a favored location for visitors.
The scenic beauty around the dam and the serene environment make it a great spot for relaxation, photography, and picnics.',54),
 (162,'Bodinayakkanur','Known as the "Cardamom Capital of India" - approximately 25 km from Meghamalai, Bodinayakkanur is famous for its spice plantations, especially cardamom and pepper. It is also a gateway to Meghamalai and offers stunning views of the Western Ghats.
Visitors can explore spice plantations, enjoy local produce, and experience the vibrant local markets and cultural heritage of this small town.',54),
 (163,'Amirthi Zoological Park','A small zoological park and mini-zoo located near Vellore - approximately 30 km from Javadi Hills, Amirthi Zoological Park is known for its diverse flora and fauna. It features a small waterfall, trekking trails, and picnic spots.
Ideal for a family outing, the park offers a chance to see a variety of animals, including deer, peacocks, and monkeys, while enjoying the serene surroundings.',55),
 (164,'Yelagiri Hills','A popular hill station in the Vellore district - About 55 km from Javadi Hills, Yelagiri Hills is known for its pleasant climate, orchards, rose gardens, and green valleys. It is an excellent spot for trekking, paragliding, and other adventure activities.
Explore the Swamimalai Hill, enjoy boating at Punganur Lake, and visit the Jalagamparai Waterfalls. It’s a great destination for adventure sports and nature lovers.',55),
 (165,'Gingee Fort','Known as the "Troy of the East" - around 70 km from Javadi Hills, Gingee Fort is an ancient fortification dating back to the Chola dynasty. It is one of the most impregnable forts in India, featuring impressive architecture, three hilltop citadels, and numerous temples and structures.
Climb to the top of the fort for panoramic views, explore the historic ruins, and learn about the fort''s rich history.',55),
 (166,'Aliyar Dam','Aliyar Dam - approximately 40 km from Valparai, is a popular picnic spot and reservoir located at the foothills of the Anamalai Hills. The dam is surrounded by a beautifully landscaped garden, making it a perfect place for family outings and nature walks.
Enjoy boating on the reservoir, visit the park, or relax while soaking in the scenic views of the surrounding hills and forests.',56),
 (167,'Monkey Falls','Monkey Falls - about 30 km from Valparai, is a charming natural waterfall situated on the Pollachi-Valparai road. The falls cascade from a height of about 60 feet, surrounded by lush green forests and offering a refreshing spot to cool off during a trip.
A popular stop for tourists, Monkey Falls is ideal for a quick dip, picnics, and photography amidst nature.',56),
 (168,'3.	Indira Gandhi Wildlife Sanctuary and National Park','This sanctuary, also known as Anamalai Tiger Reserve - Around 20 km from Valparai, is one of the most important protected areas in the Western Ghats. It is home to a variety of wildlife, including tigers, elephants, leopards, gaur, and many bird species.
Go for a safari, guided treks, or bird-watching tours to experience the rich biodiversity and explore the dense forests of the Western Ghats.',56),
 (169,'Darasuram','Drasauram - About 4 km from Kumbakonam, is home to the Airavatesvara Temple, another UNESCO World Heritage Site, renowned for its exquisite stone carvings and intricate architectural details. This 12th-century temple is dedicated to Lord Shiva and exemplifies Chola architecture.
Marvel at the temple''s intricate sculptures, the stunning stone chariot, and the grandeur of Chola art. It’s a must-visit for history buffs and architecture enthusiasts.',57),
 (170,'Swamimalai','Swamimalai - Around 8 km from Kumbakonam, is a sacred pilgrimage site, home to one of the six abodes (Arupadai Veedu) of Lord Murugan. The Swaminatha Swamy Temple, located on a small hillock, is a significant spiritual center and attracts numerous devotees.
Visit the hilltop temple, experience the spiritual ambiance, and enjoy panoramic views of the surrounding countryside.',57),
 (171,'Gangaikonda Cholapuram','Built by Rajendra Chola I- Approximately 35 km from Kumbakonam, Gangaikonda Cholapuram is a historic city that once served as the Chola capital. The Brihadeeswarar Temple here is an architectural masterpiece, reflecting the grandeur of the Chola Empire.
Explore the temple''s stunning architecture, majestic sculptures, and learn about the rich history of the Chola dynasty.',57),
 (172,'Chidambaram Nataraja Temple','A famous Hindu temple dedicated to Lord Shiva - Approximately 15 km from Pichavaram, known for its Dravidian architecture, exquisite carvings, and ancient cultural heritage. The temple is an important pilgrimage site and is renowned for its annual dance festivals and rituals.
Explore the temple''s grand architecture, the stunning Nataraja idol, and participate in the daily rituals. The temple is also known for its spiritual ambiance and historical significance.',58),
 (173,'Thillai Kali Amman Temple','Located near the Chidambaram Nataraja Temple- About 13 km from Pichavaram, Thillai Kali Amman Temple is dedicated to Goddess Kali, believed to have been built by Chola kings. The temple is noted for its unique idol of Goddess Kali in a ferocious form.
Visit the temple to experience the divine ambiance, explore its historical significance, and witness local traditions and rituals associated with Goddess Kali.',58),
 (174,'Poompuhar (Kaveripoompattinam)','An ancient port city that served as a major center for trade and commerce during the Chola dynasty. Poompuhar - Around 40 km from Pichavaram, is known for its historical monuments, sculptures, and the reconstructed Silappathikara Art Gallery.
Explore the ruins of the ancient city, visit the art gallery, and learn about the maritime history and cultural heritage of the Chola period.',58),
 (175,'Tiruchendur Murugan Temple','A significant Hindu pilgrimage site dedicated to Lord Murugan, situated on the shores of the Bay of Bengal - approximately 18 km from Manapad.
The temple is one of the six abodes of Murugan and is renowned for its unique coastal location, ancient architecture, and spiritual ambiance.
Visit to witness the beautiful sea-facing temple, participate in daily rituals, and enjoy the panoramic view of the ocean from the temple premises.',59),
 (176,'Panchalankurichi Fort','A historic fort that was the seat of the legendary warrior Veerapandiya Kattabomman, who fought against the British East India Company in the 18th century. The fort and its museum showcase artifacts and memorabilia related to the freedom struggle.
Visit the fort to learn about the heroic deeds of Kattabomman, explore the ruins, and enjoy the scenic views of the surrounding countryside.
It is approximately 50 km from Manapad.',59),
 (177,'Manimuthar Waterfalls','A picturesque waterfall located in the Western Ghats - Around 80 km from Manapad, known for its serene environment and scenic beauty. The falls are a popular spot for picnics, trekking, and nature walks.
Enjoy the natural beauty of the waterfall, take a refreshing dip in the clear waters, and explore the surrounding forest area.',59);
INSERT INTO "app_place" ("id","place_name","story","image1","image2","image3","state_id") VALUES (1,'Gurez Valley','Gurez Valley, also known as Gurais Valley, is one of the most picturesque and least explored regions in Jammu and Kashmir. Nestled in the high Himalayas, about 123 kilometers from Srinagar, Gurez Valley lies along the Kishanganga River. The valley is characterized by its lush meadows, dense forests, snow-capped peaks, and the unique cultural heritage of the Dard-Shin people who inhabit the region.','media/Gurez_Valley1_3XTPdZE.jpg','media/Gurez_Valley2_ADKhRqp.jpg','media/Gurez_Valley_3_lE21H1m.jpg',4),
 (2,'Tarsar Marsar','The Tarsar Marsar trek in Jammu and Kashmir is one of the most beautiful and serene treks in the region, known for its stunning alpine lakes, lush meadows, and breathtaking landscapes. The trek is named after two high-altitude lakes, Tarsar and Marsar, which are nestled in the Aru Valley of the Anantnag district.','media/Tarsar_Marsar1.jpg','media/Tarsar_Marsar2.jpg','media/Tarsar_Marsar3.jpg',4),
 (3,'Sanasar','Sanasar, a beautiful hill station in Jammu and Kashmir, is named after the two local lakes, Sana and Sar. Situated about 20 kilometers from Patnitop, Sanasar offers stunning landscapes, adventure activities, and a peaceful environment.','media/Sanasar1.jpg','media/Sanasar2.jpg','media/Sanasar3.jpg',4),
 (4,'Chatpal','Chatpal is a lesser-known but stunningly beautiful destination in Jammu and Kashmir, often referred to as the "hidden gem" of the region. Located in the Anantnag district, Chatpal is part of the Kashmir Valley and is known for its pristine natural beauty, lush meadows, dense forests, and clear streams.','media/Chatpal1.jpg','media/Chatpal2.jpg','media/Chatpal3.jpg',4),
 (5,'Bhaderwah','Bhaderwah, often referred to as "Mini Kashmir" or the "Switzerland of India," is a picturesque town in the Doda district of Jammu and Kashmir. Known for its stunning landscapes, rich cultural heritage, and historical significance, Bhaderwah is a hidden gem waiting to be explored.','media/Bhaderwah1.jpg','media/Bhaderwah2.jpg','media/Bhaderwah3.jpg',4),
 (6,'Pari Mahal','Pari Mahal, also known as the "Palace of Fairies," is a historical monument and a beautiful terraced garden located on the Zabarwan mountain range overlooking Dal Lake in Srinagar, Jammu and Kashmir. This stunning structure combines Islamic architecture with Persian influences and holds a significant place in the region''s history.','media/Pari_Mahal1.jpg','media/Pari_Mahal2.jpg','media/Pari_Mahal3.jpg',4),
 (7,'Girmal Waterfall','This waterfall extends to a height of up to 100 feet, making it the highest waterfall of Gujarat. The picturesque beauty of this site makes it popular among visitors and people of the region alike. The water swiftly falls from a great height, creating a fog like condition that’s eye catching.','media/Girmal_Waterfall1.jpg','media/Girmal_Waterfall2.jpg','media/Girimal_Waterfall_3.jpg',6),
 (8,'Bechtel beach','Bechtel Beach, also known as Bechtel Sea Beach, is a relatively lesser-known yet picturesque coastal spot located near Dwarka in Gujarat. Dwarka, one of the most significant pilgrimage sites in India, is known for its ancient temples and rich mythology associated with Lord Krishna. Bechtel Beach, though not as famous as other beaches in Gujarat, offers a tranquil and scenic retreat for visitors.','media/Bechtel_beach1.jpg','media/Bechtel_Beach_2.jpg','media/Bechtel_Beach_3.jpg',6),
 (9,'Kadiya Dhro','Kadiya Dhro, situated in the Kutch region of Gujarat, is a fascinating geological formation and a relatively lesser-known natural attraction. The term "Kadiya Dhro" roughly translates to "Valley of Rocks" in the local language, highlighting its unique geological features. Here is an in-depth look at the history and backstory of Kadiya Dhro','media/Kadiya_Dhro1.jpg','media/Kadiya_Dhro_2.jpg','media/Kadiya_Dhro_3.jpg',6),
 (10,'Wilson Hill','Wilson Hill, located near Valsad in Gujarat, is one of the few hill stations in the state and offers a serene escape with picturesque landscapes. The hill station, perched at an elevation of around 750 meters (2,460 feet) above sea level, is named after Lord Wilson, a former Governor of Bombay during the British colonial period.','media/Wilson_Hill_1.jpg','media/Wilson_Hill_2.jpg','media/Wilson_Hill_3.jpg',6),
 (11,'Polo forest','Polo Forest, also known as Vijaynagar Forest, is a captivating and historically rich area located near Idar in the Sabarkantha district of Gujarat. This forested region, covering approximately 400 square kilometers, is a hidden gem offering a mix of natural beauty, ancient ruins, and cultural heritage.','media/Polo_Forest1.jpg','media/Polo_Forest_2.jpg','media/Polo_Forest_3.jpg',6),
 (12,'Bekal Fort','Bekal Fort was constructed in 1650 AD by Shivappa Nayaka of the Keladi Nayaka dynasty. Later, it came under the control of Tipu Sultan of Mysore before being captured by the British East India Company in 1799.','media/Bekal_Fort1.png','media/Bekal_Fort2.png','media/Bekal_Fort3.png',18),
 (13,'Jatayu Earth''s Center','Jatayu''s Heroism: According to the Ramayana, Jatayu fought bravely against Ravana to protect Sita. The center commemorates this act of heroism and sacrifice, making it a site of cultural and mythological significance.
Legend: It is believed that Jatayu fell on the rocks at Chadayamangalam after being wounded by Ravana, marking the spot as a sacred and historic site.','media/Jatayu_Earths_Center3.png','media/Jatayu_Earths_Center1.png','media/Jatayu_Earths_Center2.png',18),
 (14,'Kappad Beach','Kappad Beach is renowned for being the place where Vasco da Gama, the Portuguese explorer, first landed in India on May 20, 1498, along with 170 men. This event marked the beginning of the European colonial era in India and opened the sea route from Europe to India.','media/Kappad_Beach1.png','media/Kappad_Beach2.png','media/Kappad_Beach3.png',18),
 (15,'Edappally Church Complex','The Edappally Church Complex, also known as St. George''s Syro-Malabar Forane Church, is one of the oldest and most significant Christian pilgrimage centers in Kerala. It is renowned for its historical and architectural importance, drawing thousands of devotees and tourists.','media/Edappally_Church_Complex1.png','media/Edappally_Church_Complex2.png','media/Edappally_Church_Complex3.png',18),
 (16,'Ramakkalmedu','Ramakkalmedu is a renowned hill station and a popular tourist destination in Kerala. It is known for its panoramic views, mythological significance, and wind energy farms.','media/Ramakkalmedu1.png','media/Ramakkalmedu2.png','media/Ramakkalmedu3.png',18),
 (17,'Anchuthengu and Anjengo Fort','Anchuthengu: Anchuthengu is a coastal town known for its historical significance and beautiful beach. The name "Anchuthengu" means "Five Coconut Trees," referring to the trees that were once prominent in the area.
Anjengo Fort: The fort is a significant historical landmark built by the British East India Company in the 17th century. It is often referred to as Anjengo Fort or Anchuthengu Fort.','media/Anchuthengu_and_Anjengo_Fort1.png','media/Anchuthengu_and_Anjengo_Fort2.png','media/Anchuthengu_and_Anjengo_Fort3.png',18),
 (18,'Dhanaulti Hill station','Dhanaulti is a hill station located in the Tehri Garhwal district of Uttarakhand, India. It sits at an elevation of approximately 2,286 meters (7,500 feet) and is situated about 25 km from the popular hill station of Mussorie.','media/Dhanaulti.jpg','media/Dhanaulti_hill_station_2.jpg','media/Dhanaulti_3.jpg',5),
 (19,'Lansdowne','Lansdowne is a hill station in the Pauri Garhwal district of Uttarakhand, India. It is situated at an elevation of about 1,700 meters (5,600 feet) and is approximately 250 km from Delhi.','media/Lansdowne.jpg','media/Lansdowne_2.jpg','media/Lansdowne_3.jpg',5),
 (20,'Chaukori hill station','Chaukori is a serene hill station located in the Pithoragarh district of Uttarakhand, India. It is situated at an elevation of about 2,010 meters (6,590 feet) and is known for its panoramic views of the Himalayan ranges.','media/chaukori_hill_station.jpg','media/Chaukori_2.jpg','media/Chaukori_3.jpeg.jpg',5),
 (21,'Nelong valley','Nelong Valley is a remote and picturesque valley located in the Uttarkashi district of Uttarakhand, India. Situated at an altitude of approximately 3,600 meters (11,800 feet), it is known for its stunning landscapes and high-altitude environment.','media/Nelong_valley.jpg','media/nelong_valley_2.jpg','media/nelong_valley_3.jpeg.jpg',5),
 (22,'Harsil valley','Harsil is a picturesque valley situated in the Uttarkashi district of Uttarakhand, India. It is located at an elevation of approximately 2,620 meters (8,600 feet) and lies along the Bhagirathi River. Harsil is approximately 75 km from the town of Uttarkashi.','media/harsil_3_GH0VeZv.jpg','media/harsil_2.jpg','media/Harsil_valley_nGqIwvw.jpg',5),
 (23,'Chamoli','Chamoli is a prominent town in the Chamoli district of Uttarakhand, India, situated at an elevation of approximately 1,600 meters (5,250 feet). It is located in the northern part of the state, nestled in the foothills of the Himalayas.','media/chamoli_W0kzJIz.jpg','media/Chamoli_2.jpg','media/chamoli_3_aZNiuIU.jpg',5),
 (24,'Devaramane Hill','Devaramane Hills is a hidden gem located in the Mudigere Taluk of the Chikkamagaluru district in Karnataka, India. Situated at an elevation of approximately 1,700 meters (5,577 feet) above sea level, this serene location offers breathtaking views of the Western Ghats.','media/devaramane_hill_2.jpg','media/Devaramane.jpg','media/Devaramane-Hills_3.jpg',16),
 (25,'Kalasa town','Kalasa is a small town located in the Chikkamagaluru district of Karnataka, India. Situated in the Western Ghats at an altitude of approximately 800 meters (2,600 feet), Kalasa is nestled along the banks of the River Bhadra and is surrounded by lush greenery and coffee plantations.','media/kalasa_town_3.jpg','media/kalasa_town_2.jpg','media/kalasa_town.jpg',16),
 (26,'Sasihitlu beach','Sasihitlu Beach is a pristine and lesser-known beach located near the village of Sasihitlu in the Mangaluru district of Karnataka, India. It is about 20 kilometers from the city center of Mangaluru and is where the Nandini River meets the Arabian Sea.','media/sashithlu-beach_3.jpg','media/sasihitlu-beach.png','media/sasihitlu_beach_2.jpg',16),
 (27,'Kemmangundi Hill station','Kemmangundi is a picturesque hill station located in the Chikkamagaluru district of Karnataka, India. Situated at an elevation of about 1,434 meters (4,704 feet) above sea level, it is surrounded by lush greenery, rolling hills, and cascading waterfalls, making it a popular yet serene getaway.','media/kemmangundi__hillstation_2.jpeg.jpg','media/kemmangundi_hillstation_3.jpg','media/kemmangundi_hillstation.jpg',16),
 (28,'Honnemaradu','Honnemaradu is a small village located on the backwaters of the Sharavathi River, near the Linganamakki Reservoir in the Sagara Taluk of Shivamogga district, Karnataka. The name "Honnemaradu" translates to "Golden Lake," inspired by the golden reflection of the sun on the waters of the reservoir.','media/honnemaradu_2.jpg','media/honnemaradu_3.jpg','media/HONNEMARADU.jpg',16),
 (29,'Kavledurga fort','Kavaledurga Fort is located in the Western Ghats, about 18 kilometers from Thirthahalli in the Shivamogga district of Karnataka. Perched at an elevation of around 1,541 meters, the fort offers panoramic views of the surrounding landscape, including dense forests, rolling hills, and distant water bodies.','media/kavaledurga_fort_2.jpg','media/kavaledurga_fort_3.jpg','media/kavaledurga-fort.jpg',16),
 (30,'Hatu peak Narkanda','Hatu Peak is located in the Narkanda region of Himachal Pradesh, India. It stands at an elevation of about 3,400 meters (11,155 feet) and offers panoramic views of the surrounding Himalayan ranges.','media/hatu-peak_2.jpg','media/Hatu-Peak-Trek-narkanda.jpg','media/hatu_peak_3.jpg',3),
 (31,'Chitkul','Chitkul is a small village in the Sangla Valley of Himachal Pradesh, situated at an elevation of approximately 3,450 meters (11,319 feet). It is the last inhabited village on the Indian side near the Indo-Tibetan border.','media/Chitkul_village.jpg','media/chitkul_3.jpg','media/chitkul_2.jpg',3),
 (32,'Pabbar valley','Pabbar Valley is located in the Shimla district of Himachal Pradesh, India. It is situated along the Pabbar River and is part of the larger Sutlej River basin. The valley lies at an elevation of around 2,500 to 3,000 meters (8,200 to 9,800 feet).','media/pabbar_valley_3.jpg','media/pabbar_valley_2.jpg','media/-pabbar-alley-trek.jpg',3),
 (33,'Shangarh','Shangarh is a small village located in the Sainj Valley of the Kullu district in Himachal Pradesh, India. Situated at an elevation of about 2,300 meters (7,500 feet), Shangarh is known for its picturesque landscapes and traditional charm.','media/shangarh.jpg','media/shangarh_2.jpg','media/shangarh_3.jpg',3),
 (34,'Shoja Village','Shoja is a quaint village situated in the Seraj Valley of Himachal Pradesh, India. It is located at an elevation of about 2,500 meters (8,200 feet) and offers stunning views of the surrounding Himalayan ranges.','media/shoja_village.jpg','media/shoja_village_2.jpg','media/shoja_village_3.jpg',3),
 (35,'Barot valley','Barot Valley is situated in the Mandi district of Himachal Pradesh, India. It lies along the Uhl River and is part of the larger Kangra Valley region. The valley is nestled at an elevation of about 1,600 meters (5,250 feet).','media/Barot-Valley-2.jpg','media/barot-valley_3.jpg','media/barot_valley.jpg',3),
 (36,'Khejarla Fort','Khejarla Fort is a majestic fort located in the Jodhpur district of Rajasthan, India. Built in the 15th century, it was established by Rao Kumpa, a Rajput prince and the founder of the Khejarla dynasty. The fort''s strategic location was chosen to guard the trade route between the cities of Jaisalmer and Jodhpur. The architecture of the fort reflects the grandeur of Rajputana design with its intricate carvings, imposing walls, and exquisite courtyards.
Over time, the fort fell into disuse and was partially restored in the 20th century. It now functions as a heritage hotel, preserving its historical charm while offering modern amenities. The fort is renowned for its splendid views of the surrounding desert landscape and its beautiful, ornate interiors.','media/khejarla_fort.jpg','media/khejarla_fort_2.jpg','media/khejarla-fort_3.jpg',9),
 (37,'Thar Desert','The Thar Desert, also known as the Great Indian Desert, is the largest desert in India and the 20th-largest in the world. It spans an area of approximately 200,000 square kilometers, covering the northwestern part of India, mainly in the state of Rajasthan, and extending into the southeastern region of Pakistan. It is characterized by vast stretches of sand dunes, arid landscape, sparse vegetation, and extreme temperatures that range from scorching hot days to cold nights.
It plays a crucial role in India''s geography, ecology, and culture. It is home to various communities, each with its distinct traditions, languages, and ways of life. The desert is rich in biodiversity, with unique flora and fauna adapted to the harsh conditions, such as the Indian gazelle (Chinkara), desert fox, and several species of reptiles and birds.','media/Thar_desert_HbQpW4m.jpg','media/thar_desert_2.jpg','media/Thar-Desert_3_O7Ib4Vq.jpg',9),
 (38,'Khimsar village','Khimsar is a picturesque village located on the edge of the Thar Desert in the Nagaur district of Rajasthan, India. Positioned midway between Jodhpur and Bikaner, Khimsar offers a unique blend of desert scenery and rural charm. The village is known for its rich cultural heritage, historical significance, and tranquil surroundings. It provides an authentic experience of rural Rajasthan, making it a popular destination for tourists looking to explore the region''s history, culture, and natural beauty.','media/khimsar_village_P2CRllS.jpeg.jpg','media/khimsar_3.jpg','media/khimsar_2_u7WPTiN.jpeg.jpg',9),
 (39,'Sambhar lake','Sambhar Lake, located in the Jaipur and Nagaur districts of Rajasthan, is India''s largest inland saltwater lake. Spanning an area of approximately 230 square kilometers, the lake is situated about 80 km southwest of Jaipur, the state capital. Sambhar Lake is a natural depression that forms part of the saline lake ecosystem, which plays a critical role in maintaining the region''s ecological balance. The lake receives water from various seasonal rivers, including the Medtha, Samod, Mantha, and Rupangarh.','media/sambhar_lake_2.jpg','media/sambhar_lake_3.jpg','media/sambhar_lake.jpg',9),
 (40,'Banswara','Banswara, often referred to as the "City of a Hundred Islands," is a picturesque district in the southern part of Rajasthan, India. The town is located around 500 km from Jaipur and shares its borders with the neighboring states of Gujarat and Madhya Pradesh. Banswara gets its name from the abundance of bamboo (''bans'') forests in the area. It is known for its scenic beauty, with rolling hills, numerous lakes, rivers, and lush green landscapes, providing a stark contrast to the arid deserts that are typically associated with Rajasthan.','media/banswara_3.jpg','media/banswara_2.jpg','media/banswara.jpg',9),
 (41,'Kumbhalgarh Fort','Kumbhalgarh Fort is a magnificent hill fort located in the Rajsamand district of Rajasthan, India. It is situated about 82 km northwest of Udaipur, perched on the Aravalli Range at an elevation of 1,100 meters above sea level. The fort is one of the six Hill Forts of Rajasthan that have been collectively designated as a UNESCO World Heritage Site. Kumbhalgarh is renowned for its massive walls, intricate architecture, and historical significance, making it one of the most impressive forts in India.','media/kumbhalgarh_fort_2_hNntOsy.jpg','media/kumbhalgarh_fort_3_8yeGLkl.jpg','media/kumbhalgarh_fort.jpg',9),
 (42,'Salaulim dam','Salaulim Dam is an important water resource project located in the Sanguem Taluka of South Goa. It plays a crucial role in the region’s water management and has several interesting aspects related to its history and significance.','media/Salaulim_dam_2.png','media/Salaulim_dam_3.jpg','media/Salaulim_dam.jpg',15),
 (43,'Cola beach','Cola Beach is one of Goa''s hidden gems, located in the Canacona region of South Goa. It''s known for its stunning beauty, tranquil atmosphere, and relatively untouched environment.','media/cola-beach-goa-2_AWXIk5i.jpg','media/cola_beach_3_IWcg8kA.png','media/cola_beach.jpg',15),
 (44,'Cabo de Rama beach','Cabo de Rama Beach is a picturesque and relatively secluded beach located in South Goa, near the Cabo de Rama Fort. It is known for its stunning natural beauty and historical significance.','media/cabo_de_rama_2.jpg','media/cabo_de_rama_3.jpg','media/Cabo-de-Rama_beach.jpg',15),
 (45,'Devil’s Finger Cave','Devil''s Finger is a lesser-known, intriguing rock formation located near the popular Vagator Beach in North Goa. The rock is part of the Chapora Hill and is named for its unique shape, resembling a finger pointing towards the sky. This spot is not just a natural wonder but also offers spectacular views of the surrounding Arabian Sea and coastline.','media/Devils_finger_cave.jpg','media/devils_finger_3.jpg','media/devils_finger_2.jpg',15),
 (46,'Sanguem village','Sanguem is a serene and historically significant village located in the southern part of Goa, within the Western Ghats. This village is known for its natural beauty, including lush forests, rivers, and waterfalls. Sanguem offers a glimpse into Goa’s rich cultural heritage, traditional lifestyles, and colonial history.','media/sanguem_village_2.png','media/sanguem_village_3.jpg','media/sanguem_village.jpg',15),
 (47,'Butterfly beach','Butterfly Beach is a small, secluded beach located on the southern coast of Goa, near the popular Palolem Beach. This hidden gem is known for its stunning natural beauty, tranquility, and the vibrant butterflies that frequent the area, giving the beach its name.','media/butterfly_beach_2_nP9vj01.jpg','media/butterfly_beach_3_WNoKspW.jpg','media/Butterfly-beach-goa.jpg',15),
 (48,'Mawlynnong','Mawlynnong is a small village located in the East Khasi Hills district of Meghalaya, approximately 90 kilometers from Shillong. It is widely recognized as the "Cleanest Village in Asia," a title it earned in 2003 from Discover India magazine. Mawlynnong is not just known for its cleanliness but also for its cultural heritage, natural beauty, and the unique way of life of its residents.','media/mawlynnong_3.jpg','media/mawlynnong_2.jpg','media/mawlynnong-waterfall.jpeg.jpg',12),
 (49,'Mawphlang Sacred Forest','The Mawphlang Sacred Forest, located in the East Khasi Hills district of Meghalaya, is one of the most revered and well-preserved sacred groves in India. This forest, also known as "Law Lyngdoh" in the local Khasi language, is not only a site of immense natural beauty but also a place of deep spiritual significance for the Khasi people. The history and cultural heritage of the Mawphlang Sacred Forest are intertwined with the traditional beliefs and practices of the Khasi tribe, making it a vital part of their identity.','media/Mawphalang_sacred-forest_3.jpg','media/Mawphalang_sacred_forest.jpg','media/Mawphlang-Sacred_forest_2.jpg',12),
 (50,'Ranikor','Ranikor is a serene and remote village located in the South West Khasi Hills District of Meghalaya, near the border with Bangladesh. Known for its breathtaking landscapes and the pristine Jadukata River, Ranikor has a rich history and cultural significance that is closely tied to the region''s natural resources and the traditional way of life of the local Khasi people.','media/Ranikor.jpg','media/Ranikor_2.jpg','media/Ranikor_3.jpg',12),
 (51,'Garden of Caves','The Garden of Caves, also known as "Ka Bri Ki Synrang," is a hidden natural wonder located in Laitmawsiang village, near Sohra (Cherrapunji), in the East Khasi Hills district of Meghalaya. This picturesque spot is a blend of natural caves, waterfalls, and lush greenery, making it a unique destination that offers visitors a chance to explore Meghalaya’s rich natural beauty and cultural heritage. The Garden of Caves is relatively less known compared to other tourist spots in the region, but it is steeped in local history and significance.','media/garden_of_caves_3.JPG','media/garden_of_caves_2.jpg','media/Garden_of_caves.JPG',12),
 (52,'Dawki River','The Dawki River, also known as the Umngot River, is one of the most famous and picturesque rivers in Meghalaya. Located near the town of Dawki in the West Jaintia Hills district, the river is renowned for its crystal-clear waters, which give the illusion that boats are floating on air. The history and significance of the Dawki River are closely tied to the region''s natural beauty, its strategic importance, and its cultural heritage.','media/dwaki_2.jpeg.jpg','media/Dawki.jpg','media/dawki_3.jpg',12),
 (53,'Laitkynsew','Laitkynsew is a picturesque village located near Cherrapunji (Sohra) in the East Khasi Hills district of Meghalaya. Known for its lush greenery, unique living root bridges, and serene surroundings, Laitkynsew is a hidden gem that offers visitors a chance to experience the natural beauty and traditional culture of the Khasi people. The village''s history and significance are deeply rooted in the local way of life, the environment, and the traditions that have been passed down through generations.','media/Laitkynsew_3.jpg','media/Laitkynsew_2.jpg','media/Laitkynsew.jpg',12),
 (54,'Meghamalai','Meghamalai, also known as the "High Wavy Mountains," is a picturesque hill station located in the Theni district of Tamil Nadu. Situated at an altitude of around 1,500 meters (4,921 feet) above sea level, Meghamalai is surrounded by lush tea estates, dense forests, and rich biodiversity. This lesser-known destination offers stunning views of the Western Ghats, cool weather, and serene landscapes, making it a perfect escape for nature lovers, adventure enthusiasts, and those seeking tranquility away from the more crowded tourist spots.','media/Meghamalai.jpg','media/meghamalai_3.jpeg.jpg','media/Meghamalai_2.jpg',17),
 (55,'Javadi hills','The Javadi Hills, also known as Jawadhi Hills, are a range of hills located in the Eastern Ghats of Tamil Nadu, spanning the districts of Vellore and Tiruvannamalai. Rising to an altitude of about 1,000 to 1,150 meters (3,280 to 3,770 feet), these hills are characterized by their dense forests, picturesque valleys, serene landscapes, and diverse flora and fauna. The region is relatively less explored compared to other hill stations in Tamil Nadu, making it an ideal destination for nature lovers, trekkers, and those seeking a quiet retreat away from crowded tourist spots.','media/javadi_hills_2.JPG','media/javadi_hills__3.jpg','media/Javadi_hills.jpg',17),
 (56,'Valparai','Valparai is a serene hill station located in the Anamalai Hills of the Western Ghats, in the Coimbatore district of Tamil Nadu. Perched at an altitude of 3,500 feet (1,067 meters) above sea level, Valparai is surrounded by lush tea and coffee plantations, dense forests, and mist-covered valleys. It offers a tranquil escape for those looking to enjoy a quiet, scenic retreat away from the more commercialized hill stations. Valparai is known for its picturesque landscapes, pleasant climate, and rich biodiversity, making it a popular destination for nature lovers, trekkers, and wildlife enthusiasts.','media/valparai.jpeg.jpg','media/valparai_3.jpg','media/valparai_2.jpg',17),
 (57,'Kumbakonam','Kumbakonam, often referred to as the "Temple Town," is a picturesque city located in the Thanjavur district of Tamil Nadu. Nestled between the Cauvery and Arasalar rivers, Kumbakonam is known for its rich history, magnificent temples, and cultural heritage. The city is renowned for its intricate temple architecture, traditional brassware, and vibrant festivals. Kumbakonam is also famous for its filter coffee, silk weaving, and betel leaf production. It is a key pilgrimage center, attracting thousands of devotees and tourists every year who come to explore its ancient temples, sacred tanks, and vibrant markets.','media/Kumbakonam.jpg','media/Kumbakonam_3.jpg','media/kumbakonam-2.jpg',17),
 (58,'Pichavaram Mangrove Forest','Pichavaram Mangrove Forest, located near Chidambaram in Tamil Nadu, is one of the largest mangrove forests in India and the second largest in the world. Spanning over 1,100 hectares, it is a unique ecosystem characterized by dense, lush green mangrove vegetation, winding waterways, and serene backwaters. This stunning natural landscape, nestled between the Vellar and Coleroon estuaries, offers a unique experience for nature lovers, bird watchers, and adventure seekers. Pichavaram is famous for its scenic boat rides through narrow canals lined with mangroves, providing an opportunity to observe a diverse range of flora and fauna up close.','media/pichavaram_mangrove_forest_3.jpg','media/pichavaram_mangrove_forest.jpg','media/pichavaram_mangrove_forest_2.jpg',17),
 (59,'Manapad','Manapad is a quaint coastal village located in the Tuticorin district of Tamil Nadu, along the Coromandel Coast. Known for its stunning beaches, unique rock formations, and rich religious heritage, Manapad offers a peaceful retreat away from the bustle of city life. This hidden gem is characterized by its crescent-shaped shoreline, traditional fishing boats, and a blend of Indian and European architecture, reflecting its colonial past. Manapad is particularly known for its vibrant Christian community and historic churches, making it a significant pilgrimage site for Christians in India.','media/manapad-beach_2.jpg','media/manapad_3.jpg','media/manapad.jpg',17);
INSERT INTO "app_state" ("id","state_name","direction") VALUES (1,'Delhi','north'),
 (2,'Punjab','north'),
 (3,'Himachal Pradesh','north'),
 (4,'Jammu & Kashmir','north'),
 (5,'uttarakhand','north'),
 (6,'Gujarat','west'),
 (7,'Maharashtra','west'),
 (8,'Madhya Pradesh','west'),
 (9,'Rajasthan','west'),
 (10,'Arunachal Pradesh','east'),
 (11,'Assam','east'),
 (12,'Meghalaya','east'),
 (13,'Mizoram','east'),
 (14,'Nagaland','east'),
 (15,'Goa','west'),
 (16,'Karnataka','south'),
 (17,'Tamilnadu','south'),
 (18,'Kerala','south');
INSERT INTO "app_user" ("id","name","email","location","is_active","is_staff","last_login","password") VALUES (1,'YourNameHere','abcd@gmail.com','Gujarat',1,0,NULL,'pbkdf2_sha256$720000$UX5I7Gn1dMFIB6lb0Mklsr$lMkmAyM8oM6cPGo/q9rBiFxGwjeIQAClY7c40Af7JRI='),
 (2,'YourNameHere','kashish@gmail.com','Gujarat',1,0,NULL,'pbkdf2_sha256$720000$rHP1X7OORFwcwTPTi1iO2f$j4ZkzMxGYr2pOCL8sTCvDlsO/fqEOlth7TZHsmSYPdw=');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (1,1,'add_logentry','Can add log entry'),
 (2,1,'change_logentry','Can change log entry'),
 (3,1,'delete_logentry','Can delete log entry'),
 (4,1,'view_logentry','Can view log entry'),
 (5,2,'add_permission','Can add permission'),
 (6,2,'change_permission','Can change permission'),
 (7,2,'delete_permission','Can delete permission'),
 (8,2,'view_permission','Can view permission'),
 (9,3,'add_group','Can add group'),
 (10,3,'change_group','Can change group'),
 (11,3,'delete_group','Can delete group'),
 (12,3,'view_group','Can view group'),
 (13,4,'add_user','Can add user'),
 (14,4,'change_user','Can change user'),
 (15,4,'delete_user','Can delete user'),
 (16,4,'view_user','Can view user'),
 (17,5,'add_contenttype','Can add content type'),
 (18,5,'change_contenttype','Can change content type'),
 (19,5,'delete_contenttype','Can delete content type'),
 (20,5,'view_contenttype','Can view content type'),
 (21,6,'add_session','Can add session'),
 (22,6,'change_session','Can change session'),
 (23,6,'delete_session','Can delete session'),
 (24,6,'view_session','Can view session'),
 (25,7,'add_user','Can add user'),
 (26,7,'change_user','Can change user'),
 (27,7,'delete_user','Can delete user'),
 (28,7,'view_user','Can view user'),
 (29,8,'add_place','Can add place'),
 (30,8,'change_place','Can change place'),
 (31,8,'delete_place','Can delete place'),
 (32,8,'view_place','Can view place'),
 (33,9,'add_hist_back','Can add hist_back'),
 (34,9,'change_hist_back','Can change hist_back'),
 (35,9,'delete_hist_back','Can delete hist_back'),
 (36,9,'view_hist_back','Can view hist_back'),
 (37,10,'add_nearby_place','Can add nearby_ place'),
 (38,10,'change_nearby_place','Can change nearby_ place'),
 (39,10,'delete_nearby_place','Can delete nearby_ place'),
 (40,10,'view_nearby_place','Can view nearby_ place'),
 (41,11,'add_state','Can add state'),
 (42,11,'change_state','Can change state'),
 (43,11,'delete_state','Can delete state'),
 (44,11,'view_state','Can view state'),
 (45,12,'add_travel_and_cost','Can add travel_and_cost'),
 (46,12,'change_travel_and_cost','Can change travel_and_cost'),
 (47,12,'delete_travel_and_cost','Can delete travel_and_cost'),
 (48,12,'view_travel_and_cost','Can view travel_and_cost'),
 (49,13,'add_review','Can add review'),
 (50,13,'change_review','Can change review'),
 (51,13,'delete_review','Can delete review'),
 (52,13,'view_review','Can view review');
INSERT INTO "auth_user" ("id","password","last_login","is_superuser","username","last_name","email","is_staff","is_active","date_joined","first_name") VALUES (1,'pbkdf2_sha256$870000$xfsWQHxBlvCCX51Ahgrwrj$kKtzyXop6BQ1YT5nIuXHrw9oepecgpjIef6iMSUXYEY=','2024-09-03 17:28:02.795037',1,'Savaliya_kashish','','kashishsavaliya10@gmail.com',1,1,'2024-07-25 12:15:40.405571','');
INSERT INTO "django_admin_log" ("id","object_id","object_repr","action_flag","change_message","content_type_id","user_id","action_time") VALUES (1,'1','Delhi',1,'[{"added": {}}]',11,1,'2024-07-26 15:33:48.672544'),
 (2,'2','Punjab',1,'[{"added": {}}]',11,1,'2024-07-26 15:34:01.446528'),
 (3,'3','Himachal Pradesh',1,'[{"added": {}}]',11,1,'2024-07-26 15:34:19.210795'),
 (4,'4','Jammu & Kashmir',1,'[{"added": {}}]',11,1,'2024-07-26 15:34:43.862206'),
 (5,'5','Uttarakhand',1,'[{"added": {}}]',11,1,'2024-07-26 15:34:54.629439'),
 (6,'6','Gujarat',1,'[{"added": {}}]',11,1,'2024-07-26 15:35:20.903680'),
 (7,'7','Maharashtra',1,'[{"added": {}}]',11,1,'2024-07-26 15:35:30.202451'),
 (8,'8','Madhya Pradesh',1,'[{"added": {}}]',11,1,'2024-07-26 15:35:43.773088'),
 (9,'9','Rajasthan',1,'[{"added": {}}]',11,1,'2024-07-26 15:36:42.249337'),
 (10,'10','Arunachal Pradesh',1,'[{"added": {}}]',11,1,'2024-07-26 15:37:04.331182'),
 (11,'11','Assam',1,'[{"added": {}}]',11,1,'2024-07-26 15:37:12.934986'),
 (12,'12','Meghalaya',1,'[{"added": {}}]',11,1,'2024-07-26 15:37:23.077472'),
 (13,'13','Mizoram',1,'[{"added": {}}]',11,1,'2024-07-26 15:37:32.873444'),
 (14,'14','Nagaland',1,'[{"added": {}}]',11,1,'2024-07-26 15:37:41.888852'),
 (15,'15','Goa',1,'[{"added": {}}]',11,1,'2024-07-26 15:37:59.087457'),
 (16,'16','Karnataka',1,'[{"added": {}}]',11,1,'2024-07-26 15:38:08.421488'),
 (17,'17','Tamilnadu',1,'[{"added": {}}]',11,1,'2024-07-26 15:38:19.781114'),
 (18,'18','Kerala',1,'[{"added": {}}]',11,1,'2024-07-26 15:38:28.361735'),
 (19,'1','Gurez ValleyinJammu & Kashmir',1,'[{"added": {}}]',8,1,'2024-07-26 16:03:12.400523'),
 (20,'2','Tarsar MarsarinJammu & Kashmir',1,'[{"added": {}}]',8,1,'2024-07-26 16:04:18.685129'),
 (21,'3','SanasarinJammu & Kashmir',1,'[{"added": {}}]',8,1,'2024-07-26 16:05:04.427102'),
 (22,'4','ChatpalinJammu & Kashmir',1,'[{"added": {}}]',8,1,'2024-07-26 16:05:49.487029'),
 (23,'5','BhaderwahinJammu & Kashmir',1,'[{"added": {}}]',8,1,'2024-07-26 16:06:29.207982'),
 (24,'6','Pari MahalinJammu & Kashmir',1,'[{"added": {}}]',8,1,'2024-07-26 16:11:19.161995'),
 (25,'1','Habba Khatoon Peak nearby Gurez Valley',1,'[{"added": {}}]',10,1,'2024-07-26 16:12:17.377902'),
 (26,'2','Kishanganga River nearby Gurez Valley',1,'[{"added": {}}]',10,1,'2024-07-26 16:12:37.672616'),
 (27,'3','Razdan Pass nearby Gurez Valley',1,'[{"added": {}}]',10,1,'2024-07-26 16:12:55.884659'),
 (28,'4','Starting Point – Aru Valley nearby Tarsar Marsar',1,'[{"added": {}}]',10,1,'2024-07-26 16:13:22.758176'),
 (29,'5','Tarsar Lake nearby Tarsar Marsar',1,'[{"added": {}}]',10,1,'2024-07-26 16:13:39.089719'),
 (30,'6','Marsar Lake nearby Tarsar Marsar',1,'[{"added": {}}]',10,1,'2024-07-26 16:14:00.737546'),
 (31,'7','Sanasar Lake nearby Sanasar',1,'[{"added": {}}]',10,1,'2024-07-26 16:14:23.725494'),
 (32,'8','Sana and Sar Lakes nearby Sanasar',1,'[{"added": {}}]',10,1,'2024-07-26 16:14:43.054070'),
 (33,'9','Meadows and Forests nearby Sanasar',1,'[{"added": {}}]',10,1,'2024-07-26 16:15:09.425794'),
 (34,'10','Trekking and Hiking nearby Chatpal',1,'[{"added": {}}]',10,1,'2024-07-26 16:16:01.715417'),
 (35,'11','Wildlife and Bird Watching nearby Chatpal',1,'[{"added": {}}]',10,1,'2024-07-26 16:16:21.568200'),
 (36,'12','Local Culture and Lifestyle nearby Chatpal',1,'[{"added": {}}]',10,1,'2024-07-26 16:16:44.261707'),
 (37,'13','Jai Valley nearby Bhaderwah',1,'[{"added": {}}]',10,1,'2024-07-26 16:17:17.520749'),
 (38,'14','Padri nearby Bhaderwah',1,'[{"added": {}}]',10,1,'2024-07-26 16:17:39.169641'),
 (39,'15','Chinta Valley nearby Bhaderwah',1,'[{"added": {}}]',10,1,'2024-07-26 16:17:56.632218'),
 (40,'16','Terraced Gardens nearby Pari Mahal',1,'[{"added": {}}]',10,1,'2024-07-26 16:18:22.633470'),
 (41,'17','Panoramic Views nearby Pari Mahal',1,'[{"added": {}}]',10,1,'2024-07-26 16:18:40.163120'),
 (42,'18','Architectural Beauty: nearby Pari Mahal',1,'[{"added": {}}]',10,1,'2024-07-26 16:19:02.452049'),
 (43,'1','History ofGurez Valley',1,'[{"added": {}}]',9,1,'2024-07-26 17:08:53.360304'),
 (44,'2','History ofGurez Valley',1,'[{"added": {}}]',9,1,'2024-07-26 17:09:22.327585'),
 (45,'3','History ofGurez Valley',1,'[{"added": {}}]',9,1,'2024-07-26 17:09:47.094858'),
 (46,'4','History ofTarsar Marsar',1,'[{"added": {}}]',9,1,'2024-07-26 17:10:32.171868'),
 (47,'5','History ofTarsar Marsar',1,'[{"added": {}}]',9,1,'2024-07-26 17:10:52.447636'),
 (48,'6','History ofTarsar Marsar',1,'[{"added": {}}]',9,1,'2024-07-26 17:11:10.105484'),
 (49,'7','History ofSanasar',1,'[{"added": {}}]',9,1,'2024-07-26 17:11:33.117255'),
 (50,'8','History ofSanasar',1,'[{"added": {}}]',9,1,'2024-07-26 17:12:05.468192'),
 (51,'9','History ofChatpal',1,'[{"added": {}}]',9,1,'2024-07-26 17:12:32.963546'),
 (52,'10','History ofChatpal',1,'[{"added": {}}]',9,1,'2024-07-26 17:12:56.900253'),
 (53,'11','History ofBhaderwah',1,'[{"added": {}}]',9,1,'2024-07-26 17:13:24.610816'),
 (54,'12','History ofBhaderwah',1,'[{"added": {}}]',9,1,'2024-07-26 17:13:42.208459'),
 (55,'13','History ofBhaderwah',1,'[{"added": {}}]',9,1,'2024-07-26 17:13:59.299271'),
 (56,'14','History ofPari Mahal',1,'[{"added": {}}]',9,1,'2024-07-26 17:14:19.111764'),
 (57,'15','History ofPari Mahal',1,'[{"added": {}}]',9,1,'2024-07-26 17:14:37.847261'),
 (58,'16','History ofPari Mahal',1,'[{"added": {}}]',9,1,'2024-07-26 17:37:32.818589'),
 (59,'17','History ofChatpal',1,'[{"added": {}}]',9,1,'2024-07-26 17:38:49.340613'),
 (60,'18','History ofSanasar',1,'[{"added": {}}]',9,1,'2024-07-26 17:39:31.840066'),
 (61,'7','Girmal WaterfallinGujarat',1,'[{"added": {}}]',8,1,'2024-07-26 19:06:33.420009'),
 (62,'8','Bechtel beachinGujarat',1,'[{"added": {}}]',8,1,'2024-07-26 19:07:26.618596'),
 (63,'9','Kadiya DhroinGujarat',1,'[{"added": {}}]',8,1,'2024-07-26 19:09:03.683303'),
 (64,'10','Wilson HillinGujarat',1,'[{"added": {}}]',8,1,'2024-07-26 19:09:40.704025'),
 (65,'11','Polo forestinGujarat',1,'[{"added": {}}]',8,1,'2024-07-26 19:10:22.354080'),
 (66,'19','Pristine Environment nearby Girmal Waterfall',1,'[{"added": {}}]',10,1,'2024-07-26 19:12:07.761618'),
 (67,'20','2.	Flora and Fauna nearby Girmal Waterfall',1,'[{"added": {}}]',10,1,'2024-07-26 19:12:35.188770'),
 (68,'20','Flora and Fauna nearby Girmal Waterfall',2,'[{"changed": {"fields": ["Placename"]}}]',10,1,'2024-07-26 19:12:50.212197'),
 (69,'19','Purna Wildlife Sanctuary nearby Girmal Waterfall',2,'[{"changed": {"fields": ["Placename", "Desc"]}}]',10,1,'2024-07-26 19:15:19.478841'),
 (70,'20','Mahal Eco Campsite nearby Girmal Waterfall',2,'[{"changed": {"fields": ["Placename", "Desc"]}}]',10,1,'2024-07-26 19:15:54.575125'),
 (71,'21','Gira Waterfalls nearby Girmal Waterfall',1,'[{"added": {}}]',10,1,'2024-07-26 19:16:36.657456'),
 (72,'22','Mandvi Fort nearby Bechtel beach',1,'[{"added": {}}]',10,1,'2024-07-26 19:19:35.840398'),
 (73,'23','Vijay Vilas Palace nearby Bechtel beach',1,'[{"added": {}}]',10,1,'2024-07-26 19:19:58.145477'),
 (74,'24','Kutch Museum nearby Bechtel beach',1,'[{"added": {}}]',10,1,'2024-07-26 19:20:36.261210'),
 (75,'25','Mandvi Fort nearby Kadiya Dhro',1,'[{"added": {}}]',10,1,'2024-07-26 19:22:27.590681'),
 (76,'26','Nakhatrana nearby Kadiya Dhro',1,'[{"added": {}}]',10,1,'2024-07-26 19:22:51.237136'),
 (77,'27','Tunda Vandh nearby Kadiya Dhro',1,'[{"added": {}}]',10,1,'2024-07-26 19:23:18.039759'),
 (78,'28','Tithal Beach nearby Wilson Hill',1,'[{"added": {}}]',10,1,'2024-07-26 19:24:17.820683'),
 (79,'29','Hathisingh Jain Temple (in Valsad) nearby Wilson Hill',1,'[{"added": {}}]',10,1,'2024-07-26 19:24:43.186330'),
 (80,'30','Silvassa nearby Wilson Hill',1,'[{"added": {}}]',10,1,'2024-07-26 19:25:33.726753'),
 (81,'31','Ambaji Temple nearby Polo forest',1,'[{"added": {}}]',10,1,'2024-07-26 19:26:55.854584'),
 (82,'32','Sardarpur nearby Polo forest',1,'[{"added": {}}]',10,1,'2024-07-26 19:27:17.043882'),
 (83,'33','Siddhpur nearby Polo forest',1,'[{"added": {}}]',10,1,'2024-07-26 19:28:15.978033'),
 (84,'19','History ofGirmal Waterfall',1,'[{"added": {}}]',9,1,'2024-07-26 19:29:23.435508'),
 (85,'20','History ofGirmal Waterfall',1,'[{"added": {}}]',9,1,'2024-07-26 19:29:55.770250'),
 (86,'21','History ofGirmal Waterfall',1,'[{"added": {}}]',9,1,'2024-07-26 19:31:04.505136'),
 (87,'22','History ofBechtel beach',1,'[{"added": {}}]',9,1,'2024-07-26 19:31:50.383475'),
 (88,'23','History ofBechtel beach',1,'[{"added": {}}]',9,1,'2024-07-26 19:32:20.414637'),
 (89,'24','History ofBechtel beach',1,'[{"added": {}}]',9,1,'2024-07-26 19:33:10.407252'),
 (90,'25','History ofKadiya Dhro',1,'[{"added": {}}]',9,1,'2024-07-26 19:33:45.784602'),
 (91,'26','History ofKadiya Dhro',1,'[{"added": {}}]',9,1,'2024-07-26 19:34:10.951365'),
 (92,'27','History ofKadiya Dhro',1,'[{"added": {}}]',9,1,'2024-07-26 19:35:49.180781'),
 (93,'28','History ofWilson Hill',1,'[{"added": {}}]',9,1,'2024-07-26 19:36:18.033916'),
 (94,'29','History ofWilson Hill',1,'[{"added": {}}]',9,1,'2024-07-26 19:36:45.420820'),
 (95,'30','History ofWilson Hill',1,'[{"added": {}}]',9,1,'2024-07-26 19:37:17.962876'),
 (96,'31','History ofPolo forest',1,'[{"added": {}}]',9,1,'2024-07-26 19:37:47.480373'),
 (97,'32','History ofPolo forest',1,'[{"added": {}}]',9,1,'2024-07-26 19:39:30.036060'),
 (98,'33','History ofPolo forest',1,'[{"added": {}}]',9,1,'2024-07-26 19:40:16.888017'),
 (99,'12','Bekal FortinKerala',1,'[{"added": {}}]',8,1,'2024-07-27 05:19:05.492100'),
 (100,'13','Jatayu Earth''s CenterinKerala',1,'[{"added": {}}]',8,1,'2024-07-27 05:20:41.726241'),
 (101,'14','Kappad BeachinKerala',1,'[{"added": {}}]',8,1,'2024-07-27 05:23:10.462012'),
 (102,'15','Edappally Church ComplexinKerala',1,'[{"added": {}}]',8,1,'2024-07-27 05:23:54.424593'),
 (103,'16','RamakkalmeduinKerala',1,'[{"added": {}}]',8,1,'2024-07-27 05:24:42.060927'),
 (104,'17','Anchuthengu and Anjengo FortinKerala',1,'[{"added": {}}]',8,1,'2024-07-27 05:25:42.690344'),
 (105,'34','Kappil Beach nearby Bekal Fort',1,'[{"added": {}}]',10,1,'2024-07-27 05:28:13.622007'),
 (106,'35','Chandragiri Fort nearby Bekal Fort',1,'[{"added": {}}]',10,1,'2024-07-27 05:28:35.551721'),
 (107,'36','Nileshwaram nearby Bekal Fort',1,'[{"added": {}}]',10,1,'2024-07-27 05:29:19.349572'),
 (108,'37','Chadayamangalam nearby Jatayu Earth''s Center',1,'[{"added": {}}]',10,1,'2024-07-27 05:31:20.632065'),
 (109,'38','Sasthamcotta Lake nearby Jatayu Earth''s Center',1,'[{"added": {}}]',10,1,'2024-07-27 05:32:01.682031'),
 (110,'39','Punalur nearby Jatayu Earth''s Center',1,'[{"added": {}}]',10,1,'2024-07-27 05:32:45.467621'),
 (111,'40','S.M. Street (Sweet Meat Street) nearby Kappad Beach',1,'[{"added": {}}]',10,1,'2024-07-27 05:34:06.400875'),
 (112,'41','Thusharagiri Waterfalls nearby Kappad Beach',1,'[{"added": {}}]',10,1,'2024-07-27 05:34:44.756730'),
 (113,'42','Pazhassi Raja Museum nearby Kappad Beach',1,'[{"added": {}}]',10,1,'2024-07-27 05:35:10.662802'),
 (114,'43','Kochi (Cochin) nearby Edappally Church Complex',1,'[{"added": {}}]',10,1,'2024-07-27 05:36:36.757747'),
 (115,'44','Vypin Island nearby Edappally Church Complex',1,'[{"added": {}}]',10,1,'2024-07-27 05:36:56.301000'),
 (116,'45','Mangalavanam Bird Sanctuary nearby Edappally Church Complex',1,'[{"added": {}}]',10,1,'2024-07-27 05:37:20.884353'),
 (117,'46','Munnar nearby Ramakkalmedu',1,'[{"added": {}}]',10,1,'2024-07-27 05:38:23.210545'),
 (118,'47','Vagamon nearby Ramakkalmedu',1,'[{"added": {}}]',10,1,'2024-07-27 05:39:00.078986'),
 (119,'48','Idukki Dam nearby Ramakkalmedu',1,'[{"added": {}}]',10,1,'2024-07-27 05:39:23.206401'),
 (120,'49','Kovalam Beach nearby Anchuthengu and Anjengo Fort',1,'[{"added": {}}]',10,1,'2024-07-27 05:40:26.014973'),
 (121,'50','Ponmudi nearby Anchuthengu and Anjengo Fort',1,'[{"added": {}}]',10,1,'2024-07-27 05:40:45.525219'),
 (122,'51','Thiruvananthapuram (Trivandrum) nearby Anchuthengu and Anjengo Fort',1,'[{"added": {}}]',10,1,'2024-07-27 05:41:21.238343'),
 (123,'34','History ofBekal Fort',1,'[{"added": {}}]',9,1,'2024-07-27 05:43:00.970074'),
 (124,'35','History ofBekal Fort',1,'[{"added": {}}]',9,1,'2024-07-27 05:43:29.672142'),
 (125,'36','History ofJatayu Earth''s Center',1,'[{"added": {}}]',9,1,'2024-07-27 05:47:20.545038'),
 (126,'37','History ofBekal Fort',1,'[{"added": {}}]',9,1,'2024-07-27 05:51:15.997959'),
 (127,'38','History ofKappad Beach',1,'[{"added": {}}]',9,1,'2024-07-27 05:54:09.219455'),
 (128,'39','History ofKappad Beach',1,'[{"added": {}}]',9,1,'2024-07-27 05:54:35.711118'),
 (129,'40','History ofKappad Beach',1,'[{"added": {}}]',9,1,'2024-07-27 05:56:23.018453'),
 (130,'41','History ofJatayu Earth''s Center',1,'[{"added": {}}]',9,1,'2024-07-27 05:58:47.905376'),
 (131,'42','History ofJatayu Earth''s Center',1,'[{"added": {}}]',9,1,'2024-07-27 05:59:35.333985'),
 (132,'43','History ofEdappally Church Complex',1,'[{"added": {}}]',9,1,'2024-07-27 06:00:38.665048'),
 (133,'44','History ofEdappally Church Complex',1,'[{"added": {}}]',9,1,'2024-07-27 06:01:05.120849'),
 (134,'45','History ofEdappally Church Complex',1,'[{"added": {}}]',9,1,'2024-07-27 06:01:38.547462'),
 (135,'46','History ofRamakkalmedu',1,'[{"added": {}}]',9,1,'2024-07-27 06:02:42.001826'),
 (136,'47','History ofRamakkalmedu',1,'[{"added": {}}]',9,1,'2024-07-27 06:03:57.135495'),
 (137,'48','History ofRamakkalmedu',1,'[{"added": {}}]',9,1,'2024-07-27 06:04:27.748960'),
 (138,'49','History ofAnchuthengu and Anjengo Fort',1,'[{"added": {}}]',9,1,'2024-07-27 06:04:50.281581'),
 (139,'50','History ofAnchuthengu and Anjengo Fort',1,'[{"added": {}}]',9,1,'2024-07-27 06:06:00.039971'),
 (140,'51','History ofAnchuthengu and Anjengo Fort',1,'[{"added": {}}]',9,1,'2024-07-27 06:07:28.213457'),
 (141,'18','Dhanaulti Hill stationinUttarakhand',1,'[{"added": {}}]',8,1,'2024-08-19 06:07:39.543743'),
 (142,'52','History ofDhanaulti Hill station',1,'[{"added": {}}]',9,1,'2024-08-19 06:11:17.260153'),
 (143,'53','History ofDhanaulti Hill station',1,'[{"added": {}}]',9,1,'2024-08-19 06:11:45.956425'),
 (144,'53','History ofDhanaulti Hill station',2,'[]',9,1,'2024-08-19 06:11:54.333371'),
 (145,'54','History ofDhanaulti Hill station',1,'[{"added": {}}]',9,1,'2024-08-19 06:12:24.477622'),
 (146,'52','Eco Park nearby Dhanaulti Hill station',1,'[{"added": {}}]',10,1,'2024-08-19 06:13:16.788423'),
 (147,'53','Surkanda Devi Temple nearby Dhanaulti Hill station',1,'[{"added": {}}]',10,1,'2024-08-19 06:13:34.664953'),
 (148,'54','Kanatal nearby Dhanaulti Hill station',1,'[{"added": {}}]',10,1,'2024-08-19 06:13:50.174054'),
 (149,'5','uttarakhand',2,'[{"changed": {"fields": ["State name"]}}]',11,1,'2024-08-19 06:14:55.653871'),
 (150,'54','History ofDhanaulti Hill station',2,'[{"changed": {"fields": ["Info"]}}]',9,1,'2024-08-19 06:16:06.125059'),
 (151,'54','History ofDhanaulti Hill station',2,'[{"changed": {"fields": ["Info"]}}]',9,1,'2024-08-19 06:16:52.820085'),
 (152,'53','History ofDhanaulti Hill station',2,'[{"changed": {"fields": ["Info"]}}]',9,1,'2024-08-19 06:17:30.109643'),
 (153,'52','History ofDhanaulti Hill station',2,'[{"changed": {"fields": ["Info"]}}]',9,1,'2024-08-19 06:18:05.779684'),
 (154,'54','Kanatal nearby Dhanaulti Hill station',2,'[{"changed": {"fields": ["Desc"]}}]',10,1,'2024-08-19 06:21:46.840409'),
 (155,'53','Surkanda Devi Temple nearby Dhanaulti Hill station',2,'[{"changed": {"fields": ["Desc"]}}]',10,1,'2024-08-19 06:26:05.693191'),
 (156,'52','Eco Park nearby Dhanaulti Hill station',2,'[{"changed": {"fields": ["Desc"]}}]',10,1,'2024-08-19 06:27:34.383353'),
 (157,'19','Lansdowneinuttarakhand',1,'[{"added": {}}]',8,1,'2024-08-19 06:30:44.734923'),
 (158,'55','History ofLansdowne',1,'[{"added": {}}]',9,1,'2024-08-19 06:32:40.943258'),
 (159,'56','History ofLansdowne',1,'[{"added": {}}]',9,1,'2024-08-19 06:33:18.473042'),
 (160,'57','History ofLansdowne',1,'[{"added": {}}]',9,1,'2024-08-19 06:34:01.636922'),
 (161,'55','Bhulla Tal Lake nearby Lansdowne',1,'[{"added": {}}]',10,1,'2024-08-19 06:35:30.769595'),
 (162,'56','Bhulla Tal Lake nearby Lansdowne',1,'[{"added": {}}]',10,1,'2024-08-19 06:36:28.377749'),
 (163,'57','Tip-In-Top nearby Lansdowne',1,'[{"added": {}}]',10,1,'2024-08-19 06:38:12.154757'),
 (164,'55','St. Mary’s Church nearby Lansdowne',2,'[{"changed": {"fields": ["Placename", "Desc"]}}]',10,1,'2024-08-19 06:41:26.776388'),
 (165,'55','St. Mary’s Church nearby Lansdowne',2,'[{"changed": {"fields": ["Desc"]}}]',10,1,'2024-08-19 06:42:28.675412'),
 (166,'20','Chaukori hill stationinuttarakhand',1,'[{"added": {}}]',8,1,'2024-08-19 06:43:40.453106'),
 (167,'58','History ofChaukori hill station',1,'[{"added": {}}]',9,1,'2024-08-19 06:44:45.286429'),
 (168,'59','History ofChaukori hill station',1,'[{"added": {}}]',9,1,'2024-08-19 06:47:57.384447'),
 (169,'60','History ofChaukori hill station',1,'[{"added": {}}]',9,1,'2024-08-19 06:48:44.428884'),
 (170,'58','Patal Bhuvaneshwar Cave Temple nearby Chaukori hill station',1,'[{"added": {}}]',10,1,'2024-08-19 06:50:28.708253'),
 (171,'59','Berinag nearby Chaukori hill station',1,'[{"added": {}}]',10,1,'2024-08-19 06:51:48.400766'),
 (172,'60','Nagmandir nearby Chaukori hill station',1,'[{"added": {}}]',10,1,'2024-08-19 06:52:29.466689'),
 (173,'21','Nelong valleyinuttarakhand',1,'[{"added": {}}]',8,1,'2024-08-19 06:55:58.042242'),
 (174,'61','History ofNelong valley',1,'[{"added": {}}]',9,1,'2024-08-19 06:57:22.350255'),
 (175,'62','History ofNelong valley',1,'[{"added": {}}]',9,1,'2024-08-19 06:57:53.644948'),
 (176,'63','History ofNelong valley',1,'[{"added": {}}]',9,1,'2024-08-19 06:58:27.601268'),
 (177,'61','Harsil nearby Nelong valley',1,'[{"added": {}}]',10,1,'2024-08-19 07:00:25.680007'),
 (178,'62','Gangotri nearby Nelong valley',1,'[{"added": {}}]',10,1,'2024-08-19 07:01:24.439495'),
 (179,'63','Bhagirathi Shila nearby Nelong valley',1,'[{"added": {}}]',10,1,'2024-08-19 07:02:07.279590'),
 (180,'22','Harsil valleyinuttarakhand',1,'[{"added": {}}]',8,1,'2024-08-19 07:04:20.126070'),
 (181,'64','History ofHarsil valley',1,'[{"added": {}}]',9,1,'2024-08-19 07:05:21.333287'),
 (182,'65','History ofHarsil valley',1,'[{"added": {}}]',9,1,'2024-08-19 07:05:53.408227'),
 (183,'66','History ofHarsil valley',1,'[{"added": {}}]',9,1,'2024-08-19 07:06:22.424329'),
 (184,'64','Dharali nearby Harsil valley',1,'[{"added": {}}]',10,1,'2024-08-19 07:07:33.807357'),
 (185,'65','Gangotri nearby Harsil valley',1,'[{"added": {}}]',10,1,'2024-08-19 07:08:07.081881'),
 (186,'66','Sattal nearby Harsil valley',1,'[{"added": {}}]',10,1,'2024-08-19 07:09:43.793518'),
 (187,'23','Chamoliinuttarakhand',1,'[{"added": {}}]',8,1,'2024-08-19 07:11:36.162737'),
 (188,'23','Chamoliinuttarakhand',2,'[]',8,1,'2024-08-19 07:12:19.199710'),
 (189,'67','History ofChamoli',1,'[{"added": {}}]',9,1,'2024-08-19 07:12:58.585551'),
 (190,'68','History ofChamoli',1,'[{"added": {}}]',9,1,'2024-08-19 07:13:32.092969'),
 (191,'69','History ofChamoli',1,'[{"added": {}}]',9,1,'2024-08-19 07:13:59.580695'),
 (192,'67','Auli nearby Chamoli',1,'[{"added": {}}]',10,1,'2024-08-19 07:15:22.720456'),
 (193,'68','Vasudhara Falls nearby Chamoli',1,'[{"added": {}}]',10,1,'2024-08-19 07:16:04.143691'),
 (194,'69','Nanda Devi National Park nearby Chamoli',1,'[{"added": {}}]',10,1,'2024-08-19 07:16:47.581530'),
 (195,'23','Chamoliinuttarakhand',2,'[{"changed": {"fields": ["Image1"]}}]',8,1,'2024-08-19 07:19:48.809910'),
 (196,'23','Chamoliinuttarakhand',2,'[{"changed": {"fields": ["Image3"]}}]',8,1,'2024-08-19 07:20:16.728601'),
 (197,'22','Harsil valleyinuttarakhand',2,'[{"changed": {"fields": ["Image1", "Image3"]}}]',8,1,'2024-08-19 07:21:32.508563'),
 (198,'16','Karnataka',2,'[]',11,1,'2024-08-31 06:56:41.621428'),
 (199,'24','Devaramane HillinKarnataka',1,'[{"added": {}}]',8,1,'2024-08-31 06:58:44.618216'),
 (200,'70','History ofDevaramane Hill',1,'[{"added": {}}]',9,1,'2024-08-31 07:00:43.035797'),
 (201,'71','History ofDevaramane Hill',1,'[{"added": {}}]',9,1,'2024-08-31 07:01:13.881631'),
 (202,'72','History ofDevaramane Hill',1,'[{"added": {}}]',9,1,'2024-08-31 07:01:55.854716'),
 (203,'70','History ofDevaramane Hill',2,'[{"changed": {"fields": ["Head"]}}]',9,1,'2024-08-31 07:02:16.130735'),
 (204,'70','Kemmangundi (Kemmannugundi) nearby Devaramane Hill',1,'[{"added": {}}]',10,1,'2024-08-31 07:03:45.019059'),
 (205,'71','Agumbe nearby Devaramane Hill',1,'[{"added": {}}]',10,1,'2024-08-31 07:05:17.285898'),
 (206,'72','Shravanabelagola nearby Devaramane Hill',1,'[{"added": {}}]',10,1,'2024-08-31 07:06:30.627245'),
 (207,'25','Kalasa towninKarnataka',1,'[{"added": {}}]',8,1,'2024-08-31 07:09:50.211454'),
 (208,'73','History ofKalasa town',1,'[{"added": {}}]',9,1,'2024-08-31 07:10:33.140732'),
 (209,'74','History ofKalasa town',1,'[{"added": {}}]',9,1,'2024-08-31 07:11:11.780009'),
 (210,'75','History ofKalasa town',1,'[{"added": {}}]',9,1,'2024-08-31 07:11:37.853561'),
 (211,'73','Horanadu Annapoorneshwari Temple nearby Kalasa town',1,'[{"added": {}}]',10,1,'2024-08-31 07:12:44.900079'),
 (212,'74','Hanuman Gundi Falls nearby Kalasa town',1,'[{"added": {}}]',10,1,'2024-08-31 07:14:49.906886'),
 (213,'75','Kudremukh National Park nearby Kalasa town',1,'[{"added": {}}]',10,1,'2024-08-31 07:15:31.021677'),
 (214,'26','Sasihitlu beachinKarnataka',1,'[{"added": {}}]',8,1,'2024-08-31 07:22:40.898938'),
 (215,'76','History ofSasihitlu beach',1,'[{"added": {}}]',9,1,'2024-08-31 07:26:35.061788'),
 (216,'77','History ofSasihitlu beach',1,'[{"added": {}}]',9,1,'2024-08-31 07:27:08.711624'),
 (217,'78','History ofSasihitlu beach',1,'[{"added": {}}]',9,1,'2024-08-31 07:27:39.898661'),
 (218,'76','Tannirbhavi Beach nearby Sasihitlu beach',1,'[{"added": {}}]',10,1,'2024-08-31 07:29:06.145493'),
 (219,'77','Tannirbhavi Beach nearby Sasihitlu beach',1,'[{"added": {}}]',10,1,'2024-08-31 07:30:35.665989'),
 (220,'78','St. Aloysius Chapel nearby Sasihitlu beach',1,'[{"added": {}}]',10,1,'2024-08-31 07:31:29.632141'),
 (221,'76','Kudroli Gokarnath Temple nearby Sasihitlu beach',2,'[{"changed": {"fields": ["Placename", "Desc"]}}]',10,1,'2024-08-31 07:33:15.930108'),
 (222,'76','History ofSasihitlu beach',2,'[{"changed": {"fields": ["Info"]}}]',9,1,'2024-08-31 07:34:15.442841'),
 (223,'78','St. Aloysius Chapel nearby Sasihitlu beach',2,'[{"changed": {"fields": ["Desc"]}}]',10,1,'2024-08-31 07:35:35.090283'),
 (224,'27','Kemmangundi Hill stationinKarnataka',1,'[{"added": {}}]',8,1,'2024-08-31 09:36:13.914472'),
 (225,'79','History ofKemmangundi Hill station',1,'[{"added": {}}]',9,1,'2024-08-31 09:37:02.827443'),
 (226,'80','History ofKemmangundi Hill station',1,'[{"added": {}}]',9,1,'2024-08-31 09:37:30.877731'),
 (227,'81','History ofKemmangundi Hill station',1,'[{"added": {}}]',9,1,'2024-08-31 09:39:19.079804'),
 (228,'79','Raj Bhavan nearby Kemmangundi Hill station',1,'[{"added": {}}]',10,1,'2024-08-31 09:40:27.366021'),
 (229,'80','Hebbe Falls nearby Kemmangundi Hill station',1,'[{"added": {}}]',10,1,'2024-08-31 09:41:33.187075'),
 (230,'81','Z Point nearby Kemmangundi Hill station',1,'[{"added": {}}]',10,1,'2024-08-31 09:42:16.407273'),
 (231,'27','Kemmangundi Hill stationinKarnataka',2,'[{"changed": {"fields": ["Story"]}}]',8,1,'2024-08-31 09:43:17.879543'),
 (232,'81','Z Point nearby Kemmangundi Hill station',2,'[{"changed": {"fields": ["Desc"]}}]',10,1,'2024-08-31 09:45:56.637779'),
 (233,'28','HonnemaraduinKarnataka',1,'[{"added": {}}]',8,1,'2024-08-31 09:47:06.386174'),
 (234,'82','History ofHonnemaradu',1,'[{"added": {}}]',9,1,'2024-08-31 09:48:06.585423'),
 (235,'83','History ofHonnemaradu',1,'[{"added": {}}]',9,1,'2024-08-31 09:49:11.765873'),
 (236,'84','History ofHonnemaradu',1,'[{"added": {}}]',9,1,'2024-08-31 09:50:03.879943'),
 (237,'82','Sigandur Chowdeshwari Temple nearby Honnemaradu',1,'[{"added": {}}]',10,1,'2024-08-31 09:51:30.627608'),
 (238,'83','Jog Falls nearby Honnemaradu',1,'[{"added": {}}]',10,1,'2024-08-31 09:52:10.997242'),
 (239,'84','Ikkeri and Keladi nearby Honnemaradu',1,'[{"added": {}}]',10,1,'2024-08-31 09:53:37.685638'),
 (240,'29','Kavledurga fortinKarnataka',1,'[{"added": {}}]',8,1,'2024-08-31 09:56:05.429169'),
 (241,'85','History ofKavledurga fort',1,'[{"added": {}}]',9,1,'2024-08-31 09:56:51.163889'),
 (242,'86','History ofKavledurga fort',1,'[{"added": {}}]',9,1,'2024-08-31 09:57:36.000560'),
 (243,'86','History ofKavledurga fort',2,'[{"changed": {"fields": ["Head", "Info"]}}]',9,1,'2024-08-31 09:58:19.304219'),
 (244,'87','History ofKavledurga fort',1,'[{"added": {}}]',9,1,'2024-08-31 09:59:48.412721'),
 (245,'85','Nagara Fort nearby Kavledurga fort',1,'[{"added": {}}]',10,1,'2024-08-31 10:01:00.950318'),
 (246,'86','Agumbe nearby Kavledurga fort',1,'[{"added": {}}]',10,1,'2024-08-31 10:02:55.573057'),
 (247,'87','Thirthahalli nearby Kavledurga fort',1,'[{"added": {}}]',10,1,'2024-08-31 10:04:09.813692'),
 (248,'3','Himachal Pradesh',2,'[]',11,1,'2024-09-01 01:45:20.666777'),
 (249,'30','Hatu peak NarkandainHimachal Pradesh',1,'[{"added": {}}]',8,1,'2024-09-01 01:46:18.999055'),
 (250,'88','History ofHatu peak Narkanda',1,'[{"added": {}}]',9,1,'2024-09-01 01:47:19.465937'),
 (251,'89','History ofHatu peak Narkanda',1,'[{"added": {}}]',9,1,'2024-09-01 01:47:40.386861'),
 (252,'88','History ofHatu peak Narkanda',2,'[{"changed": {"fields": ["Info"]}}]',9,1,'2024-09-01 01:51:26.955658'),
 (253,'89','History ofHatu peak Narkanda',2,'[{"changed": {"fields": ["Info"]}}]',9,1,'2024-09-01 01:51:55.737535'),
 (254,'90','History ofHatu peak Narkanda',1,'[{"added": {}}]',9,1,'2024-09-01 01:52:20.702260'),
 (255,'88','Ratnari Temple nearby Hatu peak Narkanda',1,'[{"added": {}}]',10,1,'2024-09-01 01:53:31.685889'),
 (256,'89','Kotkhai nearby Hatu peak Narkanda',1,'[{"added": {}}]',10,1,'2024-09-01 01:54:04.619125'),
 (257,'90','Chirgaon nearby Hatu peak Narkanda',1,'[{"added": {}}]',10,1,'2024-09-01 01:55:15.150514'),
 (258,'31','ChitkulinHimachal Pradesh',1,'[{"added": {}}]',8,1,'2024-09-01 01:57:51.811274'),
 (259,'91','History ofChitkul',1,'[{"added": {}}]',9,1,'2024-09-01 01:58:38.904845'),
 (260,'92','History ofChitkul',1,'[{"added": {}}]',9,1,'2024-09-01 01:59:20.195492'),
 (261,'93','History ofChitkul',1,'[{"added": {}}]',9,1,'2024-09-01 01:59:38.675908'),
 (262,'91','Sangla Valley nearby Chitkul',1,'[{"added": {}}]',10,1,'2024-09-01 02:00:31.575872'),
 (263,'92','Kalpa nearby Chitkul',1,'[{"added": {}}]',10,1,'2024-09-01 02:01:10.947720'),
 (264,'93','Rakchham nearby Chitkul',1,'[{"added": {}}]',10,1,'2024-09-01 02:01:46.174695'),
 (265,'32','Pabbar valleyinHimachal Pradesh',1,'[{"added": {}}]',8,1,'2024-09-01 02:03:49.538288'),
 (266,'94','History ofPabbar valley',1,'[{"added": {}}]',9,1,'2024-09-01 02:04:31.583104'),
 (267,'95','History ofPabbar valley',1,'[{"added": {}}]',9,1,'2024-09-01 02:05:19.930176'),
 (268,'96','History ofPabbar valley',1,'[{"added": {}}]',9,1,'2024-09-01 02:06:00.766263'),
 (269,'94','Hatkoti Temple nearby Pabbar valley',1,'[{"added": {}}]',10,1,'2024-09-01 02:06:59.516783'),
 (270,'95','Rohru nearby Pabbar valley',1,'[{"added": {}}]',10,1,'2024-09-01 02:08:57.764134'),
 (271,'96','Jalori Pass nearby Pabbar valley',1,'[{"added": {}}]',10,1,'2024-09-01 02:09:44.803846'),
 (272,'33','ShangarhinHimachal Pradesh',1,'[{"added": {}}]',8,1,'2024-09-01 02:12:07.035927'),
 (273,'97','History ofShangarh',1,'[{"added": {}}]',9,1,'2024-09-01 02:15:25.258392'),
 (274,'98','History ofShangarh',1,'[{"added": {}}]',9,1,'2024-09-01 02:16:14.205894'),
 (275,'99','History ofShangarh',1,'[{"added": {}}]',9,1,'2024-09-01 02:16:54.174917'),
 (276,'97','Sainj Valley nearby Shangarh',1,'[{"added": {}}]',10,1,'2024-09-01 02:17:58.147820'),
 (277,'98','Tirthan Valley nearby Shangarh',1,'[{"added": {}}]',10,1,'2024-09-01 02:19:07.136104'),
 (278,'99','Jibhi nearby Shangarh',1,'[{"added": {}}]',10,1,'2024-09-01 02:19:48.807973'),
 (279,'34','Shoja VillageinHimachal Pradesh',1,'[{"added": {}}]',8,1,'2024-09-01 02:21:53.085971'),
 (280,'100','History ofShoja Village',1,'[{"added": {}}]',9,1,'2024-09-01 02:23:43.267470'),
 (281,'101','History ofShoja Village',1,'[{"added": {}}]',9,1,'2024-09-01 02:24:16.245847'),
 (282,'102','History ofShoja Village',1,'[{"added": {}}]',9,1,'2024-09-01 02:24:49.045831'),
 (283,'100','Jalori Pass nearby Shoja Village',1,'[{"added": {}}]',10,1,'2024-09-01 02:25:41.828530'),
 (284,'101','Serolsar Lake nearby Shoja Village',1,'[{"added": {}}]',10,1,'2024-09-01 02:26:33.284933'),
 (285,'102','Tirthan Valley nearby Shoja Village',1,'[{"added": {}}]',10,1,'2024-09-01 02:27:26.454252'),
 (286,'35','Barot valleyinHimachal Pradesh',1,'[{"added": {}}]',8,1,'2024-09-01 02:29:32.379165'),
 (287,'103','History ofBarot valley',1,'[{"added": {}}]',9,1,'2024-09-01 02:30:16.056606'),
 (288,'104','History ofBarot valley',1,'[{"added": {}}]',9,1,'2024-09-01 02:30:42.441832'),
 (289,'105','History ofBarot valley',1,'[{"added": {}}]',9,1,'2024-09-01 02:31:12.612266'),
 (290,'103','Barot Dam (Shanan Power House) nearby Barot valley',1,'[{"added": {}}]',10,1,'2024-09-01 02:33:16.845040'),
 (291,'104','Rajgundha Valley nearby Barot valley',1,'[{"added": {}}]',10,1,'2024-09-01 02:34:02.256966'),
 (292,'105','Nargu Wildlife Sanctuary nearby Barot valley',1,'[{"added": {}}]',10,1,'2024-09-01 02:34:41.567969'),
 (293,'36','Khejarla FortinRajasthan',1,'[{"added": {}}]',8,1,'2024-09-01 07:36:20.706283'),
 (294,'106','History ofKhejarla Fort',1,'[{"added": {}}]',9,1,'2024-09-01 07:37:37.330102'),
 (295,'107','History ofKhejarla Fort',1,'[{"added": {}}]',9,1,'2024-09-01 07:37:52.115088'),
 (296,'108','History ofKhejarla Fort',1,'[{"added": {}}]',9,1,'2024-09-01 07:38:04.586120'),
 (297,'106','Jodhpur nearby Khejarla Fort',1,'[{"added": {}}]',10,1,'2024-09-01 07:39:09.307563'),
 (298,'107','Osian nearby Khejarla Fort',1,'[{"added": {}}]',10,1,'2024-09-01 07:39:47.118929'),
 (299,'108','Mandore Gardens nearby Khejarla Fort',1,'[{"added": {}}]',10,1,'2024-09-01 07:40:55.853555'),
 (300,'37','Thar DesertinRajasthan',1,'[{"added": {}}]',8,1,'2024-09-01 07:43:09.030689'),
 (301,'109','History ofThar Desert',1,'[{"added": {}}]',9,1,'2024-09-01 07:43:42.618356'),
 (302,'110','History ofThar Desert',1,'[{"added": {}}]',9,1,'2024-09-01 07:44:27.242425'),
 (303,'111','History ofThar Desert',1,'[{"added": {}}]',9,1,'2024-09-01 07:44:43.325001'),
 (304,'109','Jaisalmer nearby Thar Desert',1,'[{"added": {}}]',10,1,'2024-09-01 07:45:34.645584'),
 (305,'110','Bada Bagh nearby Thar Desert',1,'[{"added": {}}]',10,1,'2024-09-01 07:46:56.578165'),
 (306,'111','Kuldhara nearby Thar Desert',1,'[{"added": {}}]',10,1,'2024-09-01 07:47:30.748655'),
 (307,'37','Thar DesertinRajasthan',2,'[{"changed": {"fields": ["Image1"]}}]',8,1,'2024-09-01 07:48:03.048790'),
 (308,'37','Thar DesertinRajasthan',2,'[{"changed": {"fields": ["Image1", "Image3"]}}]',8,1,'2024-09-01 07:48:50.303844'),
 (309,'38','Khimsar villageinRajasthan',1,'[{"added": {}}]',8,1,'2024-09-01 07:51:15.648667'),
 (310,'112','History ofKhimsar village',1,'[{"added": {}}]',9,1,'2024-09-01 07:53:02.447481'),
 (311,'113','History ofKhimsar village',1,'[{"added": {}}]',9,1,'2024-09-01 07:55:18.836067'),
 (312,'114','History ofKhimsar village',1,'[{"added": {}}]',9,1,'2024-09-01 07:55:37.198984'),
 (313,'112','Nagaur Fort nearby Khimsar village',1,'[{"added": {}}]',10,1,'2024-09-01 07:58:47.747979'),
 (314,'113','Osian nearby Khimsar village',1,'[{"added": {}}]',10,1,'2024-09-01 07:59:22.377146'),
 (315,'114','Jaisalmer nearby Khimsar village',1,'[{"added": {}}]',10,1,'2024-09-01 07:59:58.446545'),
 (316,'38','Khimsar villageinRajasthan',2,'[{"changed": {"fields": ["Image1", "Image3"]}}]',8,1,'2024-09-01 08:01:13.080343'),
 (317,'39','Sambhar lakeinRajasthan',1,'[{"added": {}}]',8,1,'2024-09-01 08:02:20.321481'),
 (318,'115','History ofSambhar lake',1,'[{"added": {}}]',9,1,'2024-09-01 08:03:44.491894'),
 (319,'116','History ofSambhar lake',1,'[{"added": {}}]',9,1,'2024-09-01 08:03:57.064140'),
 (320,'117','History ofSambhar lake',1,'[{"added": {}}]',9,1,'2024-09-01 08:04:51.992691'),
 (321,'115','Sambhar Town nearby Sambhar lake',1,'[{"added": {}}]',10,1,'2024-09-01 08:06:01.599340'),
 (322,'116','Ratangarh Fort nearby Sambhar lake',1,'[{"added": {}}]',10,1,'2024-09-01 08:06:32.598654'),
 (323,'117','Kishangarh nearby Sambhar lake',1,'[{"added": {}}]',10,1,'2024-09-01 08:07:11.274875'),
 (324,'40','BanswarainRajasthan',1,'[{"added": {}}]',8,1,'2024-09-01 08:08:39.111858'),
 (325,'118','History ofBanswara',1,'[{"added": {}}]',9,1,'2024-09-01 08:09:18.441508'),
 (326,'119','History ofBanswara',1,'[{"added": {}}]',9,1,'2024-09-01 08:09:30.246451'),
 (327,'120','History ofBanswara',1,'[{"added": {}}]',9,1,'2024-09-01 08:09:44.893227'),
 (328,'118','Mahi Dam nearby Banswara',1,'[{"added": {}}]',10,1,'2024-09-01 08:10:55.094073'),
 (329,'119','Chakrarath Temple nearby Banswara',1,'[{"added": {}}]',10,1,'2024-09-01 08:11:30.633449'),
 (330,'120','Tripura Sundari Temple nearby Banswara',1,'[{"added": {}}]',10,1,'2024-09-01 08:12:04.566752'),
 (331,'41','Kumbhalgarh FortinRajasthan',1,'[{"added": {}}]',8,1,'2024-09-01 08:14:31.315576'),
 (332,'121','History ofKumbhalgarh Fort',1,'[{"added": {}}]',9,1,'2024-09-01 08:14:51.580000'),
 (333,'122','History ofKumbhalgarh Fort',1,'[{"added": {}}]',9,1,'2024-09-01 08:15:04.265150'),
 (334,'123','History ofKumbhalgarh Fort',1,'[{"added": {}}]',9,1,'2024-09-01 08:15:18.014627'),
 (335,'121','Mewar Historical Library nearby Kumbhalgarh Fort',1,'[{"added": {}}]',10,1,'2024-09-01 08:16:13.690176'),
 (336,'122','Haldighati nearby Kumbhalgarh Fort',1,'[{"added": {}}]',10,1,'2024-09-01 08:17:10.927467'),
 (337,'123','Ranakpur Jain Temple nearby Kumbhalgarh Fort',1,'[{"added": {}}]',10,1,'2024-09-01 08:17:43.793864'),
 (338,'41','Kumbhalgarh FortinRajasthan',2,'[{"changed": {"fields": ["Image1", "Image2"]}}]',8,1,'2024-09-01 08:18:41.513635'),
 (339,'42','Salaulim daminGoa',1,'[{"added": {}}]',8,1,'2024-09-01 08:21:57.206624'),
 (340,'124','History ofSalaulim dam',1,'[{"added": {}}]',9,1,'2024-09-01 08:22:39.036038'),
 (341,'125','History ofSalaulim dam',1,'[{"added": {}}]',9,1,'2024-09-01 08:22:54.958565'),
 (342,'126','History ofSalaulim dam',1,'[{"added": {}}]',9,1,'2024-09-01 08:23:10.027963'),
 (343,'124','Netravali Wildlife Sanctuary nearby Salaulim dam',1,'[{"added": {}}]',10,1,'2024-09-01 08:23:52.547204'),
 (344,'125','Tambdi Surla Temple nearby Salaulim dam',1,'[{"added": {}}]',10,1,'2024-09-01 08:24:30.437889'),
 (345,'126','Bhagwan Mahavir Wildlife Sanctuary and Mollem National Park nearby Salaulim dam',1,'[{"added": {}}]',10,1,'2024-09-01 08:25:12.757870'),
 (346,'15','Goa',2,'[{"changed": {"fields": ["Direction"]}}]',11,1,'2024-09-01 08:26:03.497814'),
 (347,'43','Cola beachinGoa',1,'[{"added": {}}]',8,1,'2024-09-01 09:22:43.713984'),
 (348,'127','History ofCola beach',1,'[{"added": {}}]',9,1,'2024-09-01 09:23:08.368608'),
 (349,'128','History ofCola beach',1,'[{"added": {}}]',9,1,'2024-09-01 09:23:47.698133'),
 (350,'129','History ofCola beach',1,'[{"added": {}}]',9,1,'2024-09-01 09:24:01.254722'),
 (351,'127','Agonda Beach nearby Cola beach',1,'[{"added": {}}]',10,1,'2024-09-01 09:24:39.915159'),
 (352,'128','Palolem Beach nearby Cola beach',1,'[{"added": {}}]',10,1,'2024-09-01 09:25:09.023382'),
 (353,'129','Cotigao Wildlife Sanctuary nearby Cola beach',1,'[{"added": {}}]',10,1,'2024-09-01 09:25:47.278187'),
 (354,'43','Cola beachinGoa',2,'[{"changed": {"fields": ["Image1", "Image2"]}}]',8,1,'2024-09-01 09:26:24.421276'),
 (355,'44','Cabo de Rama beachinGoa',1,'[{"added": {}}]',8,1,'2024-09-01 09:27:20.421401'),
 (356,'130','History ofCabo de Rama beach',1,'[{"added": {}}]',9,1,'2024-09-01 09:28:08.603518'),
 (357,'131','History ofCabo de Rama beach',1,'[{"added": {}}]',9,1,'2024-09-01 09:28:24.353941'),
 (358,'132','History ofCabo de Rama beach',1,'[{"added": {}}]',9,1,'2024-09-01 09:28:41.297607'),
 (359,'130','Cabo de Rama Fort nearby Cabo de Rama beach',1,'[{"added": {}}]',10,1,'2024-09-01 09:29:19.230813'),
 (360,'131','Betul Beach nearby Cabo de Rama beach',1,'[{"added": {}}]',10,1,'2024-09-01 09:29:52.514892'),
 (361,'132','Dudhsagar Waterfalls nearby Cabo de Rama beach',1,'[{"added": {}}]',10,1,'2024-09-01 09:30:28.816923'),
 (362,'45','Devil’s Finger CaveinGoa',1,'[{"added": {}}]',8,1,'2024-09-01 09:31:41.308346'),
 (363,'133','History ofDevil’s Finger Cave',1,'[{"added": {}}]',9,1,'2024-09-01 09:34:12.410211'),
 (364,'134','History ofDevil’s Finger Cave',1,'[{"added": {}}]',9,1,'2024-09-01 09:34:30.498798'),
 (365,'135','History ofDevil’s Finger Cave',1,'[{"added": {}}]',9,1,'2024-09-01 09:34:44.870241'),
 (366,'133','Bambolim Beach nearby Cabo de Rama beach',1,'[{"added": {}}]',10,1,'2024-09-01 09:35:19.883147'),
 (367,'134','Miramar Beach nearby Devil’s Finger Cave',1,'[{"added": {}}]',10,1,'2024-09-01 09:35:50.208848'),
 (368,'135','Chorla Ghat nearby Devil’s Finger Cave',1,'[{"added": {}}]',10,1,'2024-09-01 09:36:18.528168'),
 (369,'133','Bambolim Beach nearby Devil’s Finger Cave',2,'[{"changed": {"fields": ["Main place"]}}]',10,1,'2024-09-01 09:37:49.584063'),
 (370,'46','Sanguem villageinGoa',1,'[{"added": {}}]',8,1,'2024-09-01 09:38:52.803345'),
 (371,'136','History ofSanguem village',1,'[{"added": {}}]',9,1,'2024-09-01 09:39:45.609124'),
 (372,'137','History ofSanguem village',1,'[{"added": {}}]',9,1,'2024-09-01 09:40:10.552219'),
 (373,'138','History ofSanguem village',1,'[{"added": {}}]',9,1,'2024-09-01 09:40:37.158783'),
 (374,'138','History ofSanguem village',2,'[{"changed": {"fields": ["Head", "Info"]}}]',9,1,'2024-09-01 09:41:02.196833'),
 (375,'136','Tambdi Surla Temple nearby Sanguem village',1,'[{"added": {}}]',10,1,'2024-09-01 09:41:54.738498'),
 (376,'137','Bhagwan Mahavir Wildlife Sanctuary nearby Sanguem village',1,'[{"added": {}}]',10,1,'2024-09-01 09:42:29.092638'),
 (377,'138','Dudhsagar Waterfalls nearby Sanguem village',1,'[{"added": {}}]',10,1,'2024-09-01 09:43:03.986123'),
 (378,'47','Butterfly beachinGoa',1,'[{"added": {}}]',8,1,'2024-09-01 09:44:35.650077'),
 (379,'139','History ofSanguem village',1,'[{"added": {}}]',9,1,'2024-09-01 09:45:53.513134'),
 (380,'140','History ofButterfly beach',1,'[{"added": {}}]',9,1,'2024-09-01 09:46:30.262956'),
 (381,'141','History ofButterfly beach',1,'[{"added": {}}]',9,1,'2024-09-01 09:46:53.860833'),
 (382,'139','Canacona Market nearby Butterfly beach',1,'[{"added": {}}]',10,1,'2024-09-01 09:47:31.243791'),
 (383,'140','Netravali Wildlife Sanctuary nearby Butterfly beach',1,'[{"added": {}}]',10,1,'2024-09-01 09:48:00.099782'),
 (384,'141','Cotigao Wildlife Sanctuary nearby Butterfly beach',1,'[{"added": {}}]',10,1,'2024-09-01 09:48:34.428839'),
 (385,'47','Butterfly beachinGoa',2,'[{"changed": {"fields": ["Image1", "Image2"]}}]',8,1,'2024-09-01 09:49:16.547426'),
 (386,'48','MawlynnonginMeghalaya',1,'[{"added": {}}]',8,1,'2024-09-01 15:43:44.707774'),
 (387,'142','History ofMawlynnong',1,'[{"added": {}}]',9,1,'2024-09-01 15:44:09.270562'),
 (388,'143','History ofMawlynnong',1,'[{"added": {}}]',9,1,'2024-09-01 15:44:22.608974'),
 (389,'144','History ofMawlynnong',1,'[{"added": {}}]',9,1,'2024-09-01 15:44:38.161457'),
 (390,'142','Living Root Bridges nearby Mawlynnong',1,'[{"added": {}}]',10,1,'2024-09-01 15:45:24.927920'),
 (391,'143','Dawki nearby Mawlynnong',1,'[{"added": {}}]',10,1,'2024-09-01 15:45:54.648075'),
 (392,'144','Shillong nearby Mawlynnong',1,'[{"added": {}}]',10,1,'2024-09-01 15:46:32.062555'),
 (393,'49','Mawphlang Sacred ForestinMeghalaya',1,'[{"added": {}}]',8,1,'2024-09-01 16:12:28.300144'),
 (394,'145','History ofMawphlang Sacred Forest',1,'[{"added": {}}]',9,1,'2024-09-01 16:13:04.580130'),
 (395,'146','History ofMawphlang Sacred Forest',1,'[{"added": {}}]',9,1,'2024-09-01 16:13:15.978958'),
 (396,'147','History ofMawphlang Sacred Forest',1,'[{"added": {}}]',9,1,'2024-09-01 16:13:27.201350'),
 (397,'145','Laitlum Canyons nearby Mawphlang Sacred Forest',1,'[{"added": {}}]',10,1,'2024-09-01 16:16:00.443761'),
 (398,'146','Elephant Falls nearby Mawphlang Sacred Forest',1,'[{"added": {}}]',10,1,'2024-09-01 16:16:32.000807'),
 (399,'147','Shillong Peak nearby Mawphlang Sacred Forest',1,'[{"added": {}}]',10,1,'2024-09-01 16:17:04.593772'),
 (400,'50','RanikorinMeghalaya',1,'[{"added": {}}]',8,1,'2024-09-01 16:18:37.749653'),
 (401,'148','History ofRanikor',1,'[{"added": {}}]',9,1,'2024-09-01 16:19:03.318583'),
 (402,'149','History ofRanikor',1,'[{"added": {}}]',9,1,'2024-09-01 16:19:15.091749'),
 (403,'150','History ofRanikor',1,'[{"added": {}}]',9,1,'2024-09-01 16:19:31.299355'),
 (404,'148','Nohkalikai Falls nearby Ranikor',1,'[{"added": {}}]',10,1,'2024-09-01 16:20:10.837188'),
 (405,'149','Mawsmai Cave nearby Ranikor',1,'[{"added": {}}]',10,1,'2024-09-01 16:20:42.063910'),
 (406,'150','Dawki nearby Ranikor',1,'[{"added": {}}]',10,1,'2024-09-01 16:21:06.774518'),
 (407,'51','Garden of CavesinMeghalaya',1,'[{"added": {}}]',8,1,'2024-09-01 16:22:33.706008'),
 (408,'151','History ofGarden of Caves',1,'[{"added": {}}]',9,1,'2024-09-01 16:22:50.684826'),
 (409,'152','History ofGarden of Caves',1,'[{"added": {}}]',9,1,'2024-09-01 16:23:07.099756'),
 (410,'153','History ofGarden of Caves',1,'[{"added": {}}]',9,1,'2024-09-01 16:23:20.014795'),
 (411,'151','Laitlum Canyons nearby Garden of Caves',1,'[{"added": {}}]',10,1,'2024-09-01 16:23:53.415071'),
 (412,'152','Elephant Falls nearby Garden of Caves',1,'[{"added": {}}]',10,1,'2024-09-01 16:24:57.775114'),
 (413,'153','Shillong Peak nearby Garden of Caves',1,'[{"added": {}}]',10,1,'2024-09-01 16:25:25.525916'),
 (414,'52','Dawki RiverinMeghalaya',1,'[{"added": {}}]',8,1,'2024-09-01 16:27:31.157317'),
 (415,'154','History ofDawki River',1,'[{"added": {}}]',9,1,'2024-09-01 16:27:49.149938'),
 (416,'155','History ofDawki River',1,'[{"added": {}}]',9,1,'2024-09-01 16:28:02.351653'),
 (417,'156','History ofDawki River',1,'[{"added": {}}]',9,1,'2024-09-01 16:28:15.290360'),
 (418,'154','Shnongpdeng nearby Dawki River',1,'[{"added": {}}]',10,1,'2024-09-01 16:28:53.125753'),
 (419,'155','Jaflong nearby Dawki River',1,'[{"added": {}}]',10,1,'2024-09-01 16:29:20.827894'),
 (420,'156','Cherrapunji nearby Dawki River',1,'[{"added": {}}]',10,1,'2024-09-01 16:29:50.262509'),
 (421,'53','LaitkynsewinMeghalaya',1,'[{"added": {}}]',8,1,'2024-09-01 16:31:31.647246'),
 (422,'157','History ofLaitkynsew',1,'[{"added": {}}]',9,1,'2024-09-01 16:32:07.256743'),
 (423,'158','History ofLaitkynsew',1,'[{"added": {}}]',9,1,'2024-09-01 16:32:18.567722'),
 (424,'159','History ofLaitkynsew',1,'[{"added": {}}]',9,1,'2024-09-01 16:32:31.877485'),
 (425,'157','Nongriat Village nearby Laitkynsew',1,'[{"added": {}}]',10,1,'2024-09-01 16:33:12.853035'),
 (426,'158','Mawsmai Cave nearby Laitkynsew',1,'[{"added": {}}]',10,1,'2024-09-01 16:33:41.240007'),
 (427,'159','Nohkalikai Falls nearby Laitkynsew',1,'[{"added": {}}]',10,1,'2024-09-01 16:34:13.362442'),
 (428,'158','Mawsmai Cave nearby Laitkynsew',2,'[{"changed": {"fields": ["Desc"]}}]',10,1,'2024-09-01 16:35:47.220479'),
 (429,'54','MeghamalaiinTamilnadu',1,'[{"added": {}}]',8,1,'2024-09-01 16:41:44.175999'),
 (430,'160','History ofMeghamalai',1,'[{"added": {}}]',9,1,'2024-09-01 16:42:13.926485'),
 (431,'161','History ofMeghamalai',1,'[{"added": {}}]',9,1,'2024-09-01 16:42:26.817041'),
 (432,'162','History ofMeghamalai',1,'[{"added": {}}]',9,1,'2024-09-01 16:42:40.288588'),
 (433,'160','Suruli Falls nearby Meghamalai',1,'[{"added": {}}]',10,1,'2024-09-01 16:43:23.776565'),
 (434,'161','Vaigai Dam nearby Meghamalai',1,'[{"added": {}}]',10,1,'2024-09-01 16:43:55.680698'),
 (435,'162','Bodinayakkanur nearby Meghamalai',1,'[{"added": {}}]',10,1,'2024-09-01 16:44:28.620713'),
 (436,'55','Javadi hillsinTamilnadu',1,'[{"added": {}}]',8,1,'2024-09-01 16:45:43.384645'),
 (437,'163','History ofJavadi hills',1,'[{"added": {}}]',9,1,'2024-09-01 16:46:00.486290'),
 (438,'164','History ofJavadi hills',1,'[{"added": {}}]',9,1,'2024-09-01 16:46:14.771814'),
 (439,'165','History ofJavadi hills',1,'[{"added": {}}]',9,1,'2024-09-01 16:46:29.175130'),
 (440,'163','Amirthi Zoological Park nearby Javadi hills',1,'[{"added": {}}]',10,1,'2024-09-01 16:47:07.038510'),
 (441,'164','Yelagiri Hills nearby Javadi hills',1,'[{"added": {}}]',10,1,'2024-09-01 16:47:45.325026'),
 (442,'165','Gingee Fort nearby Javadi hills',1,'[{"added": {}}]',10,1,'2024-09-01 16:48:18.995449'),
 (443,'56','ValparaiinTamilnadu',1,'[{"added": {}}]',8,1,'2024-09-01 17:01:37.689034'),
 (444,'166','History ofValparai',1,'[{"added": {}}]',9,1,'2024-09-01 17:01:57.348465'),
 (445,'167','History ofValparai',1,'[{"added": {}}]',9,1,'2024-09-01 17:02:08.993658'),
 (446,'168','History ofValparai',1,'[{"added": {}}]',9,1,'2024-09-01 17:02:21.026646'),
 (447,'166','Aliyar Dam nearby Valparai',1,'[{"added": {}}]',10,1,'2024-09-01 17:03:07.559234'),
 (448,'167','Monkey Falls nearby Valparai',1,'[{"added": {}}]',10,1,'2024-09-01 17:03:45.473094'),
 (449,'168','3.	Indira Gandhi Wildlife Sanctuary and National Park nearby Valparai',1,'[{"added": {}}]',10,1,'2024-09-01 17:04:26.875531'),
 (450,'57','KumbakonaminTamilnadu',1,'[{"added": {}}]',8,1,'2024-09-01 17:05:55.671976'),
 (451,'169','History ofKumbakonam',1,'[{"added": {}}]',9,1,'2024-09-01 17:06:12.877084'),
 (452,'170','History ofKumbakonam',1,'[{"added": {}}]',9,1,'2024-09-01 17:06:24.371425'),
 (453,'171','History ofKumbakonam',1,'[{"added": {}}]',9,1,'2024-09-01 17:06:36.782297'),
 (454,'169','Darasuram nearby Kumbakonam',1,'[{"added": {}}]',10,1,'2024-09-01 17:07:13.132586'),
 (455,'170','Swamimalai nearby Kumbakonam',1,'[{"added": {}}]',10,1,'2024-09-01 17:07:44.320761'),
 (456,'171','Gangaikonda Cholapuram nearby Kumbakonam',1,'[{"added": {}}]',10,1,'2024-09-01 17:08:20.226365'),
 (457,'58','Pichavaram Mangrove ForestinTamilnadu',1,'[{"added": {}}]',8,1,'2024-09-01 17:09:41.183669'),
 (458,'172','History ofPichavaram Mangrove Forest',1,'[{"added": {}}]',9,1,'2024-09-01 17:09:57.855672'),
 (459,'173','History ofPichavaram Mangrove Forest',1,'[{"added": {}}]',9,1,'2024-09-01 17:10:10.984782'),
 (460,'174','History ofPichavaram Mangrove Forest',1,'[{"added": {}}]',9,1,'2024-09-01 17:10:22.214270'),
 (461,'172','Chidambaram Nataraja Temple nearby Pichavaram Mangrove Forest',1,'[{"added": {}}]',10,1,'2024-09-01 17:10:58.041876'),
 (462,'173','Thillai Kali Amman Temple nearby Pichavaram Mangrove Forest',1,'[{"added": {}}]',10,1,'2024-09-01 17:11:34.833160'),
 (463,'174','Poompuhar (Kaveripoompattinam) nearby Pichavaram Mangrove Forest',1,'[{"added": {}}]',10,1,'2024-09-01 17:12:21.145396'),
 (464,'59','ManapadinTamilnadu',1,'[{"added": {}}]',8,1,'2024-09-01 17:13:31.825950'),
 (465,'175','History ofManapad',1,'[{"added": {}}]',9,1,'2024-09-01 17:13:49.103708'),
 (466,'176','History ofManapad',1,'[{"added": {}}]',9,1,'2024-09-01 17:14:01.366973'),
 (467,'177','History ofManapad',1,'[{"added": {}}]',9,1,'2024-09-01 17:14:11.992590'),
 (468,'175','Tiruchendur Murugan Temple nearby Manapad',1,'[{"added": {}}]',10,1,'2024-09-01 17:15:01.488831'),
 (469,'176','Panchalankurichi Fort nearby Manapad',1,'[{"added": {}}]',10,1,'2024-09-01 17:16:15.193277'),
 (470,'177','Manimuthar Waterfalls nearby Manapad',1,'[{"added": {}}]',10,1,'2024-09-01 17:16:49.982458');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (1,'admin','logentry'),
 (2,'auth','permission'),
 (3,'auth','group'),
 (4,'auth','user'),
 (5,'contenttypes','contenttype'),
 (6,'sessions','session'),
 (7,'app','user'),
 (8,'app','place'),
 (9,'app','hist_back'),
 (10,'app','nearby_place'),
 (11,'app','state'),
 (12,'app','travel_and_cost'),
 (13,'app','review');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (1,'contenttypes','0001_initial','2024-07-25 12:14:55.367196'),
 (2,'auth','0001_initial','2024-07-25 12:14:55.410399'),
 (3,'admin','0001_initial','2024-07-25 12:14:55.426761'),
 (4,'admin','0002_logentry_remove_auto_add','2024-07-25 12:14:55.460045'),
 (5,'admin','0003_logentry_add_action_flag_choices','2024-07-25 12:14:55.476807'),
 (6,'contenttypes','0002_remove_content_type_name','2024-07-25 12:14:55.526790'),
 (7,'auth','0002_alter_permission_name_max_length','2024-07-25 12:14:55.576393'),
 (8,'auth','0003_alter_user_email_max_length','2024-07-25 12:14:55.593133'),
 (9,'auth','0004_alter_user_username_opts','2024-07-25 12:14:55.609671'),
 (10,'auth','0005_alter_user_last_login_null','2024-07-25 12:14:55.643057'),
 (11,'auth','0006_require_contenttypes_0002','2024-07-25 12:14:55.643057'),
 (12,'auth','0007_alter_validators_add_error_messages','2024-07-25 12:14:55.676367'),
 (13,'auth','0008_alter_user_username_max_length','2024-07-25 12:14:55.692872'),
 (14,'auth','0009_alter_user_last_name_max_length','2024-07-25 12:14:55.726009'),
 (15,'auth','0010_alter_group_name_max_length','2024-07-25 12:14:55.742902'),
 (16,'auth','0011_update_proxy_permissions','2024-07-25 12:14:55.759549'),
 (17,'auth','0012_alter_user_first_name_max_length','2024-07-25 12:14:55.792796'),
 (18,'sessions','0001_initial','2024-07-25 12:14:55.809373'),
 (19,'app','0001_initial','2024-07-26 09:18:56.850228'),
 (20,'app','0002_remove_place_image4','2024-07-26 15:57:44.100494'),
 (21,'app','0003_remove_user_confirm_password_user_is_active_and_more','2024-07-27 04:53:05.887308'),
 (22,'app','0004_travel_and_cost','2024-09-03 17:27:31.248335'),
 (23,'app','0005_travel_and_cost_place_name','2024-09-03 17:27:31.282052'),
 (24,'app','0006_alter_travel_and_cost_place_name','2024-09-03 17:27:31.308958'),
 (25,'app','0007_delete_travel_and_cost','2024-09-03 17:27:31.317053'),
 (26,'app','0008_travel_and_cost','2024-09-03 17:27:31.340873'),
 (27,'app','0009_alter_travel_and_cost_main_place','2024-09-03 17:27:31.357669'),
 (28,'app','0010_review','2024-09-03 17:27:31.367538'),
 (29,'app','0011_alter_review_location_alter_review_name_and_more','2024-09-03 17:27:31.394792');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('bf0wutmb0d2cfpszv1q2wu2rixluq7cp','.eJxVjsEKwjAQRP8lZwnZZpO0Hr37DSHZzdqqtNC0J_HfbaGI3oaZN8O8VEzr0se1ljkOrM4K1OnXy4keZdwDvqfxNmmaxmUest4RfaRVXycuz8vB_g30qfZb22IbHJEHbwC5iOEsuXOb7oxlC8DkfCAqPgg2LUoOBIxoTSMgiNvo92Pz_gCMGjti:1sXcNx:zCppFU5Ube-VxUMxv571AInqEbiIWa2fDoxmR7wIhbs','2024-08-10 08:02:37.059839'),
 ('dscgzen8levbag5qco5n5ryb7ncmkwfj','.eJxVjDEOwjAMRe-SGUVOUlPCyM4ZIjt2SQGlUtNOiLtDpQ6w_vfef5lE61LS2nROo5izcebwuzHlh9YNyJ3qbbJ5qss8st0Uu9Nmr5Po87K7fweFWvnWLBHciSg7Ju6jE_EEnJXi0GEIqAqMER2gQvDHEJmwA--BXR8Gr-b9Afx2N9U:1sdjiz:VR5zw_rKCvII4vNBrhbxIxwhfurYLyMVKct5GCwkKvU','2024-08-27 05:05:37.868147'),
 ('58eymhdgf6yny2vsi63liri56vav9nke','.eJxVjDsOwjAQRO_iGllef-KEkp4zWLvrDQ6gRIqTCnF3sJQCNN28N_NSCfetpL3KmqaszgrU6bcj5IfMDeQ7zrdF8zJv60S6KfqgVV-XLM_L4f4dFKylrTuBgQQ4d6MDRDB-dF2MxDR8Q2BcjtybgN6F0PsYBUYyYge0wbJT7w_2wTfx:1sfmvM:YEXEIMn5jaleaCKo4IOnAdMtPZJisNn0pO3fvq79eTc','2024-09-01 20:54:52.836963'),
 ('q38tl96vcxcnqwrsy79ttq0nprz2te70','.eJxVjDsOwjAQRO_iGllef-KEkp4zWLvrDQ6gRIqTCnF3sJQCNN28N_NSCfetpL3KmqaszgrU6bcj5IfMDeQ7zrdF8zJv60S6KfqgVV-XLM_L4f4dFKylrTuBgQQ4d6MDRDB-dF2MxDR8Q2BcjtybgN6F0PsYBUYyYge0wbJT7w_2wTfx:1skqW5:Cx8xD3sDjvjuSj01S865cGocOfQBujyDhdOemu9O9Qk','2024-09-15 19:45:41.105204'),
 ('55f08vr0auh8soskrignefqx4i5p3ho7','.eJxVjDsOwjAQRO_iGllef-KEkp4zWLvrDQ6gRIqTCnF3sJQCNN28N_NSCfetpL3KmqaszgrU6bcj5IfMDeQ7zrdF8zJv60S6KfqgVV-XLM_L4f4dFKylrTuBgQQ4d6MDRDB-dF2MxDR8Q2BcjtybgN6F0PsYBUYyYge0wbJT7w_2wTfx:1skz49:NZ1VVmowEz90yOFBtxVB0TgZ9m_Zc1r7rrpP4mz9vEo','2024-09-16 04:53:25.456489'),
 ('z3zlf43aknzbthuixxk85krf9cblfb6n','.eJxVjDsOwjAQRO_iGllef-KEkp4zWLvrDQ6gRIqTCnF3sJQCNN28N_NSCfetpL3KmqaszgrU6bcj5IfMDeQ7zrdF8zJv60S6KfqgVV-XLM_L4f4dFKylrTuBgQQ4d6MDRDB-dF2MxDR8Q2BcjtybgN6F0PsYBUYyYge0wbJT7w_2wTfx:1slXJy:EJXhoCRAhVSqc2hlw1y38w5X-NFUtgLcYAOIbOIA5YA','2024-09-17 17:28:02.795037');
CREATE INDEX "app_hist_back_place_id_71c3a4d9" ON "app_hist_back" ("place_id");
CREATE INDEX "app_nearby_place_main_place_id_6f966b6a" ON "app_nearby_place" ("main_place_id");
CREATE INDEX "app_place_state_id_dcbb075a" ON "app_place" ("state_id");
CREATE INDEX "app_travel_and_cost_main_place_id_48dc2eef" ON "app_travel_and_cost" ("main_place_id");
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" ("group_id");
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" ("group_id", "permission_id");
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" ("permission_id");
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission" ("content_type_id");
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" ("content_type_id", "codename");
CREATE INDEX "auth_user_groups_group_id_97559544" ON "auth_user_groups" ("group_id");
CREATE INDEX "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" ("user_id");
CREATE UNIQUE INDEX "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" ("user_id", "group_id");
CREATE INDEX "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" ("user_id");
CREATE UNIQUE INDEX "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" ("user_id", "permission_id");
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" ("content_type_id");
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log" ("user_id");
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" ("app_label", "model");
CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session" ("expire_date");
COMMIT;
