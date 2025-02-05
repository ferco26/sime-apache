FROM httpd:latest

# Copiar la configuración del VirtualHost
COPY fercocloud.nucleo-cloud.com.conf /usr/local/apache2/conf/extra/fercocloud.conf

# Incluir la configuración del VirtualHost en httpd.conf
RUN echo "Include /usr/local/apache2/conf/extra/fercocloud.conf" >> /usr/local/apache2/conf/httpd.conf

# Habilitar los módulos necesarios en Apache
RUN sed -i '/LoadModule rewrite_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule proxy_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule proxy_ajp_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule proxy_http_module/s/^#//g' /usr/local/apache2/conf/httpd.conf

# Copiar los archivos de la aplicación al directorio correcto (/var/www/html)
COPY dist/ /var/www/html/

# Eliminar la página de bienvenida de Apache
RUN rm -f /etc/httpd/conf.d/welcome.conf

# Exponer el puerto 80
EXPOSE 80

# Iniciar Apache en primer plano
CMD ["httpd", "-D", "FOREGROUND"]
