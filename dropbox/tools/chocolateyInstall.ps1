$packageName = "dropbox"
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\$packageName`Install.exe"
$url = "https://www.dropbox.com/download?plat=win"
$fileType = "exe"
$silentArgs = "/S"

try {

    if (-not (Test-Path $filePath)) {
    New-Item $filePath -type directory
    }

	Get-ChocolateyWebFile $packageName $fileFullPath $url
    Start-Process $fileFullPath -ArgumentList $silentArgs
	Wait-Process -Name "dropboxInstall"
    Remove-Item $fileFullPath
	
    Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw 
}