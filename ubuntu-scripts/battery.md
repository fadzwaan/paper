#power reservation mode for Legion

#enabled 
echo 1 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:*/conservation_mode

#disabled, charge to 100%
echo 0 | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:*/conservation_mode

#check battery health 
upower -i /org/freedesktop/UPower/devices/battery_BAT0
