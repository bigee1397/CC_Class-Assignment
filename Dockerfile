FROM ubuntu:latest
RUN apt-get update \
        && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
        && apt-get install -y tzdata \
        && dpkg-reconfigure --frontend noninteractive tzdata\
        && apt-get install nginx systemctl supervisor php8.1 php8.1-fpm php8.1-cli php8.1-common php8.1-mysql php8.1-zip \
           php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-bcmath -y
RUN mkdir -p /var/run/php/
RUN mkdir /var/www/website
RUN echo "<?php phpinfo(); ?>" >> /var/www/website/index.php
COPY ./config/default /etc/nginx/sites-available/default
#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#CMD ["/usr/bin/supervisord"]
ENTRYPOINT ["systemctl"] CMD ["start","nginx"] CMD ["start","php8.1-fpm"]
EXPOSE 80