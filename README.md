# Setup

Powershell (Admin)

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser;
$url = "https://github.com/levisdev/.dotfiles/archive/main.zip";
$destination = ".dotfiles.zip";
Set-Location $HOME;
Invoke-WebRequest -Uri $url -OutFile $destination;
Expand-Archive -Path $destination -Force;
Move-Item -Path ".dotfiles\.dotfiles-main";
Remove-Item ".dotfiles";
Rename-Item -Path ".dotfiles-main" -NewName ".dotfiles";
Remove-Item ".dotfiles.zip";
Set-Location $HOME\.dotfiles;
.\install.ps1
```
