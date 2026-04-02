# Power User - Windows Setup Script
#
# RECOMMENDED (avoids antivirus false positives):
#   1. Download:  irm https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.ps1 -OutFile setup.ps1
#   2. Run:       powershell -ExecutionPolicy Bypass -File setup.ps1
#
# OR if already cloned: powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
#
# NOTE: Norton, McAfee, and other antivirus may flag "irm | iex" (download-and-execute)
# as suspicious. Downloading first then running locally avoids this.

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Power User - Dev Environment Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This script will check and install everything you need"
Write-Host "to start the Claude Code Power User curriculum."
Write-Host ""

# Track results for final report
$results = @{}

function Check-Command {
    param([string]$Name, [string]$Command)
    try {
        $parts = $Command -split ' ', 2
        $exe = $parts[0]
        $args = if ($parts.Length -gt 1) { $parts[1] } else { "" }
        if (-not (Get-Command $exe -ErrorAction SilentlyContinue)) { return $null }
        $output = if ($args) { & $exe $args 2>&1 | Out-String } else { & $exe 2>&1 | Out-String }
        return $output.Trim()
    } catch {
        return $null
    }
}

function Install-WithWinget {
    param([string]$Name, [string]$PackageId, [string]$VerifyCommand)

    Write-Host "  Installing $Name..." -ForegroundColor Yellow
    try {
        winget install --id $PackageId --accept-package-agreements --accept-source-agreements --silent

        # Refresh PATH for current session
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

        $version = Check-Command $Name $VerifyCommand
        if ($version) {
            Write-Host "  Installed $Name" -ForegroundColor Green
            return $true
        } else {
            Write-Host "  $Name installed but not in PATH - you may need to restart your terminal" -ForegroundColor Yellow
            return $true
        }
    } catch {
        Write-Host "  Failed to install $Name - install manually" -ForegroundColor Red
        return $false
    }
}

# ============================================
# Check winget (needed for automated installs)
# ============================================
Write-Host "Checking winget..." -ForegroundColor Cyan
$wingetAvailable = $null -ne (Get-Command winget -ErrorAction SilentlyContinue)
if (-not $wingetAvailable) {
    Write-Host "  winget not found. You're on an older Windows version." -ForegroundColor Yellow
    Write-Host "  You'll need to install dependencies manually - the guide below will help." -ForegroundColor Yellow
    Write-Host ""
}

# ============================================
# 1. Git
# ============================================
Write-Host "Checking Git..." -ForegroundColor Cyan
$gitVersion = Check-Command "Git" "git --version"
if ($gitVersion) {
    Write-Host "  Found: $gitVersion" -ForegroundColor Green
    $results["Git"] = "pass"
} else {
    Write-Host "  Not found" -ForegroundColor Red
    if ($wingetAvailable) {
        $installed = Install-WithWinget "Git" "Git.Git" "git --version"
        $results["Git"] = if ($installed) { "installed" } else { "FAIL" }
    } else {
        Write-Host "  Download from: https://git-scm.com/download/win" -ForegroundColor Yellow
        Write-Host "  IMPORTANT: During install, select 'Add to PATH'" -ForegroundColor Yellow
        $results["Git"] = "MANUAL"
    }
}
Write-Host ""

# ============================================
# 2. Node.js
# ============================================
Write-Host "Checking Node.js..." -ForegroundColor Cyan
$nodeVersion = Check-Command "Node.js" "node --version"
if ($nodeVersion) {
    # Check if version is 18+
    $major = [int]($nodeVersion -replace 'v(\d+)\..*', '$1')
    if ($major -ge 18) {
        Write-Host "  Found: Node.js $nodeVersion" -ForegroundColor Green
        $results["Node.js"] = "pass"
    } else {
        Write-Host "  Found $nodeVersion but need v18+. Upgrading..." -ForegroundColor Yellow
        if ($wingetAvailable) {
            $installed = Install-WithWinget "Node.js" "OpenJS.NodeJS.LTS" "node --version"
            $results["Node.js"] = if ($installed) { "installed" } else { "FAIL" }
        } else {
            Write-Host "  Download from: https://nodejs.org (LTS version)" -ForegroundColor Yellow
            $results["Node.js"] = "MANUAL"
        }
    }
} else {
    Write-Host "  Not found" -ForegroundColor Red
    if ($wingetAvailable) {
        $installed = Install-WithWinget "Node.js" "OpenJS.NodeJS.LTS" "node --version"
        $results["Node.js"] = if ($installed) { "installed" } else { "FAIL" }
    } else {
        Write-Host "  Download from: https://nodejs.org (LTS version)" -ForegroundColor Yellow
        $results["Node.js"] = "MANUAL"
    }
}
Write-Host ""

# ============================================
# 3. npm (comes with Node.js, but verify PATH)
# ============================================
Write-Host "Checking npm..." -ForegroundColor Cyan
$npmVersion = Check-Command "npm" "npm --version"
if ($npmVersion) {
    Write-Host "  Found: npm $npmVersion" -ForegroundColor Green
    $results["npm"] = "pass"
} else {
    Write-Host "  Not in PATH - Node.js may need a terminal restart" -ForegroundColor Yellow
    $results["npm"] = "RESTART"
}
Write-Host ""

# ============================================
# 4. VS Code
# ============================================
Write-Host "Checking VS Code..." -ForegroundColor Cyan
$codeVersion = Check-Command "VS Code" "code --version"

# Also check common install locations if 'code' isn't in PATH
if (-not $codeVersion) {
    $commonPaths = @(
        "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd",
        "$env:LOCALAPPDATA\Programs\Microsoft VS Code\Code.exe",
        "C:\Program Files\Microsoft VS Code\bin\code.cmd",
        "C:\Program Files\Microsoft VS Code\Code.exe",
        "$env:LOCALAPPDATA\Programs\Microsoft VS Code Insiders\bin\code-insiders.cmd"
    )
    foreach ($p in $commonPaths) {
        if (Test-Path $p) {
            $codeVersion = "installed (found at $p but not in PATH)"
            Write-Host "  Found VS Code at $p" -ForegroundColor Green
            Write-Host "  TIP: 'code' command not in PATH. Open VS Code, press Ctrl+Shift+P," -ForegroundColor Yellow
            Write-Host '  type "Shell Command: Install code command in PATH", and restart terminal.' -ForegroundColor Yellow
            $results["VS Code"] = "pass"
            break
        }
    }
}

if ($codeVersion -and $results["VS Code"] -eq "pass") {
    # Already handled above (found via file path)
} elseif ($codeVersion) {
    $firstLine = ($codeVersion -split "`n")[0]
    Write-Host "  Found: VS Code $firstLine" -ForegroundColor Green
    $results["VS Code"] = "pass"
} else {
    Write-Host "  Not found" -ForegroundColor Red
    if ($wingetAvailable) {
        $installed = Install-WithWinget "VS Code" "Microsoft.VisualStudioCode" "code --version"
        $results["VS Code"] = if ($installed) { "installed" } else { "FAIL" }
    } else {
        Write-Host "  Download from: https://code.visualstudio.com" -ForegroundColor Yellow
        $results["VS Code"] = "MANUAL"
    }
}
Write-Host ""

# ============================================
# 5. Claude Code
# ============================================
Write-Host "Checking Claude Code..." -ForegroundColor Cyan
$claudeVersion = Check-Command "Claude Code" "claude --version"
if ($claudeVersion) {
    Write-Host "  Found: Claude Code $claudeVersion" -ForegroundColor Green
    $results["Claude Code"] = "pass"
} else {
    if ($npmVersion) {
        Write-Host "  Installing Claude Code..." -ForegroundColor Yellow
        try {
            npm install -g @anthropic-ai/claude-code 2>&1 | Out-Null
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
            $claudeCheck = Check-Command "Claude Code" "claude --version"
            if ($claudeCheck) {
                Write-Host "  Installed: Claude Code $claudeCheck" -ForegroundColor Green
                $results["Claude Code"] = "installed"
            } else {
                Write-Host "  Installed but not in PATH - restart your terminal" -ForegroundColor Yellow
                $results["Claude Code"] = "RESTART"
            }
        } catch {
            Write-Host "  Failed - try manually: npm install -g @anthropic-ai/claude-code" -ForegroundColor Red
            $results["Claude Code"] = "FAIL"
        }
    } else {
        Write-Host "  Skipped - need npm first (install Node.js, restart terminal, re-run this script)" -ForegroundColor Yellow
        $results["Claude Code"] = "BLOCKED"
    }
}
Write-Host ""

# ============================================
# 6. Bun (optional)
# ============================================
Write-Host "Checking Bun (optional)..." -ForegroundColor Cyan
$bunVersion = Check-Command "Bun" "bun --version"
if ($bunVersion) {
    Write-Host "  Found: Bun $bunVersion" -ForegroundColor Green
    $results["Bun"] = "pass"
} else {
    Write-Host "  Not found (optional - needed for Aaron's web stack)" -ForegroundColor Yellow
    Write-Host "  Install later with: powershell -c 'irm bun.sh/install.ps1 | iex'" -ForegroundColor Yellow
    $results["Bun"] = "optional"
}
Write-Host ""

# ============================================
# 7. GitHub CLI + GitHub Account
# ============================================
Write-Host "Checking GitHub CLI..." -ForegroundColor Cyan
$ghVersion = Check-Command "GitHub CLI" "gh --version"
if ($ghVersion) {
    $firstLine = ($ghVersion -split "`n")[0]
    Write-Host "  Found: $firstLine" -ForegroundColor Green

    # Check if authenticated
    $ghAuth = Check-Command "GitHub Auth" "gh auth status"
    if ($ghAuth -and $ghAuth -notmatch "not logged in") {
        Write-Host "  Authenticated with GitHub" -ForegroundColor Green
        $results["GitHub CLI"] = "pass"
    } else {
        Write-Host "  Installed but not logged in" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "  You need a GitHub account for this curriculum." -ForegroundColor Yellow
        Write-Host "  If you don't have one, sign up free at: https://github.com/signup" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "  Then run this command to log in:" -ForegroundColor Yellow
        Write-Host "    gh auth login" -ForegroundColor White
        Write-Host ""
        Write-Host "  Choose: GitHub.com -> HTTPS -> Login with a web browser" -ForegroundColor Yellow
        $results["GitHub CLI"] = "RESTART"
    }
} else {
    Write-Host "  Not found - installing..." -ForegroundColor Yellow
    if ($wingetAvailable) {
        $installed = Install-WithWinget "GitHub CLI" "GitHub.cli" "gh --version"
        if ($installed) {
            Write-Host ""
            Write-Host "  You need a GitHub account for this curriculum." -ForegroundColor Yellow
            Write-Host "  If you don't have one, sign up free at: https://github.com/signup" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "  After restarting your terminal, run:" -ForegroundColor Yellow
            Write-Host "    gh auth login" -ForegroundColor White
            $results["GitHub CLI"] = "RESTART"
        } else {
            $results["GitHub CLI"] = "FAIL"
        }
    } else {
        Write-Host "  Download from: https://cli.github.com" -ForegroundColor Yellow
        Write-Host "  You'll also need a GitHub account: https://github.com/signup" -ForegroundColor Yellow
        $results["GitHub CLI"] = "MANUAL"
    }
}
Write-Host ""

# ============================================
# 8. Configure VS Code default terminal to Git Bash
# ============================================
Write-Host "Configuring VS Code terminal..." -ForegroundColor Cyan
$gitBashPath = "C:\Program Files\Git\bin\bash.exe"
if (Test-Path $gitBashPath) {
    $settingsDir = "$env:APPDATA\Code\User"
    $settingsFile = "$settingsDir\settings.json"

    if (Test-Path $settingsFile) {
        $settings = Get-Content $settingsFile -Raw
        if ($settings -match "terminal.integrated.defaultProfile.windows") {
            Write-Host "  VS Code terminal profile already configured" -ForegroundColor Green
        } else {
            Write-Host "  TIP: Set VS Code default terminal to Git Bash:" -ForegroundColor Yellow
            Write-Host '  Open VS Code -> Ctrl+Shift+P -> "Terminal: Select Default Profile" -> Git Bash' -ForegroundColor Yellow
        }
    } else {
        Write-Host "  TIP: After opening VS Code, set default terminal to Git Bash:" -ForegroundColor Yellow
        Write-Host '  Ctrl+Shift+P -> "Terminal: Select Default Profile" -> Git Bash' -ForegroundColor Yellow
    }
} else {
    Write-Host "  Git Bash not found at expected path - set terminal manually after Git installs" -ForegroundColor Yellow
}
Write-Host ""

# ============================================
# Results
# ============================================
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Setup Results" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$allGood = $true
foreach ($tool in @("Git", "Node.js", "npm", "VS Code", "Claude Code", "Bun", "GitHub CLI")) {
    $status = $results[$tool]
    switch ($status) {
        "pass"      { Write-Host "  [OK]      $tool" -ForegroundColor Green }
        "installed" { Write-Host "  [NEW]     $tool (just installed)" -ForegroundColor Green }
        "optional"  { Write-Host "  [SKIP]    $tool (optional - install later if needed)" -ForegroundColor Yellow }
        "RESTART"   { Write-Host "  [RESTART] $tool (restart terminal, then verify)" -ForegroundColor Yellow; $allGood = $false }
        "MANUAL"    { Write-Host "  [MANUAL]  $tool (install manually - see URLs above)" -ForegroundColor Red; $allGood = $false }
        "BLOCKED"   { Write-Host "  [BLOCKED] $tool (install dependencies first, re-run script)" -ForegroundColor Red; $allGood = $false }
        "FAIL"      { Write-Host "  [FAIL]    $tool (install manually)" -ForegroundColor Red; $allGood = $false }
        default     { Write-Host "  [?]       $tool" -ForegroundColor Yellow }
    }
}

# ============================================
# 9. Clone curriculum repo
# ============================================
Write-Host "Setting up curriculum..." -ForegroundColor Cyan

$projectsDir = "$env:USERPROFILE\Projects"
$repoDir = "$projectsDir\power-user"

if (Test-Path "$repoDir\curriculum") {
    Write-Host "  Found existing curriculum at $repoDir" -ForegroundColor Green
    $results["Curriculum"] = "pass"
} else {
    # Create Projects folder if it doesn't exist
    if (-not (Test-Path $projectsDir)) {
        Write-Host "  Creating $projectsDir..." -ForegroundColor Yellow
        New-Item -ItemType Directory -Path $projectsDir -Force | Out-Null
    }

    if (Check-Command "Git" "git --version") {
        Write-Host "  Cloning curriculum to $repoDir..." -ForegroundColor Yellow
        try {
            git clone https://github.com/melvenac/power-user.git $repoDir 2>&1 | Out-Null
            if (Test-Path "$repoDir\curriculum") {
                Write-Host "  Curriculum ready at $repoDir" -ForegroundColor Green
                $results["Curriculum"] = "installed"
            } else {
                Write-Host "  Clone failed - try manually: git clone https://github.com/melvenac/power-user.git $repoDir" -ForegroundColor Red
                $results["Curriculum"] = "FAIL"
            }
        } catch {
            Write-Host "  Clone failed - try manually: git clone https://github.com/melvenac/power-user.git $repoDir" -ForegroundColor Red
            $results["Curriculum"] = "FAIL"
        }
    } else {
        Write-Host "  Skipped - need Git first. Re-run after installing Git." -ForegroundColor Yellow
        $results["Curriculum"] = "BLOCKED"
    }
}
Write-Host ""

# ============================================
# Results
# ============================================
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Setup Results" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$allGood = $true
foreach ($tool in @("Git", "Node.js", "npm", "VS Code", "Claude Code", "Bun", "GitHub CLI", "Curriculum")) {
    $status = $results[$tool]
    switch ($status) {
        "pass"      { Write-Host "  [OK]      $tool" -ForegroundColor Green }
        "installed" { Write-Host "  [NEW]     $tool (just installed)" -ForegroundColor Green }
        "optional"  { Write-Host "  [SKIP]    $tool (optional - install later if needed)" -ForegroundColor Yellow }
        "RESTART"   { Write-Host "  [RESTART] $tool (restart terminal, then verify)" -ForegroundColor Yellow; $allGood = $false }
        "MANUAL"    { Write-Host "  [MANUAL]  $tool (install manually - see URLs above)" -ForegroundColor Red; $allGood = $false }
        "BLOCKED"   { Write-Host "  [BLOCKED] $tool (install dependencies first, re-run script)" -ForegroundColor Red; $allGood = $false }
        "FAIL"      { Write-Host "  [FAIL]    $tool (install manually)" -ForegroundColor Red; $allGood = $false }
        default     { Write-Host "  [?]       $tool" -ForegroundColor Yellow }
    }
}

Write-Host ""
if ($allGood) {
    Write-Host "All set! Opening the curriculum now..." -ForegroundColor Green
    Write-Host ""

    # Open VS Code in the curriculum folder
    $codeCmd = $null
    if (Check-Command "code" "code --version") {
        $codeCmd = "code"
    } else {
        # Check common install paths
        $codePaths = @(
            "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin\code.cmd",
            "C:\Program Files\Microsoft VS Code\bin\code.cmd"
        )
        foreach ($p in $codePaths) {
            if (Test-Path $p) { $codeCmd = $p; break }
        }
    }

    if ($codeCmd -and (Test-Path $repoDir)) {
        Write-Host "  Opening VS Code in $repoDir..." -ForegroundColor Cyan
        & $codeCmd $repoDir
        Write-Host ""
        Write-Host "  VS Code should be opening now. When it does:" -ForegroundColor Cyan
        Write-Host "    1. Set default terminal to Git Bash" -ForegroundColor White
        Write-Host "       (Ctrl+Shift+P -> Terminal: Select Default Profile -> Git Bash)" -ForegroundColor White
        Write-Host "    2. Open a terminal (Ctrl+``)" -ForegroundColor White
        Write-Host "    3. Type: claude" -ForegroundColor White
        Write-Host "    4. Follow the authentication prompts" -ForegroundColor White
        Write-Host "    5. Open curriculum/00-getting-started/00-setup.md and start reading!" -ForegroundColor White
    } else {
        Write-Host "Next steps:" -ForegroundColor Cyan
        Write-Host "  1. Open VS Code" -ForegroundColor White
        Write-Host "  2. File -> Open Folder -> $repoDir" -ForegroundColor White
        Write-Host "  3. Set default terminal to Git Bash (Ctrl+Shift+P -> Terminal: Select Default Profile)" -ForegroundColor White
        Write-Host "  4. Open a terminal and type: claude" -ForegroundColor White
        Write-Host "  5. Open curriculum/00-getting-started/00-setup.md and start reading!" -ForegroundColor White
    }
    Write-Host ""
} else {
    Write-Host "Some items need attention - see details above." -ForegroundColor Yellow
    Write-Host "After fixing, restart your terminal and run this script again to verify." -ForegroundColor Yellow
    Write-Host ""
}
