#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}>>> Desinstalando Hub Dashboard...${NC}"

# Parar o serviço se estiver rodando
if systemctl is-active --quiet hub-dashboard; then
    systemctl stop hub-dashboard
fi

# Desativar o serviço
systemctl disable hub-dashboard 2>/dev/null

# Remover arquivos do sistema
rm -f /etc/systemd/system/hub-dashboard.service
systemctl daemon-reload

# Remover a pasta do projeto
rm -rf /opt/hub-dashboard

echo -e "${GREEN}>>> Removido com sucesso!${NC}"
echo "Nota: Pacotes como python3 e avahi-daemon foram mantidos para não quebrar o sistema."
