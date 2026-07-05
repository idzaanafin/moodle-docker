FROM ubuntu:latest

RUN apt update && apt upgrade -y && apt install -y apache2 software-properties-common php php-cli php-common php-mysql php-gd php-xml php-mbstring php-curl php-zip php-soap php-intl php-bcmath mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

RUN rm -f /var/www/html/index.html

COPY ./moodle/moodle-MOODLE_500_STABLE/ /var/www/html/

RUN mkdir /var/www/moodledata

RUN chown -R www-data:www-data /var/www/html && chown -R www-data:www-data /var/www/moodledata && chmod -R 755 /var/www/html && chmod 770 /var/www/moodledata

RUN sed -i 's/max_execution_time = .*/max_execution_time = 300/' /etc/php/*/apache2/php.ini \
 && sed -i 's/max_execution_time = .*/max_execution_time = 300/' /etc/php/*/cli/php.ini \
 && sed -i 's/;max_input_vars = .*/max_input_vars = 5000/' /etc/php/*/apache2/php.ini \
 && sed -i 's/;max_input_vars = .*/max_input_vars = 5000/' /etc/php/*/cli/php.ini \
 && sed -i 's/memory_limit = .*/memory_limit = 128M/' /etc/php/*/apache2/php.ini \
 && sed -i 's/memory_limit = .*/memory_limit = 128M/' /etc/php/*/cli/php.ini \
 && sed -i 's/post_max_size = .*/post_max_size = 50M/' /etc/php/*/apache2/php.ini \
 && sed -i 's/post_max_size = .*/post_max_size = 50M/' /etc/php/*/cli/php.ini \
 && sed -i 's/upload_max_filesize = .*/upload_max_filesize = 50M/' /etc/php/*/apache2/php.ini \
 && sed -i 's/upload_max_filesize = .*/upload_max_filesize = 50M/' /etc/php/*/cli/php.ini

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
