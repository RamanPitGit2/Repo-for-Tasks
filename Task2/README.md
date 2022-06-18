## Task2
### Used commands 
```Shell
sudo apt update
sudo apt dist-upgrade
sudo reboot
sudo apt-get install -y apache2 mc jq
mc 
sudo mc
df -h
mc
chmod +x status.sh
./status.sh 
./status.sh >info.html
sudo mkdir /var/www/mysite
sudo cp ./status.sh /var/www/mysite
sudo cp ./info.html /var/www/mysite
sudo chown -R www-data:www-data /var/www/mysite 
sudo vi /etc/apache2/sites-available/mysite.conf
sudo a2dissite 000-default.conf
sudo a2ensite mysite.conf 
sudo a2enmod cgid
sudo vi /etc/apache2/conf-available/www-mysite.conf
sudo a2enconf www-mysite.conf
sudo apache2ctl configtest
sudo systemctl reload apache2  
ssh-keygen
cat /home/ubuntu/.ssh/id_rsa.pub
ssh 172.31.93.161
```
### Apache configs
[/etc/apache2/sites-available/mysite.conf](./mysite.conf)

[/etc/apache2/conf-available/www-mysite.conf](./www-mysite.conf)

[/var/www/mysite/status.sh](./status.sh)