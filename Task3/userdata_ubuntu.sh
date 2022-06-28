#!/bin/bash
apt-get update
# DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 jq
mkdir /var/www/mysite

cat > /var/www/mysite/status.sh <<'EOF' 
#!/bin/bash
echo "Content-type: text/html"
SYSINFO=$(hostnamectl|jq -Rr '@html'|sed -e 's/^/<pre>/; s/$/<\/pre>/')

echo ""
cat <<EOT
<!DOCTYPE html>
<html>
<head>
        <title>Welcome to our application</title>
</head>
<body>
<style>
.code {
        line-height: 0.5;
        font-size: 14px;
      }
</style> 
        <div>
          <h1>
            Hello World
         </h1>
       </div>
       <div>
          <h2>
            System Information
         </h2>
       </div>    <div class="code">$SYSINFO</div>
</body>
</html>
EOT
EOF
chmod +x /var/www/mysite/status.sh
chown -R www-data:www-data /var/www/mysite

cat > /etc/apache2/sites-available/mysite.conf <<'EOF'
<VirtualHost *:80>
	# The ServerName directive sets the request scheme, hostname and port that
	# the server uses to identify itself. This is used when creating
	# redirection URLs. In the context of virtual hosts, the ServerName
	# specifies what hostname must appear in the request's Host: header to
	# match this virtual host. For the default virtual host (this file) this
	# value is not decisive as it is used as a last resort host regardless.
	# However, you must set it for any further virtual host explicitly.
	#ServerName www.example.com

	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/mysite
	DirectoryIndex status.sh

	# Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
	# error, crit, alert, emerg.
	# It is also possible to configure the loglevel for particular
	# modules, e.g.
	#LogLevel info ssl:warn

	#ErrorLog ${APACHE_LOG_DIR}/error.log
	#CustomLog ${APACHE_LOG_DIR}/access.log combined

	# For most configuration files from conf-available/, which are
	# enabled or disabled at a global level, it is possible to
	# include a line for only one particular virtual host. For example the
	# following line enables the CGI configuration for this host only
	# after it has been globally disabled with "a2disconf".
	#Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
EOF
a2dissite 000-default.conf
a2ensite mysite.conf 
a2enmod cgid

cat > /etc/apache2/conf-available/www-mysite.conf <<'EOF'
<Directory /var/www/mysite>
	Options +ExecCGI
	AddHandler cgi-script .sh
	AllowOverride None
	Require all granted
</Directory>
EOF
a2enconf www-mysite.conf
apache2ctl configtest
systemctl reload apache2  

apt-get update
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

reboot
