# Task RAILS 5

## run using docker-compose up

NEEDED DEPENDENCIES
```bash
dokcer, Dokcer machine, docker compose, virtualbox
you need to create docker-machine
```
RUN SERVER
```bash
docker-compose up
```


##To run normal

NEEDED DEPENDENCIES
```bash
mysql 
elasticsearch
```
DataBase
```bash
username: root
password: root
database name : taskbug_development
```
RUN SERVER
```bash
bundle install
rails db:migrate
bundle exec whenever --update-crontab
rails s
```

cron job to update database counters
```bash
will run every 30 min
```


APIS
```bash
you will find application-swagger.yaml descripe each api
```

