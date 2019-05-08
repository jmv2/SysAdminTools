Import-Module ActiveDirectory

#Equipos que no se deben eliminar (por el momento) del AD-DC
$excludeHost = "HOSTNAME1", "HOSTNAME2","ETC"

#AD-DC no entiende el formato de fechas que se usa normalmente (YYYY-MM-DD o similar), sino que el UNIX Timestamp.
# Se debe convertir el output de Get-Date a formato UNIX.

$days = 60 #Dias de antigüedad de los equipos sin conectarse a AD-DC
$pwdLast = get-date 
$pwdLast = $pwdLast.AddDays(-$days).ToFileTime() # Se antepone el signo menos (-) a los dias para que reste los dias a la fecha actual.

#Filtro LDAP dentro de los objetos tipo "computer" busca aquellos donde su última actualización de contraeña sea menor igual a 60 dias.
$hostCollection = Get-ADComputer -LDAPFilter "(objectcategory=computer)(pwdLastSet<=$pwdLast)" 



write-host "Se han encontrado" ($hostCollection.Count + 1) "hosts con mas de" $days " dias sin registraste al AD-DC"

foreach ($computer in $hostCollection){
               
    foreach($item in $excludeHost){
    
        if($computer.Name -eq $item){
           Write-Host "El host" $excludeHost "no se debe eliminar."
        }else{
        
            write-host "Eliminando el host: " $computer.Name
            Remove-ADComputer -Identity $computer.Name -confirm:$false
        }
    }
}
