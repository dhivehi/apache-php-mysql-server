# To install httpd:
#=============================
yum install httpd
systemctl start httpd
systemctl enable httpd.service
firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --reload

sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www
sudo mkdir /etc/httpd/sites-available /etc/httpd/sites-enabled

#Add this line to the end of the file:/etc/httpd/conf/httpd.conf
IncludeOptional sites-enabled/*.conf

#Add this to /etc/httpd/sites-available/domain.com.conf
#<VirtualHost *:80>
#    ServerName sub.domain.com
#    ServerAlias sub.domain.com
#    DocumentRoot /var/www/html/sub
#</VirtualHost>
#<VirtualHost *:80>
#    ServerName domain.com
#    ServerAlias www.domain.com
#    DocumentRoot /var/www/html
#</VirtualHost>

sudo ln -s /etc/httpd/sites-available/domain.com.conf /etc/httpd/sites-enabled/domain.com.conf
sudo systemctl restart httpd

# To install php7.3:
#=============================
sudo yum install https://repo.ius.io/ius-release-el7.rpm
yum install mod_php73 php73-bcmath php73-cli php73-gd php73-ldap php73-mbstring php73-mysqlnd php73-soap


#To install mysql v8
sudo wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
sudo md5sum mysql80-community-release-el7-3.noarch.rpm
sudo rpm -ivh mysql80-community-release-el7-3.noarch.rpm
sudo yum install mysql-server
sudo systemctl start mysqld
sudo systemctl enable mysqld

#Find Temporary Password
sudo grep 'temporary password' /var/log/mysqld.log

#To set new mysql password
sudo mysql_secure_installation

#To fix pma login issue
ALTER USER root@'%' IDENTIFIED WITH mysql_native_password BY 'pAssWord';








