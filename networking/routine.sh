#!/bin/bash

currDate=$(date +%d-%m-%Y)

cd $HOME

mkdir $currDate

python networking/main.py

mv *-confg $currDate

ncftpput -u respaldos -pUsuarioFTP -R ServidorRemoto /directorio/ $currDate
