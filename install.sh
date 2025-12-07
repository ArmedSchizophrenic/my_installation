PKG_FILE="packages.txt"

if [ ! -f "$PKG_FILE" ]; then
  echo "Brak pliku $PKG_FILE!"
  exit 1
fi

if [ "$EUID" -ne 0 ]; then
  echo "sudo zjebie"
  exit 1
fi

echo "Installig packages ... " 

wait 3


echo "Instaluję paru..."
pacman -Sy --needed --noconfirm base-devel git

wait 3

sudo -u $SUDO_USER bash -c '
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru
    makepkg -si --noconfirm
    '

    echo "instalowanie z pliku $PKG_FILE"
sudo -u $SUDO_USER paru -Sy --needed --noconfirm $(cat "$PKG_FILE")

 sudo pacman -S --noconfirm flatpak

 if ! flatpak remotes | grep -q "flathub"; then
    echo "Dodaję repozytorium Flathub..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

FLATPAK_PACKAGES=(
  org.freedesktop.Platform.GL.default
  org.freedesktop.Platform.GL.default
  org.freedesktop.Platform.codecs-extra
  org.gnome.Platform.Locale
  org.gnome.Platform
  org.prismlauncher.PrismLauncher
  org.gimp.Gorg.vinegarhq.Sober
)

for package in "${FLATPAK_PACKAGES[@]}"; do
    echo "Instaluję $package..."
    flatpak install -y flathub "$package"
done


read -p "przeniesc configi? (y/n): " answer

if [[ "$answer" == [Yy] ]]; then
    echo "ok..."
    cp -r .config/* ~/ aonfig/
    cp .zshrc ~/
    cp .p10k.zsh ~/
else
    echo "lol."
    exit 1
fi



echo "Gotowe!"

