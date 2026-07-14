# In archinstall:
#     Filesystem:
#         - btrfs snapshots
#         - Default layout
#         - Standard compression
#         - snapper
#     Profile:
#         - sway
#     Audio:
#         - Pipewire
#     Additional packages:
#         - git stow gdm # gvim later, causes break due to conflict with vim
#     Set timezone
#
# In minimal arch install:
#
#     # if you forgot to do it
#     sudo pacman -R vim
#     sudo pacman -S gvim
#
#     git clone https://github.com/thadryanjs/dotfiles.git ~/.dotfiles
#     # you should have this guide locally now
#
#     git clone https://aur.archlinux.org/yay.git
#     cd yay
#     makepkg -si
#     cd
#
#     git clone https://aur.archlinux.org/decman.git
#     cd decman
#     makepkg -si
#     cd
#
#     rm -rf yay/ decman/
#
#     cd .dotfiles
#     stow . --adopt
#     git reset *
#
#     sh .scripts/import-spotify-gpg-keys.sh
#
#     sudo decman --source ~/.dotfiles/.config/decman/arch-sway-minignome.py
#
#     sh ~/.dotfiles/.config/decman/bootstrap-decman-system.sh
#
# ! The first time, see what decman is going to delete and add those packages to the base packages

chmod -u+xrw /home/thadryan/.dotfiles/.config/sway/manage-closed-lid-refresh.sh

sudo systemctl start gdm.service
sudo systemctl enable gdm.service

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

sudo systemctl stop pipewire.socket pipewire.service
sudo systemctl start pipewire.socket pipewire.service

sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg

git config --global user.email "thadryan@protonmail.com"
git config --global user.name "thadryanjs"

# did have to do manually for some reason
cd
cd ~/.dotfiles
git remote set-url origin git@github.com:thadryanjs/dotfiles.git
cd

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# to install plugins
# ctrl-b I, or strl-space if my config is there

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

wget https://installer.tresorit.com/tresorit_installer.run
chmod -u+xrw tresorit_installer.run
./tresorit_installer.run
rm tresorit_installer.run


mkdir ~/Downloads/MarkDownload

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DejaVuSansMono.zip
unzip DejaVuSansMono.zip
sudo mkdir ~/.local/share/fonts/
sudo cp DejaVuSansMNerdFont*.ttf ~/.local/share/fonts
rm DejaVuSansMNerdFont*.ttf
rm DejaVuSansMono.zip LICENSE.txt README.md


# Open Neovim:
#     - Run :COQdeps
#     - Run :COQsnips compile
#     - Mason to install LSPs if desired.
#
# Get vivaldi set up
#
# Set up git keys:
#     ssh-keygen -t ed25519 -C 'thadryan@protonmail.com'
#     cat ~/.ssh/id_ed25519.pub
#
# Set boot order with efibootmgr
#     efibootmgr
#     see which is current, like 001A, then run:
#     sudo efibootmgr -o 001A,0001,0000,0010,0011,0012,0013,0014,0018,0019,001B,001C,001D,001E,001F,0020,0021,0026,0003
#
# Discord
#    Linux settings > disable open on start and minimize to tray
#

