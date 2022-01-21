FROM httpd:latest

COPY . /var/www/html

CMD /usr/sbin/httpd -D FOREGROUND

EXPOSE 80
