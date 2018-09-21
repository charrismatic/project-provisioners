#!/bin/bash

MAILPATH=mailbox

sudo maildirmake.dovecot /etc/skel/$MAILPATH
sudo maildirmake.dovecot /etc/skel/$MAILPATH/.Drafts
sudo maildirmake.dovecot /etc/skel/$MAILPATH/.Sent
sudo maildirmake.dovecot /etc/skel/$MAILPATH/.Trash
sudo maildirmake.dovecot /etc/skel/$MAILPATH/.Templates 

sudo cp -r /etc/skel/Maildir /home/$USER/
sudo chown -R $USER:$USER /home/$USER/$MAILPATH
sudo chmod -R 700 /home/$USER/$MAILPATH
sudo adduser $USER mail

echo "export MAIL=~/$MAILPATH" | sudo tee -a /etc/bash.bashrc | sudo tee -a /etc/profile.d/mail.sh

unset MAILPATH
