# Power User — Windows Setup Script
# Run in PowerShell: irm https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.ps1 | iex
# Or locally: powershell -ExecutionPolicy Bypass -File scripts/setup.ps1

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Power User — Dev Environment Setup" -ForegroundColor Cyan
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
        $output = Invoke-Expression "$Command 2>&1" | Out-String
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
            Write-Host "  $Name installed but not in PATH — you may need to restart your terminal" -ForegroundColor Yellow
            return $true
        }
    } catch {
        Write-Host "  Failed to install $Name — install manually" -ForegroundColor Red
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
    Write-Host "  You'll need to install dependencies manually — the guide below will help." -ForegroundColor Yellow
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
    Write-Host "  Not in PATH — Node.js may need a terminal restart" -ForegroundColor Yellow
    $results["npm"] = "RESTART"
}
Write-Host ""

# ============================================
# 4. VS Code
# ============================================
Write-Host "Checking VS Code..." -ForegroundColor Cyan
$codeVersion = Check-Command "VS Code" "code --version"
if ($codeVersion) {
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
                Write-Host "  Installed but not in PATH — restart your terminal" -ForegroundColor Yellow
                $results["Claude Code"] = "RESTART"
            }
        } catch {
            Write-Host "  Failed — try manually: npm install -g @anthropic-ai/claude-code" -ForegroundColor Red
            $results["Claude Code"] = "FAIL"
        }
    } else {
        Write-Host "  Skipped — need npm first (install Node.js, restart terminal, re-run this script)" -ForegroundColor Yellow
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
    Write-Host "  Not found (optional — needed for Aaron's web stack)" -ForegroundColor Yellow
    Write-Host "  Install later with: powershell -c 'irm bun.sh/install.ps1 | iex'" -ForegroundColor Yellow
    $results["Bun"] = "optional"
}
Write-Host ""

# ============================================
# 7. GitHub CLI (optional but recommended)
# ============================================
Write-Host "Checking GitHub CLI (optional)..." -ForegroundColor Cyan
$ghVersion = Check-Command "GitHub CLI" "gh --version"
if ($ghVersion) {
    $firstLine = ($ghVersion -split "`n")[0]
    Write-Host "  Found: $firstLine" -ForegroundColor Green
    $results["GitHub CLI"] = "pass"
} else {
    Write-Host "  Not found (recommended for git workflow)" -ForegroundColor Yellow
    if ($wingetAvailable) {
        Write-Host "  Install with: winget install GitHub.cli" -ForegroundColor Yellow
    } else {
        Write-Host "  Download from: https://cli.github.com" -ForegroundColor Yellow
    }
    $results["GitHub CLI"] = "optional"
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
            Write-Host '  Open VS Code → Ctrl+Shift+P → "Terminal: Select Default Profile" → Git Bash' -ForegroundColor Yellow
        }
    } else {
        Write-Host "  TIP: After opening VS Code, set default terminal to Git Bash:" -ForegroundColor Yellow
        Write-Host '  Ctrl+Shift+P → "Terminal: Select Default Profile" → Git Bash' -ForegroundColor Yellow
    }
} else {
    Write-Host "  Git Bash not found at expected path — set terminal manually after Git installs" -ForegroundColor Yellow
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
        "optional"  { Write-Host "  [SKIP]    $tool (optional — install later if needed)" -ForegroundColor Yellow }
        "RESTART"   { Write-Host "  [RESTART] $tool (restart terminal, then verify)" -ForegroundColor Yellow; $allGood = $false }
        "MANUAL"    { Write-Host "  [MANUAL]  $tool (install manually — see URLs above)" -ForegroundColor Red; $allGood = $false }
        "BLOCKED"   { Write-Host "  [BLOCKED] $tool (install dependencies first, re-run script)" -ForegroundColor Red; $allGood = $false }
        "FAIL"      { Write-Host "  [FAIL]    $tool (install manually)" -ForegroundColor Red; $allGood = $false }
        default     { Write-Host "  [?]       $tool" -ForegroundColor Yellow }
    }
}

Write-Host ""
if ($allGood) {
    Write-Host "All set! You're ready to start the curriculum." -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "  1. Open VS Code"
    Write-Host "  2. Set default terminal to Git Bash (Ctrl+Shift+P → Terminal: Select Default Profile)"
    Write-Host "  3. Open a terminal and type: claude"
    Write-Host "  4. Follow the authentication prompts"
    Write-Host "  5. Start Module 00: curriculum/00-getting-started/"
    Write-Host ""
} else {
    Write-Host "Some items need attention — see details above." -ForegroundColor Yellow
    Write-Host "After fixing, restart your terminal and run this script again to verify." -ForegroundColor Yellow
    Write-Host ""
}
