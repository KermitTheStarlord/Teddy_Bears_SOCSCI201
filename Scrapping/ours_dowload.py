
from datetime import date
import urllib.request
from bs4 import BeautifulSoup as bs
import requests
import pandas as pd
import re
import os

dir = r"C:\Users\juanf\OneDrive\Documents\_01_ParisSE\_10_Cultural_Evolution\Assignment 2\data"
img = dir + r"\image"

ours = bs(requests.get("http://collections.lesartsdecoratifs.fr/jouets?items_per_page=60&f[0]=f_filtrerpartypedobjet%3A%24%24%24ANIMAL%20-JOUET%24%24%24Animal%20type%20peluche").content, 'html.parser', from_encoding='utf-8')
links = ours.find_all("a")
hrefs = [link.get("href") for link in links]
fhrefs = [href for href in hrefs if href and href.startswith("http://collections.lesartsdecoratifs.fr/")]

for num in range(1, 9):
    url = r"http://collections.lesartsdecoratifs.fr/jouets?page=" + str(num) + r"&items_per_page=60&f[0]=f_filtrerpartypedobjet%3A%24%24%24ANIMAL%20-JOUET%24%24%24Animal%20type%20peluche"
    ours = bs(requests.get(url).content, 'html.parser', from_encoding='utf-8')
    links = ours.find_all("a")
    hrefs = [link.get("href") for link in links]
    fhrefs_p = [href for href in hrefs if href and href.startswith("http://collections.lesartsdecoratifs.fr/")]
    fhrefs.extend(fhrefs_p)

pattern = re.compile(r".*(print|printmail|printpdf).*")
fhrefs = [url for url in fhrefs if not pattern.match(url)]

data = pd.DataFrame()
for source in fhrefs:
    toget = bs(requests.get(source).content, 'html.parser', from_encoding='utf-8')
    field_labels = toget.select('div.field-label')
    field_labels = [label.text.strip().replace(':', '') for label in field_labels]
    field_items = toget.select('div.field-item')

    urls = []
    for item in field_items:
        if 'http://collections.lesartsdecoratifs.fr' in str(item):
            if item.find('a') is not None:
                urls.append(item.find('a')['href'])
            elif item.find('img') is not None:
                urls.append(item.find('img')['src'])
    field_items = [item for item in field_items if 'http://collections.lesartsdecoratifs.fr' not in str(item)]
    field_items = [item.text.strip().replace(':', '') for item in field_items]

    data_dict = {}
    for label, item in zip(field_labels, field_items):
        if label not in data_dict:
            data_dict[label] = []
        data_dict[label].append(item)
    df = pd.DataFrame(data_dict)

    name = df.loc[0, "Numéro d'inventaire"].replace(".", "_")
    for idx, url in enumerate(urls):
        response = requests.get(url)
        with open(img + '/' + str(name) + f'_n{idx}.jpg', 'wb') as f:
            f.write(response.content)

    data = pd.concat([data, df])

data.to_csv(os.path.join(dir, 'output.csv'), index=False, encoding='utf-8')
data.to_stata(os.path.join(dir, 'ours.dta'), version=118)
