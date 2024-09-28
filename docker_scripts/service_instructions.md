gedit /etc/systemd/system/weeds.service (see slide notes for content)
systemctl daemon-reload
systemctl status weeds.service

debug>  journalctl _PID=9136
