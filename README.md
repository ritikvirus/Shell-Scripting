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
