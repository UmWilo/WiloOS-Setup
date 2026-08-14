#!/usr/bin/env bash
#============================
# WiloUpdates-Setup
# Versão: 1.0.0
# Autor: UmWilo
# Copyright (c) 2026 UmWilo
#============================

source ./WiloFunctions.sh

echo "esta é a tela de atualização do WiloOS, deseja prosseguir? (s/n)"

read resposta

if [[ "$resposta" == "s" || "$resposta" == "S" ]]; then
    echo "Iniciando atualização do WiloOS..."
    # Comandos de atualização aqui
else
    echo "Atualização cancelada."
    exit 0
fi

WiloText "Adquirindo permissões de superusuário..." 1
WiloFunctionAleatoriaParaPegarPermissãoDeSuperUsuarioQueÉDesnecessariaPorqueSoUso1VezPorArquivoMasColoqueiPorqueEuQueroEPossoPorqueEuQueFizEsseCodigoAPrincipio()

echo "Iniciando a atualização do WiloOS"
echo "AVISO: Este script tentará atualizar todo o sistema, isso inclui também os programas ou configurações ja atualizados, e por isso, além de demorar um pouco... NAH, vai demorar bastante, existe a chance de dar algum erro, caso isso aconteça, por favor, tente novamente ou relate o erro para os desenvolvedores do WiloOS."

echo "Detectando gerenciador de pacotes..."
WiloGerenciadores()

WiloText "Verificando atualizações de sistema disponíveis..." 2

WiloRun "Atualizando o sistema" WiloSistemaUP
WiloRun "Atualizando o sistema (upgrade)" WiloSistemaUP


WiloRun "Atualizando pacotes flatpak" flatpak update -y \
    com.spotify.Client \
    io.github.Soundux \
    com.discordapp.Discord \
    org.vinegarhq.Sober \
    net.davidotek.pupgui2 \
    com.brave.Browser \
    com.github.ztefn.haguichi

WiloText "Checando motores" 2
WiloText "Enrequicendo os componentes com cesio C-137" 5
echo "Tudo Pronto!"
WiloText "Reiniciando Plasma" 3
systemctl --user restart plasma-plasmashell

echo
echo "=================================="
echo " Atualização concluida!"
echo " Reinicie o PC para garantir tudo."
echo "=================================="
fastfetch
