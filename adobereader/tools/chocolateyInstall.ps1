$packageName = 'adobereader'
$installerType = 'EXE'
$silentArgs = '/sAll /msi /norestart /quiet ALLUSERS=1 EULA_ACCEPT=YES'
#$url = 'http://ardownload.adobe.com/pub/adobe/reader/win/{mainversion}.x/{version}/en_US/AdbeRdr{version:replace:.:}_en_US.exe'
$url = '{{DownloadUrl}}'
#http://forums.adobe.com/thread/754256
#http://www.appdeploy.com/messageboards/tm.asp?m=37416
# '/sPB /msi /norestart ALLUSERS=1 EULA_ACCEPT=YES'
#'/sAll /rs /msi "/qb-! /norestart ALLUSERS=1 EULA_ACCEPT=YES SUPPRESS_APP_LAUNCH=YES"' 
#'/msi /norestart /quiet'

$LCID = (Get-Culture).LCID

if($LCID -eq "3082"){
$urles = $url -replace 'en_US', 'es_ES'
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$urles"  -validExitCodes $validExitCodes
}
elseif($LCID -eq "1036"){
$urles = $url -replace 'en_US', 'fr_FR'
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$urlfr"  -validExitCodes $validExitCodes
}
elseif($LCID -eq "1031"){
$urles = $url -replace 'en_US', 'de_DE'
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$urlde"  -validExitCodes $validExitCodes
}
elseif($LCID -eq "1041"){
$urles = $url -replace 'en_US', 'ja_JP'
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$urlja"  -validExitCodes $validExitCodes
}
else{
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes
}

#LCID table
#http://msdn.microsoft.com/es-es/goglobal/bb964664.aspx
