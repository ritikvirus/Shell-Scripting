#!/bin/bash

# Get the public IP address of the EC2 instance
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Update the A record for your subdomain on GoDaddy === if you want setup with your root domain then replace with this command
# response=$(curl -s -o /dev/null -w "%{http_code}" -X PUT "https://api.godaddy.com/v1/domains/ritikvirus.info/records/A/@" \
response=$(curl -s -o /dev/null -w "%{http_code}" -X PUT "https://api.godaddy.com/v1/domains/ritikvirus.info/records/A/resume" \
     -H "Authorization: sso-key PASTE-HERE-KEY:PASTE-HERE-SECRETE-KEY" \
     -H "Content-Type: application/json" \
     -d '[{"data": "'"$PUBLIC_IP"'","ttl": 600}]')

if [ "$response" -eq 200 ]; then
  echo "Public IP set up successfully. Running certbot..."
  certbot_cmd="sudo certbot --nginx -d resume.ritikvirus.info"
  
  # Check if an existing certificate exists
  if sudo certbot certificates | grep -q 'resume.ritikvirus.info'; then
    echo "Existing certificate found. Attempting to reinstall..."
    certbot_cmd+=" --reinstall"
  fi

  # Run certbot with appropriate options
  $certbot_cmd

  # Restart Nginx
  echo "Restarting Nginx..."
  sudo systemctl restart nginx
else
  echo "Failed to set up public IP."
fi
