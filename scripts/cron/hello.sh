# just say hello

# 1. touch /var/log/crontab.log
# 2. chmod 777 /var/log/crontab.log
# require sudo permission /var/log/crontab.log
echo "`date` hello, $USER" >> /var/log/crontab.log