# LINK TO THE BIN FOLDER
if [ ! -d /home/vagrant/bin ] 
then
  mkdir /home/vagrant/bin
fi

if [ ! -f /home/vagrant/etc/bash/.bashrc ] 
then 
  cp /home/vagrant/etc/bash/.bashrc /home/vagrant/.bashrc 
  . /home/vagrant/.bashrc
fi
