try {
  $silentArgs = '/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /NOICONS /COMPONENTS="assoc,assoc_sh" /LOG'

  $key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1'
  #adjust for 64-bit Windows (explicitly read from 32-bit reg)
  if (-not (Test-Path $key)) { $key = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Git_is1' }
  if (Test-Path $key) {
    $path = (Get-ItemProperty -Path $key -Name 'InstallLocation').InstallLocation
    $silentArgs += ' /DIR=' + "`"$path`""
  }
  
  Install-ChocolateyPackage 'git.install' 'exe' $silentArgs '{{DownloadUrl}}'

  #------- ADDITIONAL SETUP -------#
  $is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
  $programFiles = $env:programfiles
  if ($is64bit) {$programFiles = ${env:ProgramFiles(x86)}}
  $gitPath = Join-Path $programFiles 'Git\cmd'

  Install-ChocolateyPath $gitPath 'Machine'

#@"
#
#Making GIT core.autocrlf false
#"@ | Write-Host
#
#  #make GIT core.autocrlf false
#  & "$env:comspec" '/c git config --global core.autocrlf false'

  Write-ChocolateySuccess 'git.install'
} catch {
  Write-ChocolateyFailure 'git.install' $($_.Exception.Message)
  throw
}
