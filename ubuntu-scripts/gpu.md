lspci | grep -Ei "vga|3d"

nvidia-smi

ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

fwupdmgr get-devices
fwupdmgr refresh
fwupdmgr get-updates
sudo fwupdmgr update

```python
import torch

print(torch.cuda.is_available())
print(torch.cuda.get_device_name(0))
```
