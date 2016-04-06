# Ubuntu_init_tools
Some basic scripts I use to setup fresh ubuntu VMs. 

These are some basic scripts I use to setup fresh ubuntu VMs on Digital Ocean. 

The primary one is secure_server.sh.   This sets up *basic* security.  Further steps need to be taken to further secure your server depending on the applications you use.  This also does not do things like setup passwordless ssh logins using keys. 

What the script does do is:

1. Disable root logins on SSH
2. install fail2ban with some settings that help shut down the brute force attacks every server gets. 
3. Edit sysctl.conf to help prevent other well-known attacks
4. Install uncomplicated firewall and deny all incoming traffic but ssh. 

As you can see this is nothing but basic precautions.   I got tired of doing these manually all the time, so I wrote this script.  You'll need to add further port exceptions to ufw as you install applications.  You might also consider setting Snort, Tripwire, or SE Linux depending on your needs. 

