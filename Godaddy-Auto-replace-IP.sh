#!/bin/bash

# Get the public IP address of the EC2 instance
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)


# REPLACE ritikvirus.info DOMAIN TO YOUR DOMAIN
# ADD YOUR KEY:SECRETKEY


# Get the A record for the root domain on GoDaddy ------ If Your using your SUBDOMAIN Then replace @ With yoursubdomain name like mysubdomain.ritikvirus.info
DNS_IP=$(curl -s -X GET "https://api.godaddy.com/v1/domains/ritikvirus.info/records/A/@" \
     -H "Authorization: sso-key GODADDY-KEY:PASTE-YOUR-SECRET-KEY" \
     -H "Content-Type: application/json" \
     | jq -r '.[0].data')

# Update the A record for your root domain on GoDaddy if the IPs are different
if [ "$PUBLIC_IP" != "$DNS_IP" ]; then
  response=$(curl -s -o /dev/null -w "%{http_code}" -X PUT "https://api.godaddy.com/v1/domains/ritikvirus.info/records/A/@" \
     -H "Authorization: sso-key GODADDY-KEY:YOUR-SECRET-KEY" \
     -H "Content-Type: application/json" \
     -d '[{"data": "'"$PUBLIC_IP"'","ttl": 600}]')
  if [ "$response" -ne 200 ]; then
    echo "Failed to update public IP address on GoDaddy."
    exit 1
  fi
fi

# Check if an existing certificate exists
if sudo certbot certificates | grep -q 'ritikvirus.info'; then
  echo "Existing certificate found. Attempting to reinstall..."
  certbot_cmd="sudo certbot --nginx -d ritikvirus.info --reinstall"
else
  echo "No existing certificate found. Creating new certificate..."
  certbot_cmd="sudo certbot --nginx -d ritikvirus.info --agree-tos --email ENTER_YOUR@EMAIL.COM" #Enter Here Your Email Address
fi

# Run certbot with appropriate options
$certbot_cmd

# Restart Nginx
echo "Restarting Nginx..."
sudo systemctl restart nginx
