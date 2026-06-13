#!/bin/bash

# Deya v3.0 — One-Line Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/deya-ai/deya/main/install.sh | bash

set -e

DEYA_VERSION="3.0.0"
DEYA_DIR="${HOME}/.deya"
DEYA_REPO="https://github.com/deya-ai/deya.git"

echo "🌺 Deya v${DEYA_VERSION} Installer"
echo "================================"

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     PLATFORM=linux;;
    Darwin*)    PLATFORM=macos;;
    CYGWIN*|MINGW*|MSYS*) PLATFORM=windows;;
    *)          PLATFORM="unknown"
esac

echo "📦 Platform: ${PLATFORM}"

# Check if Docker is available
if command -v docker &> /dev/null && command -v docker-compose &> /dev/null; then
    echo "🐳 Docker detected — using containerized install"
    
    # Create directory
    mkdir -p "${DEYA_DIR}"
    cd "${DEYA_DIR}"
    
    # Download docker-compose.yml
    curl -fsSL "https://raw.githubusercontent.com/deya-ai/deya/main/docker-compose.yml" -o docker-compose.yml
    
    # Download .env.example
    curl -fsSL "https://raw.githubusercontent.com/deya-ai/deya/main/.env.example" -o .env
    
    echo ""
    echo "⚠️  Please edit ${DEYA_DIR}/.env with your API keys"
    echo ""
    read -p "Press Enter after editing .env..."
    
    # Start
    docker-compose up -d
    
    echo ""
    echo "✅ Deya is running!"
    echo "🌐 Open: http://localhost:3000"
    echo "📁 Data: ${DEYA_DIR}"
    
else
    echo "📥 Docker not found — using native install"
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        echo "❌ Node.js not found. Installing..."
        
        if [ "${PLATFORM}" = "linux" ]; then
            # Ubuntu/Debian
            if command -v apt &> /dev/null; then
                curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
                sudo apt install -y nodejs python3 python3-pip ffmpeg git
            # CentOS/RHEL/Fedora
            elif command -v yum &> /dev/null; then
                sudo yum install -y nodejs python3 python3-pip ffmpeg git
            # Arch
            elif command -v pacman &> /dev/null; then
                sudo pacman -S nodejs npm python python-pip ffmpeg git
            fi
            
        elif [ "${PLATFORM}" = "macos" ]; then
            if command -v brew &> /dev/null; then
                brew install node python ffmpeg git
            else
                echo "❌ Homebrew not found. Please install: https://brew.sh"
                exit 1
            fi
        fi
    fi
    
    # Check versions
    NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "${NODE_VERSION}" -lt 18 ]; then
        echo "❌ Node.js 18+ required. Current: $(node --version)"
        exit 1
    fi
    
    echo "✅ Node.js: $(node --version)"
    echo "✅ Python: $(python3 --version)"
    
    # Clone or update
    if [ -d "${DEYA_DIR}" ]; then
        echo "📂 Updating existing installation..."
        cd "${DEYA_DIR}"
        git pull origin main
    else
        echo "📂 Cloning repository..."
        git clone "${DEYA_REPO}" "${DEYA_DIR}"
        cd "${DEYA_DIR}"
    fi
    
    # Install dependencies
    echo "📦 Installing Node.js dependencies..."
    npm install
    
    echo "📦 Installing Python dependencies..."
    pip3 install -r requirements.txt
    
    # Setup
    echo "🔧 Running setup..."
    npm run setup
    
    # Create systemd service (Linux)
    if [ "${PLATFORM}" = "linux" ] && command -v systemctl &> /dev/null; then
        echo "📝 Creating systemd service..."
        
        sudo tee /etc/systemd/system/deya.service > /dev/null <<EOF
[Unit]
Description=Deya v3.0 AI Assistant
After=network.target

[Service]
Type=simple
User=${USER}
WorkingDirectory=${DEYA_DIR}
ExecStart=/usr/bin/node ${DEYA_DIR}/src/index.js
Restart=on-failure
RestartSec=10
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
EOF
        
        sudo systemctl daemon-reload
        sudo systemctl enable deya
        sudo systemctl start deya
        
        echo ""
        echo "✅ Deya installed as systemd service!"
        echo "🌐 Open: http://localhost:3000"
        echo "📁 Directory: ${DEYA_DIR}"
        echo ""
        echo "Commands:"
        echo "  sudo systemctl status deya"
        echo "  sudo systemctl restart deya"
        echo "  sudo journalctl -u deya -f"
        
    else
        # Start directly
        echo "🚀 Starting Deya..."
        npm start &
        
        echo ""
        echo "✅ Deya is running!"
        echo "🌐 Open: http://localhost:3000"
        echo "📁 Directory: ${DEYA_DIR}"
        echo ""
        echo "To run in background:"
        echo "  npm install -g pm2"
        echo "  pm2 start src/index.js --name deya"
    fi
fi

echo ""
echo "🎉 Installation complete!"
echo ""
echo "Next steps:"
echo "1. Edit ${DEYA_DIR}/.env with your API keys"
echo "2. Visit http://localhost:3000/health to verify"
echo "3. Start chatting with Deya!"
echo ""
echo "📖 Docs: https://docs.deya.ai"
echo "💬 Support: https://t.me/deya_ai"
echo ""
echo "🌺 Suksma for choosing Deya!"
