FROM tomcat:8.5.78-jre11-openjdk-slim

MAINTAINER "Artem Podoliak" 
RUN apk --no-cache add curl
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
COPY ./target/*.war /usr/local/tomcat/webapps
