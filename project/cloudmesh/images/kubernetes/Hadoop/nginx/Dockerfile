#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/nginx/Dockerfile

#Getting base ngnix image
FROM nginx

#Copying the configuration file to the desired location
COPY config.conf /etc/nginx/conf.d/config.conf

#Copying the materialize file to the desired location
COPY materialize.min.css /data/bde-css/materialize.min.css

#Copying the hadoop file to the desired location
COPY hadoop.css /data/bde-css/hadoop.css
