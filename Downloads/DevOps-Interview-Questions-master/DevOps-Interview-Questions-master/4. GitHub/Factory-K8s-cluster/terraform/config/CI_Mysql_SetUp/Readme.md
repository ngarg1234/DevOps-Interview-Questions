Mysql has changed, so you need to follow below operations,

first go to
sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf  and comment

bind-address           = 0.0.0.0
#mysqlx-bind-address    = 127.0.0.1

follow the below for granting remote access
https://syntaxfix.com/question/446/how-to-grant-all-privileges-to-root-user-in-mysql-8-0
