https://www.digitalocean.com/community/tutorials/how-to-install-and-use-graphite-on-an-ubuntu-14-04-server

# Graphite ���������� ��� ����� ���� mysql. ������������, ��� �� ����������.
sudo apt-get install graphite-web graphite-carbon

# ������� �������, ��� ������ ��� ���� ������ � mysql
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

# ������ ��
mysql -e "CREATE DATABASE graphite;" -u root -p 
# ������ ������������, ���������� � ������� ����
mysql -e "CREATE USER 'graphite'@'localhost' IDENTIFIED BY 'your_pass';" -u root -p 
# ��� ������������ �����
mysql -e "GRANT ALL PRIVILEGES ON graphite.* TO 'graphite'@'localhost';" -u root -p 
# ��������� ���������
mysql -e 'FLUSH PRIVILEGES;' -u root -p 
/usr/lib/python2.6/site-packages/graphite/manage.py syncdb
service carbon-cache start
service httpd start
# ��� �� 80-� ���� � ��������� ����������� Graphite. �� ������� � ����� /etc/carbon/storage-schemas.conf ����� ��������� ������������ �������� �������� ������ (������� ������ (����) ������ ����� � ������ (����) �����)