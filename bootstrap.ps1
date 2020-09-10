Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install git -y
choco install git-credential-manager-for-windows -y
choco install nodejs-lts -y
choco install powershell-core -y
choco install vscode -y
choco install windirstat -y
choco install azure-cli -y
choco install docfx -y
choco install starship -y
choco install cascadiacodepl -y
choco install cascadiacode -y
choco install cascadiamonopl -y
choco install cascadiamono -y


iex "& { $(irm https://aka.ms/install-artifacts-credprovider.ps1) } -AddNetfx"

refreshenv

npm install -g diff-so-fancy
npm install -g vsts-npm-auth

Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force

if (-Not (Test-Path -LiteralPath $profile)) {
    New-Item -Type File -Path $profile -Value "# The PowerShell Profile"
}

Add-PoshGitToProfile
$file = Get-Content $profile;

if (-not ($file -like "*starship*")) {
$value = @"

Invoke-Expression (&starship init powershell)

"@
    Add-Content -Path $profile -Value $value
}


if (-not ($file -like "*dotnet complete*")) {
$value = @"

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
     param(`$commandName`, `$wordToComplete`, `$cursorPosition`)
         dotnet complete --position `$cursorPosition` "`$wordToComplete`" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new(`$_`, `$_`, 'ParameterValue', `$_`)
         }
 }
"@

 Add-Content -Path $profile -value $value
}
