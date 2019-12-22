#Referred https://github.com/big-data-europe/docker-hadoop/blob/master/nginx/Dockerfile

#Getting base hadoop image
FROM nginx

#Copying the configuration file to required directory
COPY default.conf /etc/nginx/conf.d/default.conf

#Copying the cascading style sheet files to required directory
COPY materialize.min.css /data/bde-css/materialize.min.css
COPY bde-hadoop.css /data/bde-css/bde-hadoop.css
