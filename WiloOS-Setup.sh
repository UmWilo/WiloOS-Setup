#!/usr/bin/env bash
# ============================
# WiloOS Setup
# Versão: 1.0.0
# Fedora: 44
# Autor: Wilo
# ============================

WiloIF() {
    local mensagem="$1"
    local status="$2"

    if [[ "$status" -eq 0 ]]; then
        echo "✔ $mensagem"
    else
        echo "✖ $mensagem"
    fi
}

Wiloading() {
    local tempo="${1:-1}"
    local delay=0.1
    local spin='|/-\'
    local i=0
    local fim

    fim=$(awk -v t="$tempo" 'BEGIN { print systime() + t }')

    while awk -v now="$(date +%s.%N)" -v end="$fim" 'BEGIN { exit !(now < end) }'; do
        printf '\r[%c] Carregando...' "${spin:$i:1}"
        sleep "$delay"
        i=$(( (i + 1) % ${#spin} ))
    done

    printf '\r\033[K'
}
WiloRun() {
    local mensagem="$1"
    shift

    echo "▶ $mensagem"
    "$@"
    local pid=$!

    WiloIF "$mensagem" $status
    return $status
}

WiloText() {
    local mensagem="$1"
    local tempo="${2:-1}"

    echo "$mensagem"
    sleep "$tempo"
}
WiloText "Adquirindo permissões de superusuário..." 1

if sudo -v; then
    echo "✔ Permissões concedidas."
else
    echo "✖ Não foi possível obter permissões."
    exit 1
fi

echo "Iniciando a instalação do WiloOS"
Wiloading 5

# Easter egg
if (( RANDOM % 100 == 0 )); then
    echo "============================="
    echo -e "=          \e[1;31mERROR:\e[0m           ="
    echo "============================="
    echo "ocorreu um bug inesperado durante a inicialização do WiloOS"
    read -p "Deseja iniciar o WiloOS SHN? [Y/N]: " resposta

    if [[ "$resposta" =~ ^[Yy]$ ]]; then
        echo "Inicializando WiloOS SHN"
        WiloText "Inicializando WiloOS SHN" 3
        echo "ERRO: Um erro fatal ocorreu."
        echo "Processando"
        Wiloading 1
        echo "Destruindo hardware"
        Wiloading 1
        echo "0%"
        Wiloading 1
        echo "12%"
        Wiloading 1
        echo "34%"
        Wiloading 1
        echo "56%"
        Wiloading 1
        echo "67%"
        Wiloading 1
        echo "69%"
        Wiloading 1
        echo "78%"
        Wiloading 1
        echo "88%"
        Wiloading 1
        echo "90%"
        Wiloading 1
        echo "93%"
        Wiloading 1
        echo "95%"
        Wiloading 1
        echo "97%"
        Wiloading 1
        echo "99%"
        Wiloading 1
        echo "ERROR: Seu computador é uma bomba nuclear, fiquei com pena ;)"
        echo "Retomando a instalação do WiloOS"
        Wiloading 2
    else
        echo "Retomando a instalação do WiloOS"
        Wiloading 1
    fi
fi

echo "Atualizando sistema"
Wiloading 2
WiloRun "Atualizando sistema" sudo dnf update -y
WiloIF "Atualizando sistema" $?

echo "Instalando pacotes DNF"
WiloRun "Instalando pacotes DNF" sudo dnf install -y \
    git \
    zsh \
    fastfetch \
    btop \
    vlc \
    obs-studio \
    easyeffects \
    steam \
    gimp \
    krita \
    kdenlive \
    code
WiloIF "Instalando pacotes DNF" $?

echo "Garantindo que o Flathub esteja adicionado e instalando pacotes Flatpak"
WiloRun "Adicionando repositório Flathub" sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
WiloIF "Adicionando repositório Flathub" $?
WiloRun "Instalando pacotes Flatpak" flatpak install -y flathub \
    com.spotify.Client \
    io.github.Soundux \
    com.discordapp.Discord \
    org.vinegarhq.Sober \
    net.davidotek.pupgui2 \
    com.brave.Browser \
    com.github.ztefn.haguichi
WiloIF "Instalando pacotes Flatpak" $?

echo "Instalando ferramentas de customização KDE"
WiloRun "Instalando ferramentas de customização KDE" sudo dnf install -y \
    kvantum \
    qt5ct \
    qt6ct \
    papirus-icon-theme \
    sassc
WiloIF "Instalando ferramentas de customização KDE" $?

echo "Instalando Tela Circle Icons"
WiloRun "Instalando Tela Circle Icons" bash -c 'cd /tmp && git clone https://github.com/vinceliuice/Tela-circle-icon-theme.git && cd Tela-circle-icon-theme && ./install.sh -a'
WiloIF "Instalando Tela Circle Icons" $?

echo "Instalando Nordic KDE"
WiloRun "Instalando Nordic KDE" bash -c 'cd /tmp && rm -rf Nordic && git clone https://github.com/EliverLara/Nordic.git && cd Nordic/kde && ./install.sh'
WiloIF "Instalando Nordic KDE" $?

echo "Aplicando configurações KDE"
WiloRun "Aplicando configurações KDE" bash -c 'lookandfeeltool -a Nordic && kwriteconfig6 --file kdeglobals --group Icons --key Theme Tela-circle-dark && kwriteconfig6 --group KDE --key SingleClick false'
WiloIF "Aplicando configurações KDE" $?

echo "Reiniciando Plasma"
WiloText "Aguarde" 1
systemctl --user restart plasma-plasmashell

echo
echo "=================================="
echo " WiloOS Setup concluído!"
echo " Reinicie o PC para garantir tudo."
echo "=================================="
fastfetch

