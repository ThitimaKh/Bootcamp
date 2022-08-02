from requests import get
import json
import pandas as pd

# endpoint
url = "https://api.travelpayouts.com/data/en/cities.json"
response = get(url)
response.status_code

resp_json = response.json()
resp_json[0]

names = []
code = []
country_code = []
time_zone = []

for i in range(10):
    names.append(resp_json[i]['name'])
    code.append(resp_json[i]['code'])
    country_code.append(resp_json[i]['country_code'])
    time_zone.append(resp_json[i]['time_zone'])

df = pd.DataFrame({
    "name": names,
    "code": code,
    "country_code": country_code,
    "time_zone": time_zone
})

df
