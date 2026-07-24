#!/usr/bin/env bash

#=================================
# WiloChoice-Setup                  
# Versão: 1.0.0                         
# Autor: UmWilo                                
# Copyright (c) 2026 UmWilo                                                               
#=================================

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "O que você deseja fazer?"
echo "1) Instalar (Setup)"
echo "2) Atualizar (Update)"
echo "3) Desinstalar (Uninstall)"
read -p "Escolha uma opção: " opcao

case "$opcao" in
    1) exec bash "$DIR/WiloOS-Setup.sh" ;;
    2) exec bash "$DIR/WiloUpdate.sh" ;;
    3) exec bash "$DIR/WiloUninstall.sh" ;;
    *) echo "Opção inválida."; exit 1 ;;
esac
