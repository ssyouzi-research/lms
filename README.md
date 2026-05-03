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
sudo mkdir /var/moodledata
sudo chown -R apache:apache /var/moodledata
sudo chmod -R 775 /var/moodledata
```

```
sudo find /var/www/html/moodle -type d -exec chmod 775 {} \;
sudo find /var/www/html/moodle -type f -exec chmod 664 {} \;
```

/etc/php.ini:
```
max_input_vars=5000
```

```
sudo php /var/www/html/moodle/admin/cli/install.php
```

```
$CFG->wwwroot = 'https://lms.research.pigumer.com/moodle';
$CFG->sslproxy = true;
```

```
<VirtualHost *:80>
    DocumentRoot "/var/www/html"
    ServerName lms.research.pigumer.com

    # DirectoryIndex index.php index.html

    # UseCanonicalName Off
    # UseCanonicalPhysicalPort Off

    # SetEnvIf X-Forwarded-Proto "^https$" HTTPS=on
    SetEnv HTTPS on

    # DirectorySlash Off
    # Options FollowSymLinks
    # AllowOverride All
    # Require all granted
    # AcceptPathInfo On

    RemoteIPHeader X-Forwarded-For
    RemoteIPInternalProxy 10.0.0.0/8
</VirtualHost>
```
