try {

    $packageName = 'paint.net'
    $fileType = 'exe'
    $silentArgs = '/auto DESKTOPSHORTCUT=0'
    $pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"
    
	Import-Module "$($pwd)\Get-FilenameFromRegex.ps1"
	# Why does an import failure on this module not throw an error?

	$url1 = Get-FilenameFromRegex "http://www.filehippo.com/download_paint.net/history/" 'download_paint.net/([\d]+)/">Paint.NET 3.5.10<' 'http://www.filehippo.com/download_paint.net/$1/'
	
    Write-Host "Found URL which contains the download URL 1: $url1"

    $url2 = Get-FilenameFromRegex "$url1" 'download_paint.net/download/([\w\d]+)/' 'http://www.filehippo.com/en/download_paint.net/download/$1/'
    Write-Host "Found URL which contains the download URL 2: $url2"

	$url3 = Get-FilenameFromRegex "$url2" '/download/file/([\w\d]+)/' 'http://www.filehippo.com/download/file/$1/'
	Write-Host "Found download URL: $url3"

	Install-ChocolateyPackage $packageName $fileType $silentArgs $url3

    Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}