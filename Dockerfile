FROM tomcat:8.5.78-jre11-openjdk-slim

MAINTAINER "Artem Podoliak" 

COPY ./target/*.war /usr/local/tomcat/webapps