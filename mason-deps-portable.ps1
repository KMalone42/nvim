# mason-deps-portable.ps1 — Portable deps for Neovim/Mason on Windows (no admin)
# Installs to: $HOME\tools\{node,python,bin}
# Adds to user PATH:   $HOME\tools\node;$HOME\tools\python;$HOME\tools\python\Scripts;$HOME\tools\bin

$ErrorActionPreference = "Stop"

function Ensure-Dir($p) { if (-not (Test-Path $p)) { New-Item -ItemType Directory -Path $p | Out-Null } }
function Download($url, $dst) {
  Write-Host "  ↳ $([System.IO.Path]::GetFileName($dst))"
  Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $dst
}
function Expand-Zip($zip, $dest) {
  Ensure-Dir $dest
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  [System.IO.Compression.ZipFile]::ExtractToDirectory($zip, $dest, $true)
}

# Append to *user* PATH if missing
function Add-ToUserPath($pathFragment) {
  $current = [Environment]::GetEnvironmentVariable("Path", "User")
  if ($current -notlike "*$pathFragment*") {
    [Environment]::SetEnvironmentVariable("Path", "$current;$pathFragment", "User")
    Write-Host "  ↳ Added to PATH (User): $pathFragment"
  }
}

$HOME   = [Environment]::GetFolderPath("UserProfile")
$TOOLS  = Join-Path $HOME "tools"
$BIN    = Join-Path $TOOLS "bin"
$TMP    = Join-Path $TOOLS "tmp"
Ensure-Dir $TOOLS; Ensure-Dir $BIN; Ensure-Dir $TMP

Write-Host "[*] Installing portable Node.js (with npm)..."
# Grab latest LTS ZIP dynamically
$nodeIndex = Invoke-RestMethod "https://nodejs.org/dist/index.json"
$lts = $nodeIndex | Where-Object { $_.lts -and $_.files -contains "win-x64" } | Select-Object -First 1
$nodeVersion = $lts.version  # e.g. v22.x.x (LTS)
$nodeZipUrl = "https://nodejs.org/dist/$nodeVersion/node-$($nodeVersion)-win-x64.zip"
$nodeZip = Join-Path $TMP "node-win-x64.zip"
Download $nodeZipUrl $nodeZip

$NODE_DIR = Join-Path $TOOLS "node"
if (Test-Path $NODE_DIR) { Remove-Item -Recurse -Force $NODE_DIR }
Expand-Zip $nodeZip $NODE_DIR
# ZIP extracts into a subfolder; flatten to ...\node
$extracted = Get-ChildItem $NODE_DIR | Where-Object { $_.PSIsContainer } | Select-Object -First 1
if ($extracted) {
  Get-ChildItem $extracted.FullName -Force | Move-Item -Destination $NODE_DIR -Force
  Remove-Item $extracted.FullName -Recurse -Force
}
Add-ToUserPath $NODE_DIR

Write-Host "[*] Installing portable Python (embeddable) + pip..."
# Choose an embeddable build (3.12 is fine for tools). We’ll enable site and bootstrap pip.
$pyVer = "3.12.7"
$pyZipUrl = "https://www.python.org/ftp/python/$pyVer/python-$pyVer-embed-amd64.zip"
$pyZip = Join-Path $TMP "python-embed.zip"
Download $pyZipUrl $pyZip

$PY_DIR = Join-Path $TOOLS "python"
if (Test-Path $PY_DIR) { Remove-Item -Recurse -Force $PY_DIR }
Expand-Zip $pyZip $PY_DIR

# Enable site-packages in embeddable distro by uncommenting 'import site' in python312._pth
$pth = Get-ChildItem $PY_DIR -Filter "python*.pth" | Select-Object -First 1
if ($pth) {
  (Get-Content $pth.FullName) |
    ForEach-Object { $_ -replace '^\s*#\s*import site','import site' } |
    Set-Content $pth.FullName -Encoding ASCII
}

# Provide python3.exe shim (some tools call python3)
$pyExe = Join-Path $PY_DIR "python.exe"
$py3Exe = Join-Path $PY_DIR "python3.exe"
if (-not (Test-Path $py3Exe)) { Copy-Item $pyExe $py3Exe }

# Bootstrap pip
$getPip = Join-Path $TMP "get-pip.py"
Download "https://bootstrap.pypa.io/get-pip.py" $getPip
& $pyExe $getPip --no-warn-script-location
Add-ToUserPath $PY_DIR
Add-ToUserPath (Join-Path $PY_DIR "Scripts")

Write-Host "[*] Installing portable ripgrep..."
$rip = Invoke-RestMethod "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest"
$ripAsset = $rip.assets | Where-Object { $_.name -match "x86_64-pc-windows-msvc.zip$" } | Select-Object -First 1
$ripZip = Join-Path $TMP $ripAsset.name
Download $ripAsset.browser_download_url $ripZip
# Extract just rg.exe
$ripDest = Join-Path $BIN "rg.exe"
if (Test-Path $ripDest) { Remove-Item $ripDest -Force }
Expand-Zip $ripZip (Join-Path $TMP "ripgrep")
Copy-Item (Get-ChildItem -Recurse (Join-Path $TMP "ripgrep") -Filter "rg.exe" | Select-Object -First 1).FullName $ripDest -Force
Remove-Item (Join-Path $TMP "ripgrep") -Recurse -Force
Add-ToUserPath $BIN

Write-Host "[*] Installing portable fd..."
$fd = Invoke-RestMethod "https://api.github.com/repos/sharkdp/fd/releases/latest"
$fdAsset = $fd.assets | Where-Object { $_.name -match "x86_64-pc-windows-msvc.zip$" } | Select-Object -First 1
$fdZip = Join-Path $TMP $fdAsset.name
Download $fdAsset.browser_download_url $fdZip
Expand-Zip $fdZip (Join-Path $TMP "fd")
Copy-Item (Get-ChildItem -Recurse (Join-Path $TMP "fd") -Filter "fd.exe" | Select-Object -First 1).FullName (Join-Path $BIN "fd.exe") -Force
Remove-Item (Join-Path $TMP "fd") -Recurse -Force

Write-Host "`n[✔] Portable toolchain installed."
Write-Host "    Node:    $NODE_DIR"
Write-Host "    Python:  $PY_DIR"
Write-Host "    Bin:     $BIN"
Write-Host "    Added to PATH (User). Open a NEW terminal to pick it up."
Write-Host "`nNext:"
Write-Host "  • In a new terminal: node -v; npm -v; python --version; pip --version; rg --version; fd --version"
Write-Host "  • Then in Neovim: :MasonInstall ruff basedpyright bash-language-server ansible-language-server css-lsp awk-language-server perlnavigator ast-grep systemd-language-server"

