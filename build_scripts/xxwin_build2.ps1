param (
    [Parameter(Mandatory=$true)][string]$version
)
$env:CHIA_INSTALLER_VERSION = $version

Set-Location -Path ".\chia-blockchain-gui" -PassThru

Write-Output "   ---"
Write-Output "Prepare Electron packager"
Write-Output "   ---"
#npm install --save-dev electron-winstaller
#npm install -g electron-packager
#npm install
#npm audit fix

Write-Output "   ---"
Write-Output "Electron package Windows Installer"
Write-Output "   ---"
npm run build
If ($LastExitCode -gt 0){
    Throw "npm run build failed!"
}

Write-Output "   ---"
Write-Output "Increase the stack for gold command for (gold plots create) chiapos limitations"
# editbin.exe needs to be in the path
$env:Path += ";C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.29.30037\bin\Hostx64\x64" 
editbin.exe /STACK:8000000 daemon\gold.exe
Write-Output "   ---"

$appName = "Gold"
$packageVersion = $version
$packageName = "$appName-$packageVersion"

Write-Output "packageName is $packageName"

Write-Output "   ---"
Write-Output "electron-packager"
electron-packager . $appName --asar.unpack="**\daemon\**" --overwrite --icon=.\src\assets\img\chia.ico --app-version=$packageVersion
Write-Output "   ---"

Write-Output "   ---"
Write-Output "node winstaller.js"
C:\"Program Files"\nodejs\node.exe winstaller.js



#Write-Output "   ---"
#Write-Output "Add timestamp and verify signature"
#Write-Output "   ---"
#signtool.exe timestamp /v /t http://timestamp.comodoca.com/ .\release-builds\windows-installer\$appNameSetup-$packageVersion.exe
#signtool.exe verify /v /pa .\release-builds\windows-installer\$appNameSetup-$packageVersion.exe
 

git status

Write-Output "   ---"
Write-Output "Windows Installer complete"
Write-Output "   ---"
Set-Location -Path "..\" -PassThru