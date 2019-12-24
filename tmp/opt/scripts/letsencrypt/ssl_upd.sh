#!/bin/bash
certbot renew --noninteractive --renew-hook /opt/scripts/nginx_reload.sh