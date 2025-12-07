#!/bin/bash

PACMAN_FILE="packages_aur.txt"
AUR_FILE="packages_paru.txt"

# ——————————————————————————————
# Sprawdzanie plików paczek
# ——————————————————————————————
for FILE in "$PACMAN_FILE" "$AUR_FILE"; do
    if [ ! -f "$FILE" ]; then
        echo "Brak pliku $FILE!"
        exit 1
    fi
done

# ——————————————————————————————
# Skrypt musi być odpalony jako root
# ——————————————————————————————
if [ "$EUID" -ne 0 ]; then
    echo "Uruchom jako sudo."
    exit 1
fi

# Kiedy używasz sudo, normalny użytkownik siedzi w $SUDO_USER
USER_HOME="/home/$SUDO_USER"

echo "Instalacja pakietów systemowych..."
sleep 2

# ——————————————————————————————
# Instalacja paru (tylko jeśli brak)
# ——————————————————————————————
if ! command -v paru >/dev/null 2>&1; then
    echo "Installing paru..."
    pacman -Sy --needed --noconfirm base-devel git
    sleep 2

    sudo -u "$SUDO_USER" bash -c '
        git clone https://aur.archlinux.org/paru.git /tmp/paru
        cd /tmp/paru || exit 1
        makepkg -si --noconfirm
    '
else
    echo "paru już zainstalowany, pomijam instalację."
fi

# ——————————————————————————————
# Instalacja paczek pacman
# ——————————————————————————————
echo "Instaluję paczki oficjalne (pacman)..."
pacman -Sy --needed --noconfirm $(cat "$PACMAN_FILE")

# ——————————————————————————————
# Instalacja paczek AUR (paru)
# ——————————————————————————————
echo "Instaluję paczki AUR (paru)..."
sudo -u "$SUDO_USER" paru -Sy --needed --noconfirm $(cat "$AUR_FILE")

# ——————————————————————————————
# Flatpak + Flathub
# ——————————————————————————————
pacman -S --noconfirm flatpak

if ! flatpak remotes | grep -q "flathub"; then
    echo "Dodaję repo Flathub..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# ——————————————————————————————
# Kopiowanie configów
# ——————————————————————————————
echo
read -p "Przenieść configi? (y/n): " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo "Przenoszę configi..."

    # Poprawne kopiowanie
    cp -r .config/* "$USER_HOME/.config/"
    mkdir -p "$USER_HOME/Documents"
    cp -r Documents/* "$USER_HOME/Documents/"

    echo "Instaluję Zsh..."
    pacman -S --noconfirm zsh

    echo "Instaluję Oh-My-Zsh..."
    sudo -u "$SUDO_USER" sh -c '
        export RUNZSH=no
        export CHSH=no
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    '

    echo "Ustawiam Zsh jako domyślną powłokę..."
    chsh -s /bin/zsh "$SUDO_USER"

    echo "Podmieniam konfiguracje Zsh..."

    # Twój config .zshrc i .p10k.zsh
    cp -f home/.zshrc "$USER_HOME/.zshrc"
    cp -f home/.p10k.zsh "$USER_HOME/.p10k.zsh"

    # Jeśli masz własny OMZ z katalogu skryptu
    if [ -d "home/.oh-my-zsh" ]; then
        cp -r home/.oh-my-zsh/* "$USER_HOME/.oh-my-zsh/"
    fi

    # Naprawa praw
    chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME"

    echo "Zsh + OMZ skonfigurowane!"
else
    echo "Pomijam configi."
fi

echo "Gotowe!"

