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

##Spanish
if(($LCID -eq "3082") -or ($LCID -eq "1034")){
$url = $url -replace 'en_US', 'es_ES'
}

##French
elseif($LCID -eq "1036"){
$url = $url -replace 'en_US', 'fr_FR'
}

##German
elseif($LCID -eq "1031"){
$url = $url -replace 'en_US', 'de_DE'
}

##Japanese
elseif($LCID -eq "1041"){
$url = $url -replace 'en_US', 'ja_JP'
}

##English
else{
$url = $url
}

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes

#LCID table
#http://msdn.microsoft.com/es-es/goglobal/bb964664.aspx
