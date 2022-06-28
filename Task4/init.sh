#!/bin/bash

set -e
set -x

yum upgrade -y
yum -y install epel-release
yum clean all
yum search nginx
yum -y install policycoreutils nginx

#redirect logs to stdout
ln -sf /dev/stdout /var/log/nginx/access.log  
ln -sf /dev/stderr /var/log/nginx/error.log 

mkdir -p /var/www/hello
restorecon -R -v /var/www/ 

cat > /etc/nginx/site_template.tpl <<'EOF'
<!DOCTYPE html>
<html>
<head>
        <title>Task 4 </title>
</head>
<body>
        <div>
          <h1>
            $DEVOPS
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

