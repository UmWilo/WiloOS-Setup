# WiloOS-Setup
Meu primeiro script pessoal para automatizar a instalação basica no Fedora KDE (que se tornou um mega-projeto).

# Este script foi feito para minhas preferências pessoais. Use por sua conta e risco.

## Recursos

- atualiza o sistema
- instala pacotes
- instala 1 interface grafica dentre 3: KDE PLASMA, XFCE e HYPRLAND
- instala pacotes flatpak e atualiza ou garante o flathub
- instala temas e arquivos de customização
- configura uma pequena parte do ARCH linux (se necessario)
- instala 1gb de wallpapers

## Requisitos

- Linux
- Flatpak
- Conexão com a internet
- Permissões de superusuário (`sudo`)

## Compatibilidade

- Funciona em sistemas que utilizam os gerenciadores de instalação: DNF, APT e PACMAN


## Como usar

```bash
git clone https://github.com/UmWilo/WiloOS-Setup.git
cd WiloOS-Setup
chmod +x WiloChoice.sh
./WiloChoice.sh
