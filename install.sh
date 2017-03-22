#!/bin/bash
# copy script
if [[ $EUID -ne 0 ]]; then
	   echo "This script must be run as root" 1>&2
	      exit 1
      fi
echo "Installieren der Pakete Curl und wget"
apt-get -yes --force-yes install git curl wget
echo "Done"
cd /root/
echo "hole Datein via git Clone"
git clone https://github.com/leg0as/myPreferences.git
echo "Done"
echo "installieren von OH-MY-ZSH via Curl..."
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "done"
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
if [ $skelant -eq "yes" ] : then 
	(
if [ -d /etc/skel ] ; then
(
cp tmux.conf /etc/skel/.tmux.conf
cp zshrc /etc/skel/.zshrc
cp vimrc /etc/skel/.vimrc
)
fi
)else (
echo "Wird nicht kopiert"
)
fi
echo "script abgeschlossen"
exit 0
