Prepare Mysql DB

```
docker run -e MYSQL_URL="jdbc:mysql://172.16.249.151:3306/airpal" -e MYSQL_USER=root -it pubnative/airpal ./migrate.sh
```

