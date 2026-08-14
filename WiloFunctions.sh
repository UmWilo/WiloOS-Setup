#bumdia

#============================
# WiloFunctions.sh
# Versão: 1.0.0
# Autor: UmWilo
# Copyright (c) 2026 UmWilo
#============================
# Todas as Functions, recomendo você não editar nada muito menos renomear e pior
# ainda tirar desta pasta ja que isso pode quebrar o script pois usa caminho relativo
# mas se você quiser editar fique a vontade, igual ao linux, aqui tu que manda!
#============================

WiloFunctionAleatoriaParaPegarPermissaoDeSuperUsuarioQueEDesnecessariaPorqueSoUso1VezPorArquivoMasColoqueiPorqueEuQueroEPossoPorqueEuQueFizEsseCodigoAPrincipio(){
 if sudo -v; then
     echo "✔ Permissões concedidas."
    else
        echo "✖ Não foi possível obter permissões."
        exit 1
fi
}

WiloDeteccaoDeDesktop() {
    desktop="${XDG_CURRENT_DESKTOP:-$XDG_SESSION_DESKTOP}"

    if [[ -n "$desktop" ]]; then
        desktop=$(echo "$desktop" | tr '[:upper:]' '[:lower:]')
        echo "✔ Desktop detectado: $desktop"
    else
        echo "✖ Não foi possível detectar o desktop."
        exit 1
    fi
}

WiloGerenciadores() {
    export GERENCIADOR
    if command -v dnf &> /dev/null; then
        GERENCIADOR="dnf"
    elif command -v apt &> /dev/null; then
        GERENCIADOR="apt"
    elif command -v pacman &> /dev/null; then
        GERENCIADOR="pacman"
    else
        echo "✖ Gerenciador de pacotes não suportado."
        exit 1
    fi

    echo "Gerenciador detectado: $GERENCIADOR"
}

WiloPacotes() {
    case "$GERENCIADOR" in
        dnf)    sudo dnf install -y "$@" ;;

        apt)    sudo apt install -y "$@" ;;

        pacman) sudo pacman -S --needed --noconfirm "$@" ;;
    esac
}

WiloSistemaUP() {
    case "$GERENCIADOR" in
        dnf)
            sudo dnf update -y
            ;;
        apt)
            sudo apt update -y && sudo apt upgrade -y
            ;;
        pacman)
            sudo pacman -Syu --noconfirm
            ;;
    esac
 else
    echo "Gerenciador inválido."
    return 1
    ;;
}

WiloCheat() {
    local cpu ram gpu distro script_path
    cpu=$(lscpu | grep -m1 -E "Nome do mod|Model name" | sed 's/^[^:]*: *//')
    gpu=$(lspci | grep -i -m1 'vga\|3d' | sed 's/^.*: //')
    ram=$(free -h | awk '/Mem:/ {print $2}')
    distro=$(cat /etc/fedora-release 2>/dev/null || uname -o)
    script_path="${BASH_SOURCE[0]}"

    echo "Componentes detectados:"
    echo "  Sistema: $distro"
    echo "  CPU: $cpu"
    echo "  GPU: $gpu"
    echo "  RAM: $ram"

    # Remove infos antigas (se já existirem de uma execução anterior)
    sed -i '/^# Sistema:/d; /^# CPU:/d; /^# GPU:/d; /^# RAM:/d' "$script_path"

    # Insere as infos novas logo após "# Copyright (c) 2026 UmWilo"
    sed -i "/^# Copyright (c) 2026 UmWilo/a # Sistema: ${distro}\n# CPU: ${cpu}\n# GPU: ${gpu}\n# RAM: ${ram}" "$script_path"

    WiloIF "Componentes registrados no cabeçalho" $?
}

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
    local status=$?

    WiloIF "$mensagem" $status
    return $status
}

WiloText() {
    local mensagem="$1"
    local tempo="${2:-1}"

    echo "$mensagem"
    sleep "$tempo"
}

