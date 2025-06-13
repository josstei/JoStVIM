# JoStVIM PowerShell Installer

$repoDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$pluggedDir = Join-Path $repoDir 'plugged'
$vimrc = Join-Path $repoDir '.vimrc'
$plugVim = Join-Path $repoDir 'autoload\plug.vim'

# 1. Download vim-plug locally if missing
if (-Not (Test-Path $plugVim)) {
    New-Item -ItemType Directory -Force -Path (Split-Path $plugVim)
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' -OutFile $plugVim
}

# 2. Create plugged directory if it doesn't exist
if (-Not (Test-Path $pluggedDir)) {
    New-Item -ItemType Directory -Force -Path $pluggedDir
}

# 3. Install plugins for Vim/Neovim if installed
foreach ($editor in @('vim', 'nvim')) {
    if (Get-Command $editor -ErrorAction SilentlyContinue) {
        & $editor -u $vimrc +PlugInstall +qall
    }
}

# 4. Write aliases to PowerShell profile
$aliasStr = @"
# JoStVIM aliases
function jostvim { vim -u `"$vimrc`" --cmd `"set runtimepath^=$repoDir,$pluggedDir`" }
function jost    { nvim -u `"$vimrc`" --cmd `"set runtimepath^=$repoDir,$pluggedDir`" }
"@

$profilePath = $PROFILE.CurrentUserAllHosts

if (-Not (Select-String -Path $profilePath -Pattern 'JoStVIM aliases' -Quiet)) {
    Add-Content -Path $profilePath -Value $aliasStr
    Write-Host "Aliases added to $profilePath. Restart your shell or run: `n` . $profilePath"
} else {
    Write-Host "Aliases already exist in $profilePath."
}

Write-Host "JoStVIM setup complete! Use 'jost' or 'jostvim' to launch with project settings."
