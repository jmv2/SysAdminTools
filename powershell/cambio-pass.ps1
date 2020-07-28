
function IniciarSesion {

    $credenciales = Get-Credential
    $psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($credenciales.UserName, $credenciales.Password)

    # Conectar a Office356

    Connect-MsolService -Credential $psCred
    Connect-AzureAD -Credential $psCred

    $session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $psCred -Authentication Basic -AllowRedirection
    Import-PSSession $session    
}





Get-MsolDomain -ErrorAction SilentlyContinue

if ($?){
    $listaDeUsuarios = Get-MsolUser -All

    foreach($usuario in $listaDeUsuarios){
        if(!$usuario.UserPrincipalName.Contains("migracion")){

            Set-MsolUserPassword -UserPrincipalName $usuario.UserPrincipalName -NewPassword "Agricola2020" -ForceChangePassword $false
            Set-MsolUser -UserPrincipalName $usuario.UserPrincipalName -PasswordNeverExpires $true

        }
    }

}else{
    IniciarSesion
}