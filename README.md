# lms

```
sudo grep 'temporary password' /var/log/mysqld.log
```

```
mysql -u root -p

ALTER USER 'root'@'localhost' IDENTIFIED BY 'NewPassword123!';
FLUSH PRIVILEGES;
EXIT;
```

```
mysql -u root -p
CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

```
sudo mkdir /var/www/moodledata
sudo chown -R apache:apache /var/www/moodledata
sudo chmod -R 775 /var/moodledata
```

```
sudo chown -R apache:apache /var/www/html/moodle
sudo find /var/www/html/moodle -type d -exec chmod 775 {} \;
sudo find /var/www/html/moodle -type f -exec chmod 664 {} \;
```

/etc/php.ini:
```
max_input_vars=5000
memory_limit = 512M
```

```
sudo php /var/www/html/moodle/admin/cli/install.php
```

```
$CFG->wwwroot = 'https://lms.research.pigumer.com/moodle';
$CFG->sslproxy = true;
```

/etc/httpd/conf.d/moodle.conf
```
<VirtualHost *:80>
    DocumentRoot "/var/www/html"
    ServerName lms.research.pigumer.com

    Alias /moodle "/var/www/html/moodle/public"

    # DirectoryIndex index.php index.html

    # UseCanonicalName Off
    # UseCanonicalPhysicalPort Off

    # SetEnvIf X-Forwarded-Proto "^https$" HTTPS=on
    SetEnv HTTPS on

    # RemoteIPHeader X-Forwarded-For
    # RemoteIPInternalProxy 10.0.0.0/8

    <Directory "/var/www/html/moodle/public">
        # DirectorySlash Off
        Options FollowSymLinks
        AllowOverride All
        Require all granted
        # AcceptPathInfo On
    </Directory>
</VirtualHost>
```

```
echo "* * * * * apache /usr/bin/php /var/www/html/moodle/admin/cli/cron.php > /dev/null 2>&1" > /etc/cron.d/moodle-cron
chmod 644 /etc/cron.d/moodle-cron
```

# Code-Server

/etc/httpd/conf.d/code-server.conf
```
<VirtualHost *:80>
    ServerName lms.research.pigumer.com

    # ErrorLog logs/code-server_error.log
    # CustomLog logs/code-server_access.log combined

    ProxyAddHeaders On
    ProxyRequests Off
    ProxyPreserveHost On

    RequestHeader set "X-Forwarded-Proto" "https"
    RequestHeader set "X-Forwarded-Port" "443"

    RewriteEngine On
    RewriteCond %{HTTP:Upgrade} =websocket [NC]
    RewriteRule /(.*)           ws://localhost:8080/$1 [P,L]

    ProxyPass / http://localhost:8080/
    ProxyPassReverse / http://localhost:8080/

    <Location />
        Require all granted
    </Location>
</VirtualHost>
```

