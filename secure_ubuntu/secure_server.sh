#!/bin/bash

# locakdown ssh
echo "Disabling root login in ssh"
if [ ! -f /etc/ssh/sshd_config ]; then
	echo "sshd config file not found... exiting script."
	exit 1
fi

hasPermitRootLogin=$(egrep -e '^[# ]*PermitRootLogin (yes|no)' /etc/ssh/sshd_config) 
if [[ $hasPermitRootLogin != "" ]]; then
	sed 's/^[# ]*PermitRootLogin yes/PermitRootLogin no/im' /etc/ssh/sshd_config > /etc/ssh/sshd_config.tmp 
	mv /etc/ssh/sshd_config.tmp /etc/ssh/sshd_config
else
	echo "PermitRootLogin no" >> /etc/ssh/sshd_config
fi

service ssh restart
echo "done"

# Config iptables
echo "Configuring iptables..."
if [ ! -d /etc/network ]; then
	echo "netork directory not found, exiting."
	exit 1
fi

mv iptablessave /etc/network/if-post-down.d/
mv iptablesload /etc/network/if-pre-up.d/
mv iptables.rules /etc/network/
mv iptables.downrules /etc/network/ 
chown root:root /etc/network/if-post-down.d/iptablessave
chown root:root /etc/network/if-pre-up.d/iptablesload
chown root:root /etc/network/iptables.rules
chown root:root /etc/network/iptables.downrules
chmod 555 /etc/network/if-post-down.d/iptablessave
chmod 555 /etc/network/if-pre-up.d/iptablesload
chmod 600 /etc/network/iptables.rules
chmod 600 /etc/network/iptables.downrules
iptables-restore < /etc/network/iptables.rules
echo "Done."

# setup rsyslog
echo "configuring rsyslog for iptables..."
if [[ $(service rsyslog status) == *'running'* ]]; then
	mv ./10-iptables.conf /etc/rsyslog.d/
	chown root:root /etc/rsyslog.d/10-iptables.conf
	chmod 644 /etc/rsyslog.d/10-iptables.conf 
	service rsyslog restart
	echo "Done."
else
	echo "rsyslog not running, rsyslog config aborted."
	echo "Logging is not configured for iptables. You need to do this manually."
fi

exit 0
