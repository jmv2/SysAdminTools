
function IniciarSesion {

    $credenciales = Get-Credential
    $psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($credenciales.UserName, $credenciales.Password)

    # Conectar a Office356

    Connect-MsolService -Credential $psCred
    Connect-AzureAD -Credential $psCred

    $session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $psCred -Authentication Basic -AllowRedirection
    Import-PSSession $session    
}

function proceso {
    
    param ($path)

    $dataSet = Import-Csv -Path $path
    
    foreach($groupName in @($dataSet.ForEach("distributiongroupname") | Get-Unique)) { 
        #New-DistributionGroup -Name $groupName -DisplayName $groupName -Alias $groupName -ManagedBy $groupOwner
        
        if ($groupName -ne "dominiocaserita"){
            $member = $groupName + "@caserita.cl"
            Add-DistributionGroupMember -Identity "dominiocaserita@caserita.cl" -Member $member
        }
    }
    
}


$ruta = "C:\Users\jmiranda\OneDrive - usach.cl\Trabajo\Telefonica\Proyectos\Office 365 La Caserita\Listas-de-distribucion.csv"
proceso($ruta)