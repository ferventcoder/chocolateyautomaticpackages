﻿$packageName = "dropbox"
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\$packageName`Install.exe"
$url = 'https://dl-web.dropbox.com/u/17/Dropbox {{PackageVersion}}.exe'
$fileType = "exe"
$silentArgs = "/S"

# Variables for the AutoHotkey-script
$scriptPath="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile = "`"$scriptPath\dropbox.ahk`""
$exeToRun = "$env:ProgramFiles\AutoHotkey\AutoHotkey.exe"
 
try { 
	if (-not (Test-Path $filePath)) {
		New-Item $filePath -type directory
	}
	Get-ChocolateyWebFile $packageName $fileFullPath $url
    Start-Process $exeToRun -Verb runas -ArgumentList $ahkFile
	Start-Process $fileFullPath -ArgumentList $silentArgs
	Wait-Process -Name "dropboxInstall"
	Remove-Item $fileFullPath

	Write-ChocolateySuccess $packageName
} catch {
	Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
	throw
 }