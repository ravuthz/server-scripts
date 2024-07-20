# Server Scripts

# Check Ubuntu

```bash
# Execute locally via sh
curl -sL https://github.com/ravuthz/server-scripts/raw/master/check-ubuntu.sh | sudo -E bash -
```

# Check Linux & Unix

```bash
curl -sL https://github.com/ravuthz/server-scripts/raw/master/check-ubuntu.sh | ssh user@any-server
```

```bash
# Execute remotely via ssh 
curl -sL https://github.com/ravuthz/server-scripts/raw/master/check-linux.sh | ssh user@any-server
```

# Install git, nginx, php 8.2 for laravel
```bash
curl -sL https://github.com/ravuthz/server-scripts/raw/master/install-nginx-php-8.2.sh | sudo -E bash -
```

# Install git, nginx, nodejs 18, pm2, yarn
```bash
curl -sL https://github.com/ravuthz/server-scripts/raw/master/install-nginx-node-18.sh | sudo -E bash -
```

# Install DockerCE

Using wget
```bash
wget -O - https://raw.githubusercontent.com/ravuthz/docker-ce/master/install.sh | bash
```

Using curl
```bash
curl https://raw.githubusercontent.com/ravuthz/docker-ce/master/install.sh | sudo bash -s -
```

# After install php, nginx and laravel project cloned
```bash
# Make we already configure .env
curl -sL https://github.com/ravuthz/server-scripts/raw/master/init-nginx-for-laravel.sh | sudo -E bash -
```

# Deploy static site via SSH and SCP
## Script for deploy dist to /var/www/html via ssh and scp
```bash
curl -o deploy.sh https://raw.githubusercontent.com/ravuthz/server-scripts/master/ssh-deploy-dist.sh
```
## Execute deploy.sh
```bash
chmod +x deploy.sh && ./deploy.sh
```



## Check Nginx
```bash
# Check nginx syntax
nginx -t

# Check Nginx status
sudo systemctl status nginx

# List deploy folder permission
ls -lah /var/www/html

# See nginx configures
cat /etc/nginx/nginx.conf
cat /etc/nginx/sites-available/default
```

## Common nginx scripts
```bash
sudo systemctl status nginx

sudo systemctl reload nginx
sudo systemctl restart nginx

# Configure ssh host (optional)
code ~/.ssh/config

# Example
# Host REPLACE_HOST_NAME
#   HostName REPLACE_HOST_IP
#   User REPLACE_USER_NAME

# Read default id_rsa key
cat ~/.ssh/id_rsa.pub

# Copy host key to remote server
ssh-copy-id user@remote.server.location

```
