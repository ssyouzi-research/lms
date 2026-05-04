dnf update -y

dnf install -y git wget unzip tar

dnf install -y httpd
systemctl enable --now httpd

dnf install -y https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm
dnf install -y mysql-community-server
systemctl enable --now mysqld

dnf install -y php8.2 \
  php8.2-fpm \
  php-mysqlnd \
  php-gd \
  php-intl \
  php8.2-mbstring \
  php8.2-xml \
  php8.2-opcache \
  php-soap \
  php-zip \
  php-bcmath

systemctl enable --now php-fpm



cd /var/www/html
git clone -b MOODLE_502_STABLE git://git.moodle.org/moodle.git
