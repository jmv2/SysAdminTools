#!/usr/bin/python
# -*- coding: utf-8 -*-

import MySQLdb

username = "username"
password = "password"
server = "fqdn o ip"
dbase = "nombre de la base de datos"

def getTotalDevices():
	
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

	conn = MySQLdb.connect(user = username, passwd = password, host = server, db = dbase)
	cursor = conn.cursor()
	
	try:
			
		cursor.callproc('getCredentials', (index,))
		conn.close()
		return cursor

	except Exception as e:
		conn.close()
		return e
