#!/bin/bash
# copy script
if [[ $EUID -ne 0 ]]; then
	   echo "This script must be run as root" 1>&2
	      exit 1
      fi
echo "Installieren der Pakete Curl und wget"
read -p "Soll git,curl und wget installiert werden? (j,J,y,Y/n,N) (any other key to exit " antwortgit
case $antwortgit in
j*|J*|y*|Y*)
apt-get -yes --force-yes install git curl wget zsh 
echo "Git, Curl und wget wurden erfolgreich installiert" ;;
n*|N*) echo "git curl und wget werden nicht installiert" ;;
*) echo "falsche Eingabe abbruch" 
exit 1 ;;
esac
cd /root/
read -p "soll myPreferences per git geclont werden? (j,J,yY/n,N) (any other key to exit) " antwortgitclone
case $antwortgitclone in
j*|J*|y*|Y*)
echo "hole config dateien via GIT"
git clone https://github.com/leg0as/myPreferences.git
echo "Done" ;;
n*|N*) echo "pyPreferences werden nicht geclont" ;;
*) echo "falsche Eingabe abbruch" 
exit 1 ;;
esac
read -p "Soll OH-MY-ZSH installiert werden? <j,J,y,Y/n,N) (any other key to exit) " antwortohmyzsh
case $antwortohmyzsh in
j*|J*|y*|Y*)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "Done" ;;
n*|N*) echo "OH-MY-ZSH wird nicht installiert" ;;
*) echo "falsche Eingabe abbruch" 
exit 1 ;;
esac

echo "Kopiervorgänge der Configdateien starten"
cd /root/myPreferences
cp tmux.conf /root/.tmux.conf
cp zshrc_root /root/.zshrc
cp vimrc /root/.zshrc
if [ -d /home/gunnar ] ; then
(
cp tmux.conf /home/gunnar/.tmux.conf
cp zshrc /home/gunnar/.zshrc
cp vimrc /home/gunnar/.vimrc
chown gunnar:gunnar /home/gunnar/.zshrc
chown gunnar:gunnar /home/gunnar/.vimrc
chown gunnar:gunnar /home/gunnar/.tmux.conf
)
fi
read -p "Sollen die Config Dateien auch in /etc/skel kopiert werden? (y/n)" skelant
case $skelant in
j*|J*|y*|Y*) 
if [ -d /etc/skel ] ; then
(
cp tmux.conf /etc/skel/.tmux.conf
cp zshrc /etc/skel/.zshrc
cp vimrc /etc/skel/.vimrc
)
fi ;;
n*|N*)
echo "Wird nicht kopiert" ;;
esac

echo "script abgeschlossen"
exit 0
