# A bongeszo tipusa (chromium, firefox)
BROWSER = "firefox"
# Legyen-e bongeszo ablak (True - nincs, False - van) !!! Docker-ben nem mukodik a False !!!
HEADLESS = True
# Kepernyokep keszites az output/log.html-hez (True - igen, False - nem) !!! Nagy tarheyet foglalhat !!!
SCREENSHOT = False
# Hanyszor latogassa meg az oldalakat
REPEAT = 5
# A kimeneti fajl neve. Docker-ben "output/"-el kell kezdodnie.
OUTPUT_FILE = "output/results.csv"
# A meglatogatando oldalak listaja
PAGES = [
    "https://telex.hu",
    "https://google.com",
]
