FROM debian
ADD docker.list /etc/apt/sources.list.d/
RUN apt-get update && apt-get -y upgrade && apt -y install nginx && apt-get clean && \
    cd /var/www/ && rm -rf ./* && \
    mkdir -p julia-os.com/img && \
    chmod -R 754 /var/www/julia-os.com/ && \
    useradd Julia && groupadd Bocharkina && usermod -aG Bocharkina Julia && \
    chown -R Julia:Bocharkina /var/www/julia-os.com/ && \
    sed -i 's/\/var\/www\/html/\/var\/www\/julia-os.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/user www-data/user Julia/g' /etc/nginx/nginx.conf
ADD index.html /var/www/julia-os.com/
ADD img.jpg /var/www/julia-os.com/img/
CMD ["nginx", "-g", "daemon off;"]
