# 🏠 Home Hub Dashboard

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/version-1.0.0-green.svg)
![Status](https://img.shields.io/badge/status-active-success.svg)

Um dashboard leve, bonito e **totalmente editável via navegador** para organizar os serviços do seu HomeLab (Proxmox, Portainer, Home Assistant, Roteador, etc).

Sem banco de dados, sem Docker pesado. Apenas Python nativo e pura elegância com Glassmorphism.

---

## ✨ Funcionalidades

- 🎨 **Design Moderno:** Interface estilo Glassmorphism (vidro fosco).
- ✏️ **Edição ao Vivo:** Adicione, edite e remova atalhos direto pela interface.
- 🖼️ **Modo Híbrido:** Escolha entre abrir via **Iframe** (dentro do hub) ou **Nova Aba** (para sites com bloqueio de segurança, como o Proxmox).
- 🔍 **Seletor de Ícones:** Busca integrada de ícones FontAwesome.
- 💾 **Auto-Save:** As configurações são salvas automaticamente em um arquivo JSON local.
- 🌐 **Acesso Local:** Configura automaticamente o acesso via `http://hostname.local`.

---

## 🚀 Instalação Rápida

Rode este comando no terminal do seu **Proxmox (Shell)** ou em qualquer container **LXC (Debian/Ubuntu)**.

```bash
bash -c "$(curl -fsSL [https://raw.githubusercontent.com/luizfernando13/ProxmoxHUB/main/install.sh](https://raw.githubusercontent.com/luizfernando13/ProxmoxHUB/main/install.sh))"
