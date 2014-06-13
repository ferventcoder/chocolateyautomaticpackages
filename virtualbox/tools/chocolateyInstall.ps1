$id = 'virtualbox'
$url = '{{DownloadUrl}}'
$kind = 'exe'
$silent = '-s -l -msiparams REBOOT=ReallySuppress'

$tools = Split-Path $MyInvocation.MyCommand.Definition
$cert = Join-Path $tools 'oracle.cer'
$bin = Join-Path $ENV:PROGRAMFILES 'Oracle\VirtualBox'

Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$cert'"

Install-ChocolateyPackage $id $kind $silent $url
Install-ChocolateyPath $bin
