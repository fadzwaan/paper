./wacli sync --follow

/wacli send text --to 601XXXXXXXX --message "test cli"

while true;do clear; ./wacli messages list --limit 30 ; sleep 2; done

