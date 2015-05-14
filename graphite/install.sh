https://www.digitalocean.com/community/tutorials/how-to-install-and-use-graphite-on-an-ubuntu-14-04-server

# Graphite использует для своих нужд mysql. предполагаем, что он установлен.
sudo apt-get install graphite-web graphite-carbon

# говорим графиту, как именно ему надо ходить в mysql
sudo nano /etc/graphite-web/local_settings.py

DATABASES = {
'default': {
'NAME': 'graphite',
'ENGINE': 'django.db.backends.mysql',
'USER': 'graphite',
'PASSWORD': 'your_pass',
'HOST': 'localhost',
'PORT': '3306',
          }
}

# создаём БД
mysql -e "CREATE DATABASE graphite;" -u root -p 
# создаём пользователя, указанного в конфиге выше
mysql -e "CREATE USER 'graphite'@'localhost' IDENTIFIED BY 'your_pass';" -u root -p 
# даём пользователю права
mysql -e "GRANT ALL PRIVILEGES ON graphite.* TO 'graphite'@'localhost';" -u root -p 
# применяем изменения
mysql -e 'FLUSH PRIVILEGES;' -u root -p 
/usr/lib/python2.6/site-packages/graphite/manage.py syncdb
service carbon-cache start
service httpd start
# Идём на 80-й порт и наблюдаем девственный Graphite. По желанию в файле /etc/carbon/storage-schemas.conf можно настроить динамический интервал хранения метрик (хранить меньше (реже) старых точек и больше (чаще) новых)