#!/usr/bin/python
# -*- coding: utf-8 -*-

import MySQLdb

username = "soporte"
password = "s0p0rt3a51nk0"
server = "daredevil.asinco.cl"
dbase = "networking"

def getTotalDevices():
	
	"""		
			Esta función llama a un procedimiento de alamacenado el cuál consulta a la tabla de 
			credenciales el total de registros, retorna una tupla donde el elemto 0 contiene el dato.
	"""
	
	conn = MySQLdb.connect(user = username, passwd = password, host = server, db = dbase)
	cursor = conn.cursor()

	try:
		
		cursor.callproc('getTotalDevices')
		conn.close()
		return cursor.fetchone()
	
	except Exception as e:
		
		conn.close()
		return e


def getCredentials(index):

	"""
		Este función llama a un procedimiento de almacenado el cuál consulta fila por fila las credenciales.
		Retona un tupla con los datos
	"""
	
	conn = MySQLdb.connect(user = username, passwd = password, host = server, db = dbase)
	cursor = conn.cursor()
	
	try:
			
		cursor.callproc('getCredentials', (index,))
		conn.close()
		return cursor

	except Exception as e:
		conn.close()
		return e
