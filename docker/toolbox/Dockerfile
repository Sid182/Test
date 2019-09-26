FROM ubuntu:14.04
MAINTAINER Serhii Podkhapov
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y apache2 
COPY index.html /var/www/html/
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
