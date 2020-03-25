#!/usr/bin/python
# -*- coding: utf-8 -*-

from conn_DB import getCredentials, getTotalDevices
from remoteCommands import backUpRunningConfig


#Función principal.
#Se encarga de ejecutar los SP de la base de datos, la cual retorna un int con la cantidad de registros que tiene la tabla de las credenciales.


def main():

	total = getTotalDevices() #Retona una tupla. Se debe usar el primer elemento para el contador.
	
	print("Total Dev: %d" % (total))

	counter = 1
	
	while counter <= total[0]:

		for row in getCredentials(counter):
			backUpRunningConfig(row[3], row[1], row[2], row[4])

		counter = counter + 1


if __name__ == '__main__':
	main()
