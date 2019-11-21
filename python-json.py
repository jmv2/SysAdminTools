import json
import urllib.request


link = "http://samples.openweathermap.org/data/2.5/weather?zip=94040,us&appid=b6907d289e10d714a6e88b30761fae22"
req  = urllib.request.Request(link)

print(urllib.request.urlopen(req).read)