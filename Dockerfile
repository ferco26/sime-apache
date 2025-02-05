FROM httpd:latest

# Copiar la configuración del VirtualHost
COPY fercocloud.nucleo-cloud.com.conf /usr/local/apache2/conf/extra/fercocloud.conf

# Incluir la configuración en httpd.conf
RUN echo "Include /usr/local/apache2/conf/extra/fercocloud.conf" >> /usr/local/apache2/conf/httpd.conf

# 🔹 Habilitar los módulos necesarios en Apache
RUN sed -i '/LoadModule rewrite_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule proxy_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule proxy_ajp_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i '/LoadModule proxy_http_module/s/^#//g' /usr/local/apache2/conf/httpd.conf

# Copiar los archivos de la aplicación
COPY dist/ /usr/local/apache2/htdocs/

# Exponer el puerto 80
EXPOSE 80

CMD ["httpd", "-D", "FOREGROUND"]

