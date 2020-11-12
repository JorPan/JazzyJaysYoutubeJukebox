Review.destroy_all
User.destroy_all
Song.destroy_all



user1 = User.create(name: "Jordan", username: "JorPan", password: "123")
user2 = User.create(name: "Javaria", username: "JazzyJay", password: "123")
user3 = User.create(name: "Colter", username: "ColtUlrich", password: "123")

song1 = Song.create(title: "Stuntin", artist: "The Floozies", genre: "Funky Bass", link: "https://www.youtube.com/watch?v=5hL_ck7injw", year: 2013)
song2 = Song.create(title: "Sunroof Cadillac", artist: "The Floozies", genre: "Funky Bass", link: "https://www.youtube.com/watch?v=PgDz5-tfnTY", year: 2012)
song3 = Song.create(title: "Smash the Funk", artist: "Griz", genre: "Funky Bass", link: "https://www.youtube.com/watch?v=UsSzq5h2-tc", year: 2012)
song4 = Song.create(title: "Tiger Kingdom Space Camp", artist: "Griz", genre: "Funky Bass", link: "https://www.youtube.com/watch?v=qNzOhyo-4g8", year: 2019)
song5 = Song.create(title: "Lonesome Street", artist: "Pretty Lights", genre: "Electro Soul", link: "https://www.youtube.com/watch?v=vez4N20QBIE", year: 2009)
song6 = Song.create(title: "Hot Like Sauce", artist: "Pretty Lights", genre: "Electro Soul", link: "https://www.youtube.com/watch?v=62VASkbu1gw", year: 2008)
song7 = Song.create(title: "My Dream Last Night", artist: "Archnemesis", genre: "Electro Soul", link: "https://www.youtube.com/watch?v=A0aCGP2KUSM", year: 2014)
song8 = Song.create(title: "It's Just a Ride", artist: "Gramatik", genre: "Electro Soul", link: "https://www.youtube.com/watch?v=WoWZGBFnRnw", year: 2014)
song9 = Song.create(title: "Brave Men", artist: "Gramatik", genre: "Electro Soul", link: "https://www.youtube.com/watch?v=0H5EgF8Vjfs", year: 2014)
song10 = Song.create(title: "Gold Coast Hustle", artist: "Pretty Lights", genre: "Electro Soul", link: "https://www.youtube.com/watch?v=RHLCxaMXES0", year: 2010)
song11 = Song.create(title: "Dry Land", artist: "Late Night Radio", genre: "Electro Soul", link: "https://www.youtube.com/watch?v=9Co-nXz0Cjs", year: 2019)
song12 = Song.create(title: "Robo Booty", artist: "Opiuo", genre: "Funky Bass", link: "https://www.youtube.com/watch?v=lde91njylYo", year: 2010)
song13 = Song.create(title: "Sneakers", artist: "Opiuo", genre: "Funky Bass", link: "https://www.youtube.com/watch?v=hXkF3HNw1RQ", year: 2016)
song14 = Song.create(title: "Quack Fat", artist: "Opiuo", genre: "Funky Bass", link: "https://www.youtube.com/watch?v=Y1MkJOe3w7U", year: 2014)
song15 = Song.create(title: "Say My Name", artist: "Odesza", genre: "Future Bass", link: "https://www.youtube.com/watch?v=QMssNXBCCl0", year: 2014)
song16 = Song.create(title: "Meridian", artist: "Odesza", genre: "Future Bass", link: "https://www.youtube.com/watch?v=FcnqFPuhFs0", year: 2017)
song17 = Song.create(title: "Sunsets", artist: "Mr Kafer", genre: "Lo-Fi", link: "https://www.youtube.com/watch?v=L2qt1DdNK2g", year: 2019)
song18 = Song.create(title: "The World is Yours", artist: "Will Sessions", genre: "Jazz", link: "https://www.youtube.com/watch?v=fafWIt-ZpmA", year: 2011)
song19 = Song.create(title: "Rebirth of Cool", artist: "DJ Cam Quartet", genre: "Jazz", link: "https://www.youtube.com/watch?v=oU0ZmbBY9QI", year: 2013)
song20 = Song.create(title: "Quincy", artist: "DJ Cam Quartet", genre: "Jazz", link: "https://www.youtube.com/watch?v=gCQLKrJ3a2c", year: 2009)
song21 = Song.create(title: "It's Yours", artist: "DJ Cam Quartet", genre: "Jazz", link: "https://www.youtube.com/watch?v=Ec8vZMV0ftU", year: 2012)
song22 = Song.create(title: "Samurai Sunrise", artist: "Saib", genre: "Lo-Fi", link: "https://www.youtube.com/watch?v=LS55EqeYJCw", year: 2019)
song23 = Song.create(title: "Somewhat", artist: "Mono:Massive", genre: "Lo-Fi", link: "https://www.youtube.com/watch?v=Q8einG5IZfs", year: 2016)
song24 = Song.create(title: "Stuntin'", artist: "Kumarion", genre: "Dirty Bass", link: "https://www.youtube.com/watch?v=CmcBTHopwYc", year: 2020)
song25 = Song.create(title: "Intergalactic", artist: "DAGGZ", genre: "Dirty Bass", link: "https://www.youtube.com/watch?v=MDrEUdwndtk", year: 2020)
song26 = Song.create(title: "Evasion", artist: "Clozee", genre: "Future Bass", link: "https://www.youtube.com/watch?v=fpshjQ712c0", year: 2018)
song27 = Song.create(title: "Harmony", artist: "Clozee", genre: "Dirty Bass", link: "https://www.youtube.com/watch?v=l_KNbQFds48", year: 2017)
song28 = Song.create(title: "FNKMSTR", artist: "Pandasaywhat?!", genre: "Funky Bass", link: "https://www.youtube.com/watch?v=O5Li2dj2Bsg", year: 2017)
song29 = Song.create(title: "Swagger Wagon", artist: "Pandasaywhat?!", genre: "Funky Bass", link: "https://www.youtube.com/watch?v=-TPA7v6aca4", year: 2018)
song30 = Song.create(title: "Ooh", artist: "Pandasaywhat?!", genre: "Funky Bass", link: "https://www.youtube.com/watch?v=HL7oO5h7kM0", year: 2020)
song31 = Song.create(title: "Napoleon Hill", artist: "Harry Mack", genre: "Hip Hop", link: "https://www.youtube.com/watch?v=A12Q43RqP7s", year: 2019)
song32 = Song.create(title: "Juicy", artist: "The Notorious B.I.G.", genre: "Hip Hop", link: "https://www.youtube.com/watch?v=_JZom_gVfuw", year: 1994)
song33 = Song.create(title: "C.R.E.A.M.", artist: "Wu-Tang Clan", genre: "Hip Hop", link: "https://www.youtube.com/watch?v=or5C2jV1qRc", year: 1993)
song34 = Song.create(title: "Deadly Combination", artist: "Big L", genre: "Hip Hop", link: "https://www.youtube.com/watch?v=R_6dgJQc0x4", year: 2000)
song35 = Song.create(title: "Put It On", artist: "Big L", genre: "Hip Hop", link: "https://www.youtube.com/watch?v=WWMjRMJ0dTI", year: 1995)
song36 = Song.create(title: "Changes", artist: "Tupac", genre: "Hip Hop", link: "https://www.youtube.com/watch?v=eXvBjCO19QY", year: 1998)
song37 = Song.create(title: "Notorious B.I.G.", artist: "The Notorious B.I.G.", genre: "Hip Hop", link: "https://www.youtube.com/watch?v=fwcONrTG7nk", year: 2000)
song38 = Song.create(title: "Warning", artist: "The Notorious B.I.G.", genre: "Hip Hop", link: "https://www.youtube.com/watch?v=TbSm6HsX_ek", year: 1994)
song39 = Song.create(title: "Gimme the Loot", artist: "The Notorious B.I.G.", genre: "Hip Hop", link: "https://www.youtube.com/watch?v=gXg7JccIppM", year: 1994)
song40 = Song.create(title: "Flamboyant", artist: "Big L", genre: "Hip Hop", link: "https://www.youtube.com/watch?v=qA9grAxAZjE", year: 2000)
song41 = Song.create(title: "Give Up The Funk", artist: "Parliament Funkadelic", genre: "Funk", link: "https://www.youtube.com/watch?v=gBWH3OWfT2Y", year: 1976)
song42 = Song.create(title: "Flashlight", artist: "Parliament Funkadelic", genre: "Funk", link: "https://www.youtube.com/watch?v=4xQDMO__KZ0", year: 1977)
song43 = Song.create(title: "Mothership Connection", artist: "Parliament Funkadelic", genre: "Funk", link: "https://www.youtube.com/watch?v=sSERB93GYfw", year: 1975)
song44 = Song.create(title: "Shining Star", artist: "Earth, Wind & Fire", genre: "Funk", link: "https://www.youtube.com/watch?v=Zu9a29UR2dU", year: 1975)
song45 = Song.create(title: "Jungle Boogie", artist: "Kool & The Gang", genre: "Funk", link: "https://www.youtube.com/watch?v=QGKiC2suCHQ", year: 1973)
song46 = Song.create(title: "Brick House", artist: "Comodores", genre: "Funk", link: "https://www.youtube.com/watch?v=HhPu6GEoad8", year: 1977)
song46 = Song.create(title: "Living For The City", artist: "Stevie Wonder", genre: "Soul", link: "https://www.youtube.com/watch?v=rc0XEw4m-3w", year: 1973)
song47 = Song.create(title: "Superstition", artist: "Stevie Wonder", genre: "Soul", link: "https://www.youtube.com/watch?v=7_tmeHCO1IM", year: 1972)
song48 = Song.create(title: "Get Down Tonight", artist: "KC and the Sunshine Band", genre: "Funk", link: "https://www.youtube.com/watch?v=LHEsE9yN2CY", year: 1975)
song49 = Song.create(title: "Tell Me Something Good", artist: "Rufus", genre: "Funk", link: "https://www.youtube.com/watch?v=OB4JDJiet5M", year: 1974)
song50 = Song.create(title: "Thank You", artist: "Sly & The Family Stone", genre: "Funk", link: "https://www.youtube.com/watch?v=NOa5UOHdwnc", year: 1970)











review1 = Review.create(user: user1, song: song1, rating: 5, content: "Suuuper funky :) ")
review2 = Review.create(user: user1, song: song25, rating: 5, content: "One of my new favorites! ")
review3 = Review.create(user: user2, song: song37, rating: 5, content: "Classic ")









# binding.pry
