#!/bin/bash
#
# This quickly secures a fresh ubuntu install
# Created script from: http://bit.ly/1XaKzBd

#######################################
# Uncomment, update, or append property:value pair in file 
# Globals:
#   None
# Arguments:
#   prop - property to change
#   val - new value for property
#   file - filename to update
# Returns:
#   None
#######################################
change_prop() {
        prop="$1"
        val="$2"
        file="$3"
        is_commented=$(egrep "^#*[[:space:]]*$prop$val[[:space:]]*$" "$file")
        has_prop=$(egrep "^$prop\b" "$file")
        if [[ $is_commented != "" ]]; then
                sed -i.tmp "s/^#*[ ]*${prop}${val}.*$/${prop}${val}/im" "$file"
                rm "$file.tmp"
        elif [[ $has_prop != "" ]]; then
                sed -i.tmp "s/^$prop\b.*$/${prop}${val}/im" "$file"
                rm "$file.tmp"
        else
                echo "$prop$val" >> "$file"
        fi
}

#######################################
# SSH
#######################################
echo "Disabling root login in ssh..."
if [ ! -f /etc/ssh/sshd_config ]; then
        echo "sshd config file not found... exiting script."
        exit 1
fi

change_prop PermitRootLogin " no" /etc/ssh/sshd_config

echo "Disabling password login to ssh..."
change_prop PasswordAuthentication " no" /etc/ssh/sshd_config

service ssh restart
echo "done"

#######################################
# /etc/sysctl.conf 
#######################################
echo "Updating /etc/sysctl.conf..."
if [ ! -f /etc/sysctl.conf ]; then
        echo "/etc/sysctl.conf not found, exiting."
        exit 1
fi

change_prop "net.ipv4.conf.default.rp_filter" "=1" /etc/sysctl.conf
change_prop "net.ipv4.conf.all.rp_filter" "=1" /etc/sysctl.conf
change_prop "net.ipv4.conf.all.accept_redirects" " = 0" /etc/sysctl.conf
change_prop "net.ipv6.conf.all.accept_redirects" " = 0" /etc/sysctl.conf
change_prop "net.ipv4.conf.all.send_redirects" " = 0" /etc/sysctl.conf
change_prop "net.ipv4.conf.all.accept_source_route" " = 0" /etc/sysctl.conf
change_prop "net.ipv6.conf.all.accept_source_route" " = 0" /etc/sysctl.conf

echo "done." 


#######################################
## FIREWALL
#######################################
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable
ufw status

exit 0
