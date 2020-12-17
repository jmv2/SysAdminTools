#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
pip install requests
pip install bs4
pip install lxml

"""

import requests
from bs4 import BeautifulSoup
import ctypes
from datetime import time
from datetime import datetime
import time


def main():

    while True:
        listEstacionesCerradas = []
        url = "https://metro.cl/tu-viaje/estado-red"
        r = requests.get(url)
        soup = BeautifulSoup(r.text, "lxml")
        #Cuando una estación de la red del metro está cerrada, el estado es : "estado3"
        estacionesCerradas = soup.find_all("li", attrs={"class": "estado3"})
        
        

        print ("********************************************")
        print (datetime.now().strftime("%H:%M:%S"))
        print ("********************************************")
        print ("\n")

        for estacionCerrada in estacionesCerradas:

            cerrada_str = str(estacionCerrada.contents)
            cerrada_str = cerrada_str.replace("\\n", "")
            cerrada_str = cerrada_str.replace("\\t", "")
            cerrada_str = cerrada_str.replace("[", "")
            cerrada_str = cerrada_str.replace("]", "")
            cerrada_str = cerrada_str.replace("\'", "")

            listEstacionesCerradas.append(cerrada_str)

        if "Santa Isabel" in listEstacionesCerradas:
            ctypes.windll.user32.MessageBoxW(0, "Santa Isabel está cerrada", "Estado", 1)
        elif "Santa Ana L5" in listEstacionesCerradas:
            ctypes.windll.user32.MessageBoxW(0, "Santa Ana L5 está cerrada", "Estado", 1)
        
        
        time.sleep(60)

if __name__ == "__main__":
    main()
