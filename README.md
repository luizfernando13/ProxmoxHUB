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
bash -c "$(curl -fsSL https://raw.githubusercontent.com/luizfernando13/ProxmoxHUB/main/install.sh)"
```

> **O que o script faz?**
> 1. Instala dependências leves (`python3`, `avahi-daemon`).
> 2. Baixa os arquivos do painel para `/opt/hub-dashboard`.
> 3. Cria um serviço `systemd` para iniciar automaticamente com o sistema.
> 4. Configura a porta `80` e o DNS local.

---

## 🖥️ Como Acessar

Após a instalação, acesse pelo navegador usando o IP da máquina ou o nome do host (se sua rede suportar mDNS):

- **Via IP:** `http://192.168.x.x`
- **Via Nome:** `http://hostname.local` (ex: `http://hub.local`)

### ⚙️ Como Configurar

1. Clique no botão **Editar** no canto superior direito.
2. Clique no card **Adicionar (+)**.
3. Preencha o Nome e a URL.
4. Escolha um ícone na lista ou digite o nome (ex: `docker`).
5. **Dica:** Se o site ficar em branco, ative a opção **"Abrir em Nova Aba"**.

---

## 🗑️ Desinstalação

Caso queira remover completamente o Hub do seu sistema, rode o comando abaixo:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/luizfernando13/ProxmoxHUB/main/uninstall.sh)"
```

---

## 🛠️ Estrutura de Arquivos

Toda a instalação fica localizada em `/opt/hub-dashboard`:

| Arquivo | Função |
| :--- | :--- |
| `server.py` | Servidor web Python que gerencia as requisições e salva o JSON. |
| `index.html` | O front-end com todo o design e lógica JS. |
| `config.json` | Onde seus links são salvos. Você pode fazer backup deste arquivo. |

---

Desenvolvido para a comunidade HomeLab. Sinta-se à vontade para contribuir!
