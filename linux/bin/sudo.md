set sudo without password

Use this command and enter password normally
```
$ sudo visudo
```

Put this line in and save changes
```
$ hostname ALL=(ALL) NOPASSWD: ALL
```
