在Centos6上面運行的Mariadb10

### Where Setting File

Mariadb設定檔

    $ vi /etc/my.inc

Mariadb File路徑

    $ cd /home/mysql

暫存掛載路徑

    $ cd /home/tmp


### How To Command

Mariadb服務重新啟動

    $ service mysql restart
    
    
Mariadb匯入資料庫(SQL)

    $ mysql -uroot -pP@ssw0rd {DBNAME} < {YOUR_FILE_NAME}.sql
    
    
Mariadb匯出資料庫(SQL)

    $ mysqldump -uroot -pP@ssw0rd {DBNAME} | gzip > {YOUR_FILE_NAME}.sql.gz
    
