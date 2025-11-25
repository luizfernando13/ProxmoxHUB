#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0m'

# --- SUAS CONFIGURAÇÕES ---
GITHUB_USER="luizfernando13"
GITHUB_REPO="ProxmoxHUB"
BASE_URL="https://raw.githubusercontent.com/$GITHUB_USER/$GITHUB_REPO/main"
INSTALL_DIR="/opt/hub-dashboard"
# --------------------------

echo -e "${GREEN}>>> Instalando Hub Dashboard...${NC}"

# 1. Dependências
apt-get update && apt-get install -y python3 curl

# 2. Criar diretório
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# 3. Baixar arquivos principais (Sempre atualiza o código)
echo "Baixando Core..."
curl -fsSL "$BASE_URL/index.html" -o index.html
curl -fsSL "$BASE_URL/server.py" -o server.py

# 4. Baixar Config (SÓ SE NÃO EXISTIR, para não apagar suas edições)
if [ -f "config.json" ]; then
    echo "Configuração existente detectada. Mantendo seus dados."
else
    echo "Baixando configuração padrão..."
    curl -fsSL "$BASE_URL/config.json" -o config.json
fi

# 5. Criar Serviço Systemd
echo "Configurando serviço..."
cat <<EOF > /etc/systemd/system/hub-dashboard.service
[Unit]
Description=Hub Dashboard Server
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=$INSTALL_DIR
ExecStart=/usr/bin/python3 server.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 6. Ativar
systemctl daemon-reload
systemctl enable --now hub-dashboard

echo -e "${GREEN}>>> Sucesso! Acesse em: http://$(hostname -I | awk '{print $1}'):8090${NC}"
