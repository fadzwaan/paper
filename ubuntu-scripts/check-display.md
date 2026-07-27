lspci -k | grep -A3 VGA
sudo apt install xserver-xorg-video-nouveau
lsmod | grep -E "i915|amdgpu|noueau|nvidia"
ls -l /dev/dri
lspci | grep -Ei "vga|3d|display"
