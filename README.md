# WiloOS-Setup
Meu primeiro script pessoal para automatizar a instalação basica no Fedora KDE.

# Este script foi feito para minhas preferências pessoais. Use por sua conta e risco.

## Recursos

- Atualiza o sistema.
- Instala pacotes DNF.
- Instala aplicativos Flatpak.
- Instala temas (Nordic e Tela Circle).
- Aplica configurações do KDE.
- Possui um pequeno easter egg.

## Requisitos

- linux (fedora KDE plasma)
- Gerenciador DNF
- Flapak
- Conexão com a internet
- Permissões de superusuário (`sudo`)

## Compatibilidade
-Testado no Fedora 44 KDE Plasma.

-Pode funcionar em outras versões do Fedora KDE, no entanto não foi testado.

-Não é compatível com Ubuntu/Debian sem modificações, pois usa `dnf`.

## Como usar

```bash
git clone https://github.com/UmWilo/WiloOS-Setup.git
cd WiloOS-Setup
chmod +x WiloOS-Setup.sh
./WiloOS-Setup.sh
