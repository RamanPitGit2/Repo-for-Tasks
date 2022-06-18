#!/bin/bash
echo "Content-type: text/html"
PROINFO=$(ps -aux|jq -Rr '@html'|sed -e 's/^/<pre>/; s/$/<\/pre>/')
SYSINFO=$(hostnamectl|jq -Rr '@html'|sed -e 's/^/<pre>/; s/$/<\/pre>/')
SPASEINFO=$(df -h|jq -Rr '@html'|sed -e 's/^/<pre>/; s/$/<\/pre>/')
MEMINFO=$(free -m|jq -Rr '@html'|sed -e 's/^/<pre>/; s/$/<\/pre>/')


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
        <div>
          <h2>
            Disk Information
         </h2>
       </div>    <div class="code">$SPASEINFO</div>
        <div>
          <h2>
            Memory Information
         </h2>
       </div>    <div class="code">$MEMINFO</div>
        <div>
          <h2>
            Process Information
         </h2>
       </div>    <div class="code">$PROINFO</div>
</body>
</html>
EOT