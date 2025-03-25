#!/bin/bash
password=$1
sudo apt update
if [ "$(which mysql 2>/dev/null)" ]
then
    echo " Mysql is already installed "
    exit
else
    echo -e "\033[92m<<<<<<<<<<<<<<<<<<<   Installing Mysql!!... >>>>>>>>>>>>>>>>>>>>>\033[0m\n\n"
    sudo apt install mysql-server -y
    echo -e "\033[34m<<<<<<<<<<<<<<<<<<<  Setting Up Root USER >>>>>>>>>>>>>>>>>>>>>\033[0m\n\n"
    sudo mysql <<EOF
    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$password';
    exit
EOF
echo -e "\033[31m<<<<<<<<<<<<<<<<<<<    Granting remote access >>>>>>>>>>>>>>>>>>>>>\033[0m\n\n"
mysql --user=root --password=$1 <<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
fi
sudo sed -i '43 s/^/#/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart

echo -e "\033[31m<<<<<<<<<<<<<<<<<<<    Finished >>>>>>>>>>>>>>>>>>>>>\033[0m"



