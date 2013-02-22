try {
  Install-ChocolateyPackage 'git.install' 'exe' '/VERYSILENT' '{{DownloadUrl}}'

  #------- ADDITIONAL SETUP -------#
  $is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
  $programFiles = $env:programfiles
  if ($is64bit) {$programFiles = ${env:ProgramFiles(x86)}}
  $gitPath = Join-Path $programFiles 'Git\cmd'

  Install-ChocolateyPath $gitPath 'user'

  Write-ChocolateySuccess 'git.install'
} catch {
  Write-ChocolateyFailure 'git.install' $($_.Exception.Message)
  throw
}
