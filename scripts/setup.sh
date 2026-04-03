#!/usr/bin/env bash
# Power User — Mac/Linux Setup Script
#
# RECOMMENDED (works on Mac and Linux):
#   1. Download:  curl -fsSL https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.sh -o setup.sh
#   2. Run:       bash setup.sh
#
# OR if already cloned: bash scripts/setup.sh

set -e

# ============================================
# Check if running in a pipe (curl | bash)
# Homebrew and sudo need interactive input
# ============================================
if [[ ! -t 0 ]]; then
    echo ""
    echo "========================================="
    echo "  Heads up: this script needs keyboard"
    echo "  input (for passwords, confirmations)."
    echo "  Piping from curl won't work."
    echo "========================================="
    echo ""
    echo "Run these two commands instead:"
    echo ""
    echo "  curl -fsSL https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.sh -o setup.sh"
    echo "  bash setup.sh"
    echo ""
    exit 1
fi

echo ""
echo "========================================"
echo "  Power User — Dev Environment Setup"
echo "========================================"
echo ""
echo "This script will check and install everything you need"
echo "to start the Claude Code Power User curriculum."
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ============================================
# System Requirements Check
# ============================================
echo -e "${CYAN}Checking system requirements...${NC}"
echo ""

# --- RAM Check ---
if [[ "$OSTYPE" == "darwin"* ]]; then
    total_ram_bytes=$(sysctl -n hw.memsize 2>/dev/null || echo 0)
    total_ram_gb=$(( total_ram_bytes / 1073741824 ))
else
    total_ram_kb=$(grep MemTotal /proc/meminfo 2>/dev/null | awk '{print $2}')
    total_ram_gb=$(( ${total_ram_kb:-0} / 1048576 ))
fi

echo -e "  RAM: ${total_ram_gb} GB"

if [[ $total_ram_gb -lt 8 ]]; then
    echo ""
    echo -e "  ${RED}WARNING: ${total_ram_gb} GB RAM is below the minimum (8 GB).${NC}"
    echo -e "  ${RED}Claude Code + VS Code together need ~6-7 GB, leaving almost${NC}"
    echo -e "  ${RED}nothing for your OS. This setup will not work well.${NC}"
    echo ""
    read -p "  Continue anyway? (y/N) " continue_choice
    if [[ "$continue_choice" != "y" ]]; then
        echo ""
        echo -e "  ${YELLOW}Setup cancelled. Consider upgrading RAM to at least 8 GB (16 GB recommended).${NC}"
        exit 1
    fi
elif [[ $total_ram_gb -lt 16 ]]; then
    echo -e "  ${YELLOW}NOTE: 8 GB is workable but tight. Close other apps when using Claude Code.${NC}"
else
    echo -e "  ${GREEN}RAM: OK${NC}"
fi

# --- Disk Space Check ---
if [[ "$OSTYPE" == "darwin"* ]]; then
    free_gb=$(df -g / | awk 'NR==2 {print $4}')
else
    free_kb=$(df / | awk 'NR==2 {print $4}')
    free_gb=$(( ${free_kb:-0} / 1048576 ))
fi

echo -e "  Disk: ${free_gb} GB free"

if [[ $free_gb -lt 20 ]]; then
    echo ""
    echo -e "  ${RED}NOT ENOUGH DISK SPACE.${NC}"
    echo -e "  ${RED}This setup installs ~16-17 GB (Claude Code alone is ~15 GB).${NC}"
    echo -e "  ${RED}Your OS also needs space for swap files and updates.${NC}"
    echo -e "  ${RED}You need at least 20 GB free, 30+ GB recommended.${NC}"
    echo ""
    echo -e "  ${YELLOW}Free up space and try again.${NC}"
    exit 1
elif [[ $free_gb -lt 30 ]]; then
    echo -e "  ${YELLOW}WARNING: Space is tight. Installation may succeed but your system${NC}"
    echo -e "  ${YELLOW}will be cramped. 30+ GB free is recommended.${NC}"
    echo ""
    read -p "  Continue anyway? (y/N) " continue_choice
    if [[ "$continue_choice" != "y" ]]; then
        echo ""
        echo -e "  ${YELLOW}Setup cancelled. Free up space and try again.${NC}"
        exit 1
    fi
else
    echo -e "  ${GREEN}Disk: OK${NC}"
fi

echo ""

# Track results (using simple variables for bash 3.2 compatibility on macOS)
result_Git=""
result_Node=""
result_npm=""
result_VSCode=""
result_Claude=""
result_Bun=""
result_GH=""
result_Curriculum=""

check_command() {
    if command -v "$1" &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Detect OS
OS="unknown"
INSTALLER="none"
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
    if check_command brew; then
        INSTALLER="brew"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    if check_command apt-get; then
        INSTALLER="apt"
    elif check_command dnf; then
        INSTALLER="dnf"
    elif check_command pacman; then
        INSTALLER="pacman"
    fi
fi

echo -e "${CYAN}Detected: $OS (package manager: $INSTALLER)${NC}"
echo ""

# ============================================
# Mac: Check for Homebrew
# ============================================
if [[ "$OS" == "mac" && "$INSTALLER" != "brew" ]]; then
    echo -e "${CYAN}Installing Homebrew (Mac package manager)...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add to PATH for Apple Silicon
    if [[ -f /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    if check_command brew; then
        INSTALLER="brew"
        echo -e "  ${GREEN}Homebrew installed${NC}"
    else
        echo -e "  ${RED}Homebrew install failed — install manually: https://brew.sh${NC}"
    fi
    echo ""
fi

# ============================================
# 1. Git
# ============================================
echo -e "${CYAN}Checking Git...${NC}"
if check_command git; then
    version=$(git --version)
    echo -e "  ${GREEN}Found: $version${NC}"
    result_Git="pass"
else
    echo -e "  ${RED}Not found${NC}"
    case $INSTALLER in
        brew)   echo "  Installing..." && brew install git ;;
        apt)    echo "  Installing..." && sudo apt-get update && sudo apt-get install -y git ;;
        dnf)    echo "  Installing..." && sudo dnf install -y git ;;
        pacman) echo "  Installing..." && sudo pacman -S --noconfirm git ;;
        *)      echo -e "  ${YELLOW}Install manually: https://git-scm.com${NC}" ;;
    esac

    if check_command git; then
        echo -e "  ${GREEN}Installed: $(git --version)${NC}"
        result_Git="installed"
    else
        result_Git="FAIL"
    fi
fi
echo ""

# ============================================
# 2. Node.js
# ============================================
echo -e "${CYAN}Checking Node.js...${NC}"
if check_command node; then
    version=$(node --version)
    major=$(echo "$version" | sed 's/v\([0-9]*\).*/\1/')
    if [[ $major -ge 18 ]]; then
        echo -e "  ${GREEN}Found: Node.js $version${NC}"
        result_Node="pass"
    else
        echo -e "  ${YELLOW}Found $version but need v18+. Upgrading...${NC}"
        case $INSTALLER in
            brew)   brew install node@22 ;;
            apt)    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - && sudo apt-get install -y nodejs ;;
            dnf)    curl -fsSL https://rpm.nodesource.com/setup_22.x | sudo bash - && sudo dnf install -y nodejs ;;
            pacman) sudo pacman -S --noconfirm nodejs npm ;;
        esac
        if check_command node; then
            echo -e "  ${GREEN}Upgraded: Node.js $(node --version)${NC}"
            result_Node="installed"
        else
            result_Node="FAIL"
        fi
    fi
else
    echo -e "  ${RED}Not found${NC}"
    case $INSTALLER in
        brew)   echo "  Installing..." && brew install node@22 ;;
        apt)    echo "  Installing..." && curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - && sudo apt-get install -y nodejs ;;
        dnf)    echo "  Installing..." && curl -fsSL https://rpm.nodesource.com/setup_22.x | sudo bash - && sudo dnf install -y nodejs ;;
        pacman) echo "  Installing..." && sudo pacman -S --noconfirm nodejs npm ;;
        *)      echo -e "  ${YELLOW}Install from: https://nodejs.org (LTS)${NC}" ;;
    esac

    if check_command node; then
        echo -e "  ${GREEN}Installed: Node.js $(node --version)${NC}"
        result_Node="installed"
    else
        result_Node="FAIL"
    fi
fi
echo ""

# ============================================
# 3. npm
# ============================================
echo -e "${CYAN}Checking npm...${NC}"
if check_command npm; then
    echo -e "  ${GREEN}Found: npm $(npm --version)${NC}"
    result_npm="pass"
else
    echo -e "  ${YELLOW}Not found — should come with Node.js. Restart terminal.${NC}"
    result_npm="RESTART"
fi
echo ""

# ============================================
# 4. VS Code
# ============================================
echo -e "${CYAN}Checking VS Code...${NC}"
if check_command code; then
    version=$(code --version 2>/dev/null | head -1)
    echo -e "  ${GREEN}Found: VS Code $version${NC}"
    result_VSCode="pass"
elif [[ "$OS" == "mac" && -d "/Applications/Visual Studio Code.app" ]]; then
    # VS Code is installed but 'code' CLI isn't in PATH
    echo -e "  ${GREEN}Found: VS Code (installed in /Applications)${NC}"
    echo -e "  ${YELLOW}TIP: The 'code' command is not in your PATH.${NC}"
    echo -e "  ${YELLOW}Open VS Code, press Cmd+Shift+P, type 'Shell Command: Install code command in PATH', press Enter.${NC}"
    result_VSCode="pass"
else
    echo -e "  ${RED}Not found${NC}"
    case $INSTALLER in
        brew)
            echo "  Installing..." && brew install --cask visual-studio-code
            if check_command code || [[ -d "/Applications/Visual Studio Code.app" ]]; then
                echo -e "  ${GREEN}Installed VS Code${NC}"
                echo -e "  ${YELLOW}TIP: Open VS Code, press Cmd+Shift+P, type 'Shell Command: Install code command in PATH'${NC}"
                result_VSCode="installed"
            else
                result_VSCode="FAIL"
            fi
            ;;
        *)
            echo -e "  ${YELLOW}Download from: https://code.visualstudio.com${NC}"
            if [[ "$OS" == "linux" ]]; then
                echo -e "  ${YELLOW}Or: sudo snap install code --classic${NC}"
            fi
            result_VSCode="MANUAL"
            ;;
    esac
fi
echo ""

# ============================================
# 5. Claude Code
# ============================================
echo -e "${CYAN}Checking Claude Code...${NC}"
if check_command claude; then
    version=$(claude --version 2>/dev/null)
    echo -e "  ${GREEN}Found: Claude Code $version${NC}"
    result_Claude="pass"
else
    if check_command npm; then
        echo "  Installing Claude Code..."
        # Mac/Linux global npm installs typically need sudo
        if [[ "$OS" == "mac" ]]; then
            echo -e "  ${YELLOW}(May ask for your password — this is normal)${NC}"
            sudo npm install -g @anthropic-ai/claude-code
        else
            npm install -g @anthropic-ai/claude-code || sudo npm install -g @anthropic-ai/claude-code
        fi
        if check_command claude; then
            echo -e "  ${GREEN}Installed: Claude Code $(claude --version 2>/dev/null)${NC}"
            result_Claude="installed"
        else
            echo -e "  ${YELLOW}Installed but not in PATH — try: export PATH=\"\$(npm bin -g):\$PATH\"${NC}"
            result_Claude="RESTART"
        fi
    else
        echo -e "  ${YELLOW}Skipped — need npm first${NC}"
        result_Claude="BLOCKED"
    fi
fi
echo ""

# ============================================
# 6. Bun (optional)
# ============================================
echo -e "${CYAN}Checking Bun (optional)...${NC}"
if check_command bun; then
    echo -e "  ${GREEN}Found: Bun $(bun --version)${NC}"
    result_Bun="pass"
else
    echo -e "  ${YELLOW}Not found (optional — needed for Aaron's web stack)${NC}"
    echo -e "  ${YELLOW}Install later with: curl -fsSL https://bun.sh/install | bash${NC}"
    result_Bun="optional"
fi
echo ""

# ============================================
# 7. GitHub CLI + GitHub Account
# ============================================
echo -e "${CYAN}Checking GitHub CLI...${NC}"
if check_command gh; then
    version=$(gh --version | head -1)
    echo -e "  ${GREEN}Found: $version${NC}"

    # Check if authenticated
    if gh auth status &>/dev/null; then
        echo -e "  ${GREEN}Authenticated with GitHub${NC}"
        result_GH="pass"
    else
        echo -e "  ${YELLOW}Installed but not logged in${NC}"
        echo ""
        echo -e "  ${YELLOW}You need a GitHub account for this curriculum.${NC}"
        echo -e "  ${YELLOW}If you don't have one, sign up free at: https://github.com/signup${NC}"
        echo ""
        echo -e "  ${YELLOW}Then run this command to log in:${NC}"
        echo "    gh auth login"
        echo ""
        echo -e "  ${YELLOW}Choose: GitHub.com → HTTPS → Login with a web browser${NC}"
        result_GH="RESTART"
    fi
else
    echo -e "  ${YELLOW}Not found — installing...${NC}"
    case $INSTALLER in
        brew)   brew install gh ;;
        apt)    sudo apt install -y gh 2>/dev/null || (curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && sudo apt update && sudo apt install -y gh) ;;
        dnf)    sudo dnf install -y gh ;;
        pacman) sudo pacman -S --noconfirm github-cli ;;
        *)      echo -e "  ${YELLOW}Install from: https://cli.github.com${NC}" ;;
    esac

    if check_command gh; then
        echo -e "  ${GREEN}Installed: $(gh --version | head -1)${NC}"
        echo ""
        echo -e "  ${YELLOW}You need a GitHub account for this curriculum.${NC}"
        echo -e "  ${YELLOW}If you don't have one, sign up free at: https://github.com/signup${NC}"
        echo ""
        echo -e "  ${YELLOW}After restarting your terminal, run:${NC}"
        echo "    gh auth login"
        result_GH="RESTART"
    else
        echo -e "  ${RED}Install failed — get it from: https://cli.github.com${NC}"
        echo -e "  ${YELLOW}You'll also need a GitHub account: https://github.com/signup${NC}"
        result_GH="FAIL"
    fi
fi
echo ""

# ============================================
# Results
# ============================================
echo "========================================"
echo "  Setup Results"
echo "========================================"
echo ""

all_good=true
for tool in Git Node npm VSCode Claude Bun GH; do
    eval "status=\$result_$tool"
    case $status in
        pass)      echo -e "  ${GREEN}[OK]      $tool${NC}" ;;
        installed) echo -e "  ${GREEN}[NEW]     $tool (just installed)${NC}" ;;
        optional)  echo -e "  ${YELLOW}[SKIP]    $tool (optional — install later if needed)${NC}" ;;
        RESTART)   echo -e "  ${YELLOW}[RESTART] $tool (restart terminal, then verify)${NC}"; all_good=false ;;
        MANUAL)    echo -e "  ${RED}[MANUAL]  $tool (install manually — see URLs above)${NC}"; all_good=false ;;
        BLOCKED)   echo -e "  ${RED}[BLOCKED] $tool (install dependencies first, re-run)${NC}"; all_good=false ;;
        FAIL)      echo -e "  ${RED}[FAIL]    $tool (install manually)${NC}"; all_good=false ;;
        *)         echo -e "  ${YELLOW}[?]       $tool${NC}" ;;
    esac
done

# ============================================
# 8. Clone curriculum repo
# ============================================
echo -e "${CYAN}Setting up curriculum...${NC}"

PROJECTS_DIR="$HOME/Projects"
REPO_DIR="$PROJECTS_DIR/power-user"

if [[ -d "$REPO_DIR/curriculum" ]]; then
    echo -e "  ${GREEN}Found existing curriculum at $REPO_DIR${NC}"
    result_Curriculum="pass"
else
    # Create Projects folder if it doesn't exist
    if [[ ! -d "$PROJECTS_DIR" ]]; then
        echo -e "  ${YELLOW}Creating $PROJECTS_DIR...${NC}"
        mkdir -p "$PROJECTS_DIR"
    fi

    if check_command git; then
        echo -e "  ${YELLOW}Cloning curriculum to $REPO_DIR...${NC}"
        if git clone https://github.com/melvenac/power-user.git "$REPO_DIR" 2>/dev/null; then
            echo -e "  ${GREEN}Curriculum ready at $REPO_DIR${NC}"
            result_Curriculum="installed"
        else
            echo -e "  ${RED}Clone failed — try manually: git clone https://github.com/melvenac/power-user.git $REPO_DIR${NC}"
            result_Curriculum="FAIL"
        fi
    else
        echo -e "  ${YELLOW}Skipped — need Git first. Re-run after installing Git.${NC}"
        result_Curriculum="BLOCKED"
    fi
fi
echo ""

# ============================================
# Results
# ============================================
echo "========================================"
echo "  Setup Results"
echo "========================================"
echo ""

all_good=true
for tool in Git Node npm VSCode Claude Bun GH Curriculum; do
    eval "status=\$result_$tool"
    case $status in
        pass)      echo -e "  ${GREEN}[OK]      $tool${NC}" ;;
        installed) echo -e "  ${GREEN}[NEW]     $tool (just installed)${NC}" ;;
        optional)  echo -e "  ${YELLOW}[SKIP]    $tool (optional — install later if needed)${NC}" ;;
        RESTART)   echo -e "  ${YELLOW}[RESTART] $tool (restart terminal, then verify)${NC}"; all_good=false ;;
        MANUAL)    echo -e "  ${RED}[MANUAL]  $tool (install manually — see URLs above)${NC}"; all_good=false ;;
        BLOCKED)   echo -e "  ${RED}[BLOCKED] $tool (install dependencies first, re-run)${NC}"; all_good=false ;;
        FAIL)      echo -e "  ${RED}[FAIL]    $tool (install manually)${NC}"; all_good=false ;;
        *)         echo -e "  ${YELLOW}[?]       $tool${NC}" ;;
    esac
done

echo ""
if ! $all_good; then
    echo -e "${YELLOW}Some items need attention — see the results above.${NC}"
    echo -e "${YELLOW}You can fix those later — the core tools are likely installed.${NC}"
    echo ""
fi

# Try to open VS Code in the curriculum folder
opened_vscode=false
if [[ -d "$REPO_DIR" ]]; then
    if check_command code; then
        echo -e "  ${CYAN}Opening VS Code in $REPO_DIR...${NC}"
        code "$REPO_DIR"
        opened_vscode=true
    elif [[ "$OS" == "mac" && -d "/Applications/Visual Studio Code.app" ]]; then
        echo -e "  ${CYAN}Opening VS Code in $REPO_DIR...${NC}"
        open -a "Visual Studio Code" "$REPO_DIR"
        opened_vscode=true
    fi
fi

echo ""
if $opened_vscode; then
    echo -e "${GREEN}VS Code should be opening now. When it does:${NC}"
    echo "  1. Open a terminal (Ctrl+\` or Cmd+\`)"
    echo "  2. Type: claude"
    echo "  3. Pick a theme (Dark recommended), accept the terms"
    echo "  4. Sign in via browser (subscribe to Claude Pro \$20/mo if needed)"
    echo "  5. Type: hello"
    echo "  Claude will welcome you and walk you through your first lesson!"
else
    echo -e "${CYAN}Next steps:${NC}"
    echo "  1. Open VS Code"
    echo "  2. File -> Open Folder -> $REPO_DIR"
    echo "  3. Open a terminal (Ctrl+\` or Cmd+\`)"
    echo "  4. Type: claude"
    echo "  5. Pick a theme (Dark recommended), accept the terms"
    echo "  6. Sign in via browser (subscribe to Claude Pro \$20/mo if needed)"
    echo "  7. Type: hello"
    echo "  Claude will welcome you and walk you through your first lesson!"
fi
echo ""
