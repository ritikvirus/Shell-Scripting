# About Godaddy-Auto-replace-IP Script
> This script is designed to automate the process of setting up an SSL certificate for a website hosted on an EC2 instance running Ubuntu and using the Nginx web server. It uses the GoDaddy DNS service to update the A record for the website's domain name, so that it points to the EC2 instance's public IP address. It then runs Certbot, a tool for obtaining and renewing SSL certificates, to generate a new SSL certificate for the website. Finally, it restarts Nginx to ensure that the new SSL certificate is applied
In summary, this script automates the process of setting up SSL for a website hosted on an EC2 instance running Ubuntu with Nginx, by updating the DNS record on GoDaddy, generating an SSL certificate using Certbot, and restarting Nginx.

# To automatically start the script when your Ubuntu system starts, you can create a systemd service unit for it.

1. Open a terminal and create a new file called godaddy-certbot.service in the /etc/systemd/system/ directory using your favorite text editor:
```
sudo nano /etc/systemd/system/godaddy-certbot.service
```
2. Add the following content to the file:
```
[Unit]
Description=Script to update GoDaddy DNS and obtain/renew SSL certificate

[Service]
Type=simple
ExecStart=/path/to/your/script.sh

[Install]
WantedBy=multi-user.target
```
### `Replace /path/to/your/script.sh with the actual path to your script.`

3. Save the file and exit the text editor.

4. Reload the systemd daemon to load the new service unit:
```
sudo systemctl daemon-reload
```
5. Enable the service to start at boot:
```
sudo systemctl enable godaddy-certbot.service
```
6. Start the service:
```
sudo systemctl start godaddy-certbot.service
```

### That's it! Your script will now run automatically on system startup, and you can check its status with:
```
sudo systemctl status godaddy-certbot.service
```
