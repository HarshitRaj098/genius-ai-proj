#!/bin/bash

# -------------------------------
# Simple deployment script
# -------------------------------

# 1. Variables
PROJECT_DIR="$(pwd)"          # Current directory
DEPLOY_DIR="/var/www/genius-ai" # Target deployment directory (adjust to your server setup)
INDEX_FILE="index.html"

# 2. Check if index.html exists
if [ ! -f "$PROJECT_DIR/$INDEX_FILE" ]; then
    echo "Error: $INDEX_FILE not found in $PROJECT_DIR"
    exit 1
fi

# 3. Create deployment directory if it doesn't exist
if [ ! -d "$DEPLOY_DIR" ]; then
    echo "Creating deployment directory at $DEPLOY_DIR"
    sudo mkdir -p "$DEPLOY_DIR"
fi

# 4. Copy files
echo "Copying files to $DEPLOY_DIR ..."
sudo cp -r "$PROJECT_DIR/"* "$DEPLOY_DIR/"

# 5. Set permissions
sudo chown -R $USER:$USER "$DEPLOY_DIR"
sudo chmod -R 755 "$DEPLOY_DIR"

# 6. Restart web server (optional, assuming Apache)
if command -v systemctl &> /dev/null; then
    echo "Restarting Apache server..."
    sudo systemctl restart apache2
fi

echo "Deployment complete! Access your chatbot at http://<your-server-ip>/genius-ai/"
