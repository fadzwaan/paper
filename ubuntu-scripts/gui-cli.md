
# boot into CLI
sudo systemctl set-default multi-user.target
sudo reboot

# boot into GUI 
sudo systemctl set-default graphical.target
sudo reboot

#start GUI withour reboot
sudo systemctl start display-manager
or
sudo systemctl isolate graphical.target

#start CLI without reboot
sudo systemctl isolate multi-user.target 

# check current default
systemctl get-default 


