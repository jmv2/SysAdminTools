#!/bin/bash

p_name=$(echo $1)

if [ -z "$p_name" ] # Comprueba si la variable es Null
then
	echo "Sin nombre"
else
	#Directorio padre
	mkdir $p_name
	cd $p_name
	touch index.html
	mkdir styles
	mkdir -p audio/{mp3,wav}
	mkdir video
	mkdir script

fi
