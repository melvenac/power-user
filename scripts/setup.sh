#!/usr/bin/env bash
# Power User — Mac/Linux Setup Script
# Run: curl -fsSL https://raw.githubusercontent.com/melvenac/power-user/master/scripts/setup.sh | bash
# Or locally: bash scripts/setup.sh

set -e

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

# Track results
declare -A results

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
    results[Git]="pass"
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
        results[Git]="installed"
    else
        results[Git]="FAIL"
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
        results[Node]="pass"
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
            results[Node]="installed"
        else
            results[Node]="FAIL"
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
        results[Node]="installed"
    else
        results[Node]="FAIL"
    fi
fi
echo ""

# ============================================
# 3. npm
# ============================================
echo -e "${CYAN}Checking npm...${NC}"
if check_command npm; then
    echo -e "  ${GREEN}Found: npm $(npm --version)${NC}"
    results[npm]="pass"
else
    echo -e "  ${YELLOW}Not found — should come with Node.js. Restart terminal.${NC}"
    results[npm]="RESTART"
fi
echo ""

# ============================================
# 4. VS Code
# ============================================
echo -e "${CYAN}Checking VS Code...${NC}"
if check_command code; then
    version=$(code --version 2>/dev/null | head -1)
    echo -e "  ${GREEN}Found: VS Code $version${NC}"
    results[VSCode]="pass"
else
    echo -e "  ${RED}Not found${NC}"
    case $INSTALLER in
        brew)
            echo "  Installing..." && brew install --cask visual-studio-code
            if check_command code; then
                echo -e "  ${GREEN}Installed VS Code${NC}"
                results[VSCode]="installed"
            else
                results[VSCode]="FAIL"
            fi
            ;;
        *)
            echo -e "  ${YELLOW}Download from: https://code.visualstudio.com${NC}"
            if [[ "$OS" == "linux" ]]; then
                echo -e "  ${YELLOW}Or: sudo snap install code --classic${NC}"
            fi
            results[VSCode]="MANUAL"
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
    results[Claude]="pass"
else
    if check_command npm; then
        echo "  Installing Claude Code..."
        npm install -g @anthropic-ai/claude-code
        if check_command claude; then
            echo -e "  ${GREEN}Installed: Claude Code $(claude --version 2>/dev/null)${NC}"
            results[Claude]="installed"
        else
            echo -e "  ${YELLOW}Installed but not in PATH — try: export PATH=\"\$(npm bin -g):\$PATH\"${NC}"
            results[Claude]="RESTART"
        fi
    else
        echo -e "  ${YELLOW}Skipped — need npm first${NC}"
        results[Claude]="BLOCKED"
    fi
fi
echo ""

# ============================================
# 6. Bun (optional)
# ============================================
echo -e "${CYAN}Checking Bun (optional)...${NC}"
if check_command bun; then
    echo -e "  ${GREEN}Found: Bun $(bun --version)${NC}"
    results[Bun]="pass"
else
    echo -e "  ${YELLOW}Not found (optional — needed for Aaron's web stack)${NC}"
    echo -e "  ${YELLOW}Install later with: curl -fsSL https://bun.sh/install | bash${NC}"
    results[Bun]="optional"
fi
echo ""

# ============================================
# 7. GitHub CLI (optional)
# ============================================
echo -e "${CYAN}Checking GitHub CLI (optional)...${NC}"
if check_command gh; then
    version=$(gh --version | head -1)
    echo -e "  ${GREEN}Found: $version${NC}"
    results[GH]="pass"
else
    echo -e "  ${YELLOW}Not found (recommended for git workflow)${NC}"
    case $INSTALLER in
        brew)   echo -e "  ${YELLOW}Install with: brew install gh${NC}" ;;
        apt)    echo -e "  ${YELLOW}Install with: sudo apt install gh${NC}" ;;
        dnf)    echo -e "  ${YELLOW}Install with: sudo dnf install gh${NC}" ;;
        *)      echo -e "  ${YELLOW}Install from: https://cli.github.com${NC}" ;;
    esac
    results[GH]="optional"
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
    status=${results[$tool]}
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
if $all_good; then
    echo -e "${GREEN}All set! You're ready to start the curriculum.${NC}"
    echo ""
    echo -e "${CYAN}Next steps:${NC}"
    echo "  1. Open VS Code in a project folder"
    echo "  2. Open a terminal (Ctrl+\` or Cmd+\`)"
    echo "  3. Type: claude"
    echo "  4. Follow the authentication prompts"
    echo "  5. Start Module 00: curriculum/00-getting-started/"
    echo ""
else
    echo -e "${YELLOW}Some items need attention — see details above.${NC}"
    echo -e "${YELLOW}After fixing, restart your terminal and run this script again.${NC}"
    echo ""
fi
