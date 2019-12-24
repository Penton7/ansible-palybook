#!/bin/bash
echo "Please enter hostname:"
read sslhost
certbot certonly --webroot --agree-tos --no-eff-email --email admin@technorely.com -w /var/www/letsencrypt -d $sslhost