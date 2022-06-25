#!/bin/bash

set -x
#sed -i 's/enabled=1/enabled=0/g' /etc/yum/pluginconf.d/fastestmirror.conf
yum upgrade -y
yum -y install epel-release
#sed -i -e 's#[#]baseurl=http://download.example/pub/epel/7/[$]basearch#baseurl=https://fedora.mirrorservice.org/epel/7/[$]basearch#g' \
#-e 's/^metalink/#metalink/g' /etc/yum.repos.d/epel.repo 
#sed -i -e 's/#baseurl/baseurl/g' -e 's/^metalink/#metalink/g' /etc/yum.repos.d/epel.repo 
yum clean all
yum search nginx
yum -y install nginx
mkdir -p /var/www/hello
#make selinux happy 
restorecon -R -v /var/www/ 

cat > /var/www/hello/index.html <<'EOF' 
<!DOCTYPE html>
<html>
<head>
        <title>Task 3(Extra) </title>
</head>
<body>
        <div>
          <h1>
          Hello World!
         </h1>
       </div>
</body>
</html>
EOF
chown -R nginx:nginx /var/www/hello
cat > /etc/nginx/conf.d/hello.conf <<'EOF'
server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /var/www/hello;

        # Load configuration files for the default server block.

        error_page 404 /404.html;
        location = /404.html {
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
        }
    }
EOF
yum clean all