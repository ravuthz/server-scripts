# Server Scripts

# Install git, nginx, php 8.2 for laravel
```bash
curl -sL https://github.com/ravuthz/server-scripts/raw/master/install-nginx-php-8.2.sh | sudo -E bash -
```

# Install git, nginx, nodejs 18, pm2, yarn
```bash
curl -sL https://github.com/ravuthz/server-scripts/raw/master/install-nginx-node-18.sh | sudo -E bash -
```


# After install php, nginx and laravel project cloned
```bash
curl -sL https://github.com/ravuthz/server-scripts/raw/master/init-nginx-for-laravel.sh | sudo -E bash -
```

## Check
```bash
# Check nginx syntax
nginx -t

# Nginx status
sudo systemctl status nginx

# List deploy folder permission
ls -lah /var/www/html

# See nginx default configure
cat /etc/nginx/nginx.conf

cat /etc/nginx/sites-available/default

```

## Commone scripts
```bash
sudo systemctl status nginx

sudo systemctl reload nginx
sudo systemctl restart nginx

```
