#!/bin/bash
echo "🚀 Starting VPS Auto-Installer for Email OSINT Tools"

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Install Python and pip
sudo apt install -y python3 python3-pip git

# Clone theHarvester tool
if [ ! -d "theHarvester" ]; then
    git clone https://github.com/laramies/theHarvester.git
fi

cd theHarvester || exit

# Install dependencies
pip3 install -r requirements.txt

echo "✅ Installation Complete!"
echo "You can now run: python3 theHarvester.py -d yahoo.com -b all"
