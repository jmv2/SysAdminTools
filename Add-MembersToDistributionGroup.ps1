<#
    Modo de uso:

    Add-MembersToDistributionGroup "usuario con privilegios de administrador" "contraseña" "Ruta absoluta del archivo"

    Ejemplo:

    Add-MembersToDistributionGroup usuario@dominio.onmicrosoft.com "$uperAm1n.(" C:\Grupos.csv

    Observación 1: Si la contraseña contiene caracteres que pueden causar conflicto con el script, como puede ser el parentesis, se debe escribir entre comillas dibles.

    Observación 2: Las cabeceras del archivo donde están las cuentas y los grupos deben ser:
        * distributiongroupname
        * emailaddress

    No importa el orden de las cabeceras, pero deben si y solo si existir.

#>

$username = $args[0]
$password = ConvertTo-SecureString $args[1] -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)

# Conectar a Office356
Connect-MsolService -Credential $psCred
Connect-AzureAD -Credential $psCred


## Conectar a Exchange Online

$session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $psCred -Authentication Basic -AllowRedirection
Import-PSSession $session

$file = Import-Csv -Path $args[2]


foreach($account in $file){

    try{
        Add-UnifiedGroupLinks -Identity $account.distributiongroupname -LinkType Members –Links $account.emailaddress
    }
    catch{
            $ErrorMessage = $_.Exception.Message
            Write-Host $ErrorMessage
    }
}

#Resumen
$AllGroupsList = Get-UnifiedGroup

foreach($distribGroup in $AllGroupsList){
    
    Get-UnifiedGroupLinks -Identity $distribGroup -LinkType Members    
}