To automatically start the script when your Ubuntu system starts, you can create a systemd service unit for it.

Open a terminal and create a new file called godaddy-certbot.service in the /etc/systemd/system/ directory using your favorite text editor:

bash
Copy code
sudo nano /etc/systemd/system/godaddy-certbot.service
Add the following content to the file:

css
Copy code
[Unit]
Description=Script to update GoDaddy DNS and obtain/renew SSL certificate

[Service]
Type=simple
ExecStart=/path/to/your/script.sh

[Install]
WantedBy=multi-user.target
Replace /path/to/your/script.sh with the actual path to your script.

Save the file and exit the text editor.

Reload the systemd daemon to load the new service unit:

Copy code
sudo systemctl daemon-reload
