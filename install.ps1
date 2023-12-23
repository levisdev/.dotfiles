#Requires -RunAsAdministrator
# icue office visualstudio nvidia zadark

$symlinks = @{
	"$HOME\.gitconfig" = ".gitconfig"                            
	"$HOME\AppData\Local\nvim" = ".config\nvim"                          
	"$HOME\.config\starship.toml" = ".config\starship.toml"                 
	"$HOME\.config\powershell" = ".config\powershell"                    
	"$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" = ".config\windows-terminal\settings.json"
}

$wingetDeps = @(
	"Microsoft.Edge"
	"MSYS2.MSYS2"
	"Microsoft.PowerShell"
	"Microsoft.WindowsTerminal"
    "Microsoft.VCRedist.2015+.x64"
    "Microsoft.VCRedist.2015+.x86"
	"Microsoft.VisualStudioCode"
	"File-New-Project.EarTrumpet"
	"Discord.Discord"
	"RARLab.WinRAR"
	"VNGCorp.Zalo"
)

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
	Write-Host "Installing scoop..."
    Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
}

Write-Host "Setting up scoop..."
scoop import ./.config/scoop.json
scoop update -a

if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing chocolatey..."
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://community.chocolatey.org/install.ps1"))
}

Write-Host "Installing missing winget packages..."
$installedWingetDeps = winget list | Out-String
foreach ($wingetDep in $wingetDeps) {
    if ($installedWingetDeps -notmatch $wingetDep) {
        winget install --id $wingetDep -e --accept-source-agreements --accept-package-agreements
    }
}

Write-Host "Creating pwsh profile..."
Start-Process -Wait -WindowStyle Hidden -Verb RunAs pwsh -ArgumentList "-Command New-Item -Path $PROFILE -Type File -Force"
Start-Process -Wait -WindowStyle Hidden -Verb RunAs pwsh -ArgumentList "-Command '. $HOME\.config\powershell\profile.ps1' > $PROFILE"

Write-Host "Creating Symbolic Links..."
foreach ($symlink in $symlinks.GetEnumerator()) {
    Get-Item -Path $symlink.Key -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    New-Item -ItemType SymbolicLink -Path $symlink.Key -Target (Resolve-Path $symlink.Value) -Force | Out-Null
}
