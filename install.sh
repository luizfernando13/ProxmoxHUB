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

# 1. Dependências (ADICIONEI O AVAHI-DAEMON AQUI)
# O avahi-daemon permite usar http://hostname.local
apt-get update && apt-get install -y python3 curl avahi-daemon

# 2. Criar diretório
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# 3. Baixar arquivos
echo "Baixando arquivos..."
curl -fsSL "$BASE_URL/index.html" -o index.html
curl -fsSL "$BASE_URL/server.py" -o server.py

# 4. Config (Mantém a existente)
if [ ! -f "config.json" ]; then
    echo "Baixando configuração padrão..."
    curl -fsSL "$BASE_URL/config.json" -o config.json
fi

# 5. Serviço Systemd
echo "Configurando serviço..."
cat <<EOF > /etc/systemd/system/hub-dashboard.service
[Unit]
Description=Hub Dashboard Server
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=$INSTALL_DIR
# Python na porta 80 precisa de root (o que já estamos usando)
ExecStart=/usr/bin/python3 server.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 6. Ativar
systemctl daemon-reload
systemctl enable --now hub-dashboard

# 7. Mensagem Final Inteligente
MY_HOSTNAME=$(hostname)
MY_IP=$(hostname -I | awk '{print $1}')

echo -e "${GREEN}>>> Sucesso!${NC}"
echo -e "Acesse via IP:   http://$MY_IP"
echo -e "Acesse via Nome: http://$MY_HOSTNAME.local"
