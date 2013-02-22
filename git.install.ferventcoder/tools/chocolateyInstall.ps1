try {
#Install-VirtualPackage('git')
@"

Making GIT core.autocrlf false
"@ | Write-Host

  #make GIT core.autocrlf false
  & "$env:comspec" '/c git config --global core.autocrlf false'

  Write-ChocolateySuccess 'git.install.ferventcoder'
} catch {
  Write-ChocolateyFailure 'git.install.ferventcoder' $($_.Exception.Message)
  throw
}
