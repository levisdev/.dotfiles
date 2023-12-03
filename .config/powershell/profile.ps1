# PSReadLine
Import-Module -Name PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key Ctrl-j -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl-k -Function HistorySearchForward

# Icons
Import-Module -Name Terminal-Icons

# Alias
Set-Alias vi nvim

# Starship
if (Get-Command starship -errorAction SilentlyContinue) {
    $ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
    Invoke-Expression (&starship init powershell)
}

# Jump to current dir when split pane in windows terminal
function Invoke-Starship-PreCommand {
    $loc = $executionContext.SessionState.Path.CurrentLocation;
    $prompt = "$([char]27)]9;12$([char]7)"
    if ($loc.Provider.Name -eq "FileSystem") {
        $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
    }
    $host.ui.Write($prompt)
}

# fzf catppuccin theme
$ENV:FZF_DEFAULT_OPTS = @"
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
"@

# Scoop
function scoop { 
    if ($args[0] -eq "search") { 
        scoop-search.exe @($args | Select-Object -Skip 1) 
    } 
    else { 
        scoop.ps1 @args 
    }
    scoop.ps1 export > $HOME\.dotfiles\.config\scoop.json
}
