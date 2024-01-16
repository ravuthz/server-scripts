#!/bin/bash

[ ! -f .env ] || export $(sed 's/#.*//g' .env | xargs)
[ ! -f .env.local ] || export $(sed 's/#.*//g' .env.local | xargs)

# cat .env.local | sed 's/#.*//g'
# sed 's/#.*//g' .env.local
# grep -v '^#' .env.local

echo "\n$ Check DEPLOY_REMOTE evnironment variable"
echo "DEPLOY_REMOTE=$DEPLOY_REMOTE" 
# printenv | grep 'DEPLOY_REMOTE'

echo "\n$ Create backup folder is not exist"
ssh $DEPLOY_REMOTE 'mkdir -p ~/backup && ls ~'

echo "\n$ List all files in /var/www/html"
ssh $DEPLOY_REMOTE 'ls -lah /var/www/html'


echo "\n$ Back all files in /var/www/html to ~/backup with name `html_date_format.tar.gz`"
ssh $DEPLOY_REMOTE 'mv /var/www/html ~/backup/html_$(date +"%Y%m%d_%H%M%S") && ls ~/backup'
# ssh $DEPLOY_REMOTE 'cd ~/backup && tar -czvf html_$(date +"%Y%m%d_%H%M%S").tar.gz /var/www/html && ls ~/backup'

echo "\n$ Copy all files in dist to server /var/www/html after backup"
scp -r dist/* "$DEPLOY_REMOTE:/var/www/html"
