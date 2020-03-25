#!/bin/bash

currDate=$(date +%d-%m-%Y) #Formato Dia-Mes-Año

cd $HOME

mkdir $currDate

python networking/main.py

mv *-confg $currDate

ncftpput -u respaldos -pa51nk0 -R veeamserver.andinadelsud.com /Networking/ $currDate
