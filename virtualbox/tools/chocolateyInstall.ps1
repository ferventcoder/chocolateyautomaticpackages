$packageName = 'virtualbox'
$tools="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$tools\oracle.cer'"
Install-ChocolateyPackage $packageName 'exe' '-s' '{{DownloadUrl}}'

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
$programFiles = $env:programfiles
if ($is64bit) {$programFiles = ${env:ProgramFiles(x86)}}
$fsObject = New-Object -ComObject Scripting.FileSystemObject
$programFiles = $fsObject.GetFolder("$programFiles").ShortPath

Install-ChocolateyPath $(join-path $programFiles 'Oracle\VirtualBox')
