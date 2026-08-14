#!/usr/bin/env bash

#=================================
# WiloChoice-Setup                  
# Versão: 1.0.0                         
# Autor: UmWilo                                
# Copyright (c) 2026 UmWilo                                                               
#=================================

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "O que você deseja fazer?"
echo "1) Instalar (WiloOS-Setup)"
echo "2) Atualizar (WiloUpdates)"
echo "3) Desinstalar (WiloUninstall)"
echo "4) Preparar o ambiente Arch Linux (WiloConfigArch)"
echo "5) Sair"
read -p "Escolha uma opção: " opcao

case "$opcao" in
    1) exec bash "$DIR/WiloOS-Setup.sh" ;;
    2) exec bash "$DIR/WiloUpdates.sh" ;;
    3) exec bash "$DIR/WiloUninstall.sh" ;;
    4) exec bash "$DIR/WiloConfigArch.sh" ;;
    5) exit 0 ;;
    *) echo "Opção inválida."; exit 1 ;;
esac
