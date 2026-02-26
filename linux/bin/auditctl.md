monitor current directory for deletions
```bash
sudo auditctl -a always,exit -F arch=b64 -S unlink -S unlinkat -F dir=$(pwd) -k file_delete
```

sudo apt-get install auditd
sudo service auditd status
sudo service audited start
sudo auditctl -l 


verify rules
```bash
sudo auditctl -l
```

remove rules
```bash
sudo auditctl -d always,exit -F arch=b64 -S unlink -S unlinkat -F dir=$(pwd) -k file_delete
```

view logs
```bash
sudo ausearch -k file_delete
```