#
# Regular cron jobs for the gecko-driver package
# See dh_installcron(1) and crontab(5).
#
0 4	* * *	root	[ -x /usr/bin/gecko-driver_maintenance ] && /usr/bin/gecko-driver_maintenance
