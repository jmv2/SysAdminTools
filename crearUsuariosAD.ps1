Import-Module ActiveDirectory

$listUsuarios = Import-Csv -Path C:\Users\Administrator\Desktop\usuario_final3.csv #cambia esto
$domainName = "otc.local" #cambia esto
$ou = "OU=patagonia,DC=otc,DC=local" # cambia esto tambien

foreach($usuario in $listUsuarios){

    try {

        $nombreCompleto = $usuario.Nombre + " " + $usuario.Apellido
        $upn = $usuario.CUENTA + "@" + $domainName
 
    
        New-ADUser -Name $nombreCompleto -GivenName $usuario.Nombre -Surname $usuario.Apellido -DisplayName $nombreCompleto -SamAccountName $usuario.CUENTA -UserPrincipalName $upn  -AccountPassword $("Passw0rd" |  ConvertTo-SecureString -AsPlainText -Force) -Enabled $true -Path $ou

    }catch{
        
        $ErrorMessage = $_.Exception.Message
        Write-Host $ErrorMessage
        "Cuenta fallida: " + $usuario.CUENTA # La cuenta que aparezca en este output la deberas crear a mano, son las menos.
    }
    

}
