﻿$addCertificate = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\addCertificate.ps1"
Start-ChocolateyProcessAsAdmin "& `'$addCertificate`'"
Install-ChocolateyPackage 'VirtualCloneDrive' 'exe' '/S /noreboot' '{{DownloadUrl}}'