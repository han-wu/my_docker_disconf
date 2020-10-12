FROM tomcat:9.0.20-jre8

MAINTAINER heino <com.cn.wuhan@gmail.com>

ENV WEBAPPS_PATH=/usr/local/tomcat

COPY tomcat/server.xml $WEBAPPS_PATH/conf/server.xml

RUN chmod a+xr $WEBAPPS_PATH/conf/server.xml \
    && rm -rf $WEBAPPS_PATH/webapps/*

# 部署disconf的war包到tomcat的指定目录
COPY build/war/disconf-web.war $WEBAPPS_PATH/webapps
