#!/bin/bash

#Aca declaras el nombre del archivo que contiene los mapeos nombre original y nuevo nombre
mapping="/home/lab/arch.txt" #Ruta absoluta del archivo separado por comas.
workingDirectory="/home/lab/" #Ruta en donde está toda la estructura de directorios que debe ser comprimido.

#El While que viene abajo, se encarga de leer el archivo línea a línea (como mi compadre chino, una aspiradora de líneas jajaja)
#Este while termina cuando termina de leer la última línea

while read line; do
        #Te fijas que justo acá arriba está escrito "line", esa es una variable, se podria llamar como sea.
        #El problema que esta variable no es "separable" como para hacer el mapeo nombre origen - nombre destino.
        #Tonces, cree dos variables mas chicas y dividí la más grande, fácil.

        src="$(echo $line | cut -d ',' -f1)"
        dst="$(echo $line | cut -d ',' -f2)"

        #Acá busco los archivos con el nombre original y los renombro con el comando "mv".
        find $workingDirectory -type d -name $src -exec mv {} $dst \;

        #Para terminar la cosa, uso nuevamente find pero esta vez para comprimir. La diferencia con el find anterior es que este find,
        #no buscará en más directorios para eso la opción "-maxdepth"

        find $workingDirectory -maxdepth 1 -type d -name $src -exec zip -rm $dst.zip {} \;

done < $mapping
