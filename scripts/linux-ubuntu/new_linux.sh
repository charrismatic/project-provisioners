# UPDATE LINUX VERSION FIRST 
sudo -i apt-get update && \
  apt-get upgrade && \ 
  apt full-upgade && \
  apt autoremove &&
  apt autoclean;

#--------------------
#    REMOVE JUNK
#--------------------
## ANTIQUATED DESKTOP GAMES 
sudo apt-get remove gnome-mines gnome-mahjongg gnome-sudoku aisleriot

## NON-EXISTANT HARDWARE UTILITIES 
sudo apt-get remove simple-scan

## BETTER ALTERNATIVES EXIST 
sudo apt-get remove libreoffice-draw libreoffice-math

## REMOVE SELLOUT ADVERTISEMENTS 
sudo rm /usr/share/applications/ubuntu-amazon-default.desktop 
sudo rm /usr/share/ubuntu-web-launchers/amazon-launcher 
sudo rm /usr/share/applications/com.canonical.launcher.amazon.desktop

## INSTALL PREFERED TOOLS 
sudo apt-get install git openvpn nano htop htop tree curl; 
# gvim
  
cd ~/
#git clone https://github.com/mjharris2407/00-dev ~/00_dev 
#git clone https://github.com/mjharris2407/00-data ~/00_dev/data
#git clone https://github.com/mjharris2407/00-dark-minimal-ui ~/00_themes/atom/00-dark-minimal-ui
#git clone https://github.com/mjharris2407/00-dark-minimal-syntax ~/00_themes/atom/00-dark-minimal-syntax


# ATOM 
cd ~/Downloads

#https://atom.io/download/deb
wget https://atom-installer.github.com/v1.24.0/atom-amd64.deb && \
sudo dpkg -i atom-*.deb


sudo apt-get install gconf2 libpython-stdlib python python-minimal python2.7 python2.7-minimal python-tk binfmt-support


# CHROME 
sudo apt-get install libxss1 libappindicator1 libindicator7 gconf-service gconf-service-backend gconf2-common libgconf-2-4
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb

# SNAP PACKAGES
# -------------
## SPOTIFY 
sudo -i snap install spotify

## BRAVE 
  #sudo -i snap install brave
sudo dpkg -i apt-get install gawk libsigsegv
wget https://github.com/brave/browser-laptop/releases/download/v0.18.36dev/brave_0.18.36_amd64.deb 
sudo dpkg -i brave_0.18.36_amd64.deb

## MYSQL-WORKBENCH
## PHP 
sudo apt install php7.2-cli
sudo apt-get install sqllite sqlitebrowser


## NPM
## COMPOSER  
## DOCKER 
## JAVA 
## APPS 
sudo apt-get install tilix

# CONFIGURE UBUNTU 

# PERSONALIZATION 
# ---------------
## TWEAKS AND CONFIG TOOLS 
sudo apt-get install dconf-editor dconf-tools gnome-tweak-tool;

## THEMES AND VISUAL APPEAL
sudo apt-get install gnome-extra-icons 


# mkdir ~/2_etc/fonts
# wget http://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2
# tar -xf dejavu-fonts-ttf-2.37.tar.bz2


## https://github.com/adapta-project/adapta-gtk-theme 
# git clone https://github.com/adapta-project/adapta-gtk-theme
# ```
# sudo apt-get install libglib2.0-dev libsass0 libxml2-utils pkg-config sassc # autoconf automake libgdk-pixbuf2.0-dev inkscape
# ./autogen.sh --enable-parallel --enable-gtk_next --enable-chrome-legacy --enable-plank
# make
# sudo make install
# ```



# https://github.com/EliverLara/Ant
# wget https://github.com/EliverLara/Ant/archive/v1.1.0.tar.gz

### papirus
# sudo add-apt-repository ppa:papirus/papirus
# sudo apt update && sudo apt install papirus-icon-theme

### paper
# sudo add-apt-repository ppa:snwh/pulp
# sudo apt-get update && sudo apt-get install paper-icon-theme paper-cursor-theme paper-gtk-theme

### flat-remix
# sudo add-apt-repository ppa:daniruiz/flat-remix
# sudo apt-get update
# sudo apt-get install flat-remix-gnome

# Arch based distributions

#--------------------
#    GNOME  
#--------------------

## AVAILABLE IN APT 
# sudo apt-get install chrome-gnome-shell \
# gnome-shell-extension-dashtodock
# gnome-shell-extension-move-clock
# gnome-shell-extension-multi-monitors
# gnome-shell-extension-pixelsaver
# gnome-shell-extension-remove-dropdown-arrows 
# gnome-shell-extension-shortcuts
# gnome-shell-extension-dash-to-panel
# gnome-shell-extension-ubuntu-dock 
# gnome-shell-extension-tilix-dropdown

## 2. GNOME THEMES
# sudo apt-get install \
#   arc-theme \
#   numix-icon-theme \
#   numix-gtk-theme
#   human-theme
#   gnome-icon-theme \
#   gnome-icon-theme-extras \


# DESIGN 
## Image Editing  
# gimp 
# inkscape  
# darktables 



#--------------------
#    DOCUEMNTS 
#--------------------

## Markdown

### Typora - Editor 
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
sudo add-apt-repository 'deb http://typora.io linux/'
sudo apt-get update && sudo apt-get install typora


## Latex 


## GEDIT 
sudo apt-get install gedit-plugin-find-in-files gedit-plugin-git gedit-plugin-join-lines gedit-plugin-multi-edit gedit-plugins gedit-plugins-common gedit-plugin-smart-spaces gedit-plugin-word-completion gedit-plugin-commander gedit-developer-plugins gedit-plugin-bookmarks gedit-plugin-character-map gedit-plugin-color-picker gedit-plugin-color-schemer

# IF !NOT /data mounted 
# mkdir /data
# mkdir /data/plugins
# mkdir /data/plugins/gedit 

#git clone https://github.com/dinkel/gedit-whitespace-remover /data/plugins/gedit/gedit-whitespace-remover
#git clone https://github.com/jpfleury/open-uri-context-menu /data/plugins/gedit/open-uri-context-menu
#git clone https://github.com/dariuskl/line-mover
#git clone https://github.com/JacekPliszka/gedit-folding
#git clone https://github.com/GNOME/gedit-plugins/blob/master/help/C/draw-spaces.page
#git clone https://github.com/mig/gedit-themes/data/themes/gedit/mig_gedit-themes
#git clone https://github.com/trusktr/gedit-color-schemes/data/themes/gedit/trusktr_gedit-color-schemes

#cp /data/themes/gedit/mig_gedit-themes/*.xml ~/.local/share/gedit/styles/

# MULTIMEDIA 
#vlc

# COMMUNICATION
## slack 
## mattermost 
## messenger client 

#mkdir /data/apps/caprine-messenger
#wget https://github.com/sindresorhus/caprine/releases/download/v2.9.0/caprine-2.9.0-x86_64.AppImage -o /data/apps/caprine-messenger/caprine-2.9.0-x86_64.AppImage
#chmod +X /data/apps/caprine-messenger/caprine-2.9.0-x86_64.AppImage


# DEVOPS & SECURITY 
wget https://github.com/keeweb/keeweb/releases/download/v1.6.3/KeeWeb-1.6.3.linux.x64.deb 

sudo apt-get install libgconf2-4 
sudo dpkg -i KeeWeb-1.6.3.linux.x64.deb 

mkdir ~/apps
cd ~/apps

# ELECTRON BASED GUI SYSTEM MONITORING AND CLEANUP TOOL
#wget https://github.com/oguzhaninan/Stacer/releases/download/v1.0.9/Stacer-x64.AppImage



# NOTES 
# nix-note
snap install gitkraken --classic

sudo apt-get install apparmor-utils


# RUBY APPS 
sudo apt-get install ruby 

# COMMAND LINE MARKDOWN READER 
gem install mdless


# TASK MANAGEMENT AND PROJECT TOOLS 
# ---------------------------------
## TASKWARRIOR SUITE
sudo apt-get install taskwarrior bugwarrior timewarrior vit tasksh 


# ccze
#diffutils
#fsdupes
##fslint
#timewarrior
