#!/usr/bin/python
# -*- coding: utf-8 -*-

import socket
from pexpect import pxssh
# Para enviar un retorno de linea (o enter) el parametro de sendline debe ir vacio
maxTime = 1
maxTimeLogin = 3

def backUpRunningConfig(ip, username, password, description):
	
	srv_scp = socket.gethostbyname('daredevil.asinco.cl') #"10.1.timetime.time0time"
	usr_scp = "backup"
	pwd_scp = "97f4c79f5ee30a1ce1ad2ea27ee6c432"

	print("Working on... %s" % (description))
	 
	s = pxssh.pxssh()
	s.UNIQUE_PROMPT=".*"
	
	try:
		
		s.login(ip, username, password, auto_prompt_reset=False)
		 
		s.sendline('copy running-config scp:')		#adadad
		s.prompt(timeout=maxTime)     			#Address or name of remote host []?
		s.sendline(srv_scp)     			#Send IP SCP Server
		s.prompt(timeout=maxTime)    			#Destination username [admin]?
		s.sendline(usr_scp)     			#Send username SCP Server
		s.prompt(timeout= maxTime)     			#Destination filename [core_p5_golf_331680-331681-confg]?
		s.sendline()            			#Send return
		s.prompt(timeout=maxTime)     			#Writing core_p5_golf_331680-331681-confg
		s.prompt(timeout=maxTime)     			#Password:
		s.sendline(pwd_scp)     			#Enviar clave servidor SCP
		s.prompt(timeout=maxTime)     			#Expect lo que sea
		 
		#print(s.before)
		 
		s.logout()

	except Exception as e:
		print(e)


def changeTimeZone(self):
	
	srv_scp = socket.gethostbyname('daredevil.asinco.cl') #"10.1.timetime.time0time"
	usr_scp = "backup"
	pwd_scp = "97f4c79f5ee30a1ce1ad2ea27ee6c432"

	print("Working on... %s" % (description))
	 
	s = pxssh.pxssh()
	s.UNIQUE_PROMPT=".*"
	
	try:
		
		s.login(ip, username, password, auto_prompt_reset=False)
		 
		s.sendline('copy running-config scp:')
		s.prompt(timeout=maxTime)     			#Address or name of remote host []?
		s.sendline(srv_scp)     			#Send IP SCP Server
		s.prompt(timeout=maxTime)    			#Destination username [admin]?
		s.sendline(usr_scp)     			#Send username SCP Server
		s.prompt(timeout= maxTime)     			#Destination filename [core_p5_golf_331680-331681-confg]?
		s.sendline()            			#Send return
		s.prompt(timeout=maxTime)     			#Writing core_p5_golf_331680-331681-confg
		s.prompt(timeout=maxTime)     			#Password:
		s.sendline(pwd_scp)     			#Enviar clave servidor SCP
		s.prompt(timeout=maxTime)     			#Expect lo que sea
		 
		print s.before
		 
		s.logout()

	except Exception as e:
		print(e)
