<#
    1.- Definir los servidores que se respaldaran.

    2.- Crear los recursos compartidos en esos servidores (Crear log de esta acción).
        2.1.- Crear directorio con la nomeclatura: nombreServidor-fecha

    3.- Copiar desde los recursos a este equipo todo lo que tienen ahí(Crear log de esta acción).

    4.- Comprimir los respaldos(Crear log de esta acción).

    5.- Eliminar los archivos de respaldos con fecha superior a 7 días(Crear log de esta acción).

    6.- Enviar correo con log.

    Lista de servidores= andinacls,srv003,wonderwoman,sql01peulla,wason,srv001,phantom
#>

function createLog {

    param([string]$OutPutCmd)
    $OutPutCmd
    $date = get-date
    [string]$logString = $date.ToLongTimeString() + " : "+ $OutPutCmd
    $logString | Out-File D:\DB\LogBKP\$($date.ToShortDateString()).txt -Append
}

function sendMailLog {
    $currentDate = Get-Date


    $from = "BackUp Server <bkp-server@asinco.cl>"
    $to = "juan.miranda.cardenas@gmail.com"
    $subject = “Resumen proceso de respaldos. Fecha: $currentDate”
    $body = "Se adjunta archivo con logs."
    $attachment = "D:\DB\LogBKP\" + $currentDate.ToShortDateString() + ".txt"
    $SMTPserver = "smtp-relay.gmail.com"

    Send-MailMessage –From $from –To $to –Subject $subject -Body $body -Attachments $attachment -SmtpServer $SMTPserver

}


#$SX = @{"hostname"="";"directory"=""}
$S1 = @{"hostname"="andinacls";"directory"="Cluster"}
$S2 = @{"hostname"="srv003";"directory"="Desarrollo"} #Servidor que ocupa SS y JC para desarrollo Situr y Sigav
$S3 = @{"hostname"="SRV001";"directory"="SRV001"}
$S4 = @{"hostname"="sql01peulla";"directory"="Peulla"}
$S5 = @{"hostname"="wonderwoman";"directory"="WonderWoman"}
$S6 = @{"hostname"="phantom";"directory"="Historico"}

$serverList = $S1,$S2,$S3#,$S4,$S5,$S6

$currentDate = Get-Date
$newCurrentDate = $currentDate.ToShortDateString()


foreach($server in $serverList)
{

    #cambio de carpeta al principal donde estan todos los respaldos realizados anteriormente, luego crear nueva carpeta.
    Set-Location -Path D:\DB\$($server.directory)\
    New-Item -ItemType Directory -Path D:\DB\$($server.directory)\$($newCurrentDate)\
    Set-Location -Path $(Join-Path -Path $(get-location) $newCurrentDate)

    $remoteDirectory = "\\" + $server.hostname + ".andinadelsud.com\DB-Backup\"
    $fileList = Get-ChildItem -Path $remoteDirectory -Filter *.bak
    createLog("SERVIDOR: "+ $server.hostname)


    foreach($file in $fileList){

        if ($file.CreationTime -gt $currentDate.AddDays(-1)) {

            try {
                Copy-Item -Path $file.FullName
                createLog $("COPY FILE " + $file.Name + " TO DIRECTORY " + $(Get-Location))

                Compress-7Zip -ArchiveFileName $($file.Name + ".7z") $file.Name -CompressionMethod Lzma2 -SkipEmptyDirectories
                createLog $("FILE " + $file.Name + " HAS BEEN COMPRESSED")

                Remove-Item -Force $file.Name
                createLog $("FILE " + $file.Name + " HAS BEEN REMOVED")
            }catch{

                $ErrorMessage = $_.Exception.Message
                createLog($ErrorMessage)
            }

        }
    }
}

#Con esto termino.
sendMailLog
