# Nginx configuration changes

NGINX_CONF="/etc/nginx/sites-available/default"
BACKUP_CONF="/etc/nginx/sites-available/default.bak"

echo Backing up Nginx default config...
sudo cp $NGINX_CONF $BACKUP_CONF
echo Backup done.

echo Configuring Nginx for reverse proxy...
# Use sed to configure Nginx to forward port 80 to Node.js app running on port 3000
sudo sed -i '/server_name _;/a \\n\tlocation / {\n\t\tproxy_pass http://localhost:3000;\n\t\tproxy_set_header Host $host;\n\t\tproxy_set_header X-Real-IP $remote_addr;\n\t\tproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n\t\tproxy_set_header X-Forwarded-Proto $scheme;\n\t}\n' $NGINX_CONF
echo Nginx configuration updated.

echo Restarting Nginx...
sudo systemctl restart nginx
echo Nginx restarted.

echo Check if Nginx is running...
sudo systemctl status nginx | grep "active (running)"
echo Done! Now test in the browser without :3000.