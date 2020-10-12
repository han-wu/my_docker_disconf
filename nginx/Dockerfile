FROM	nginx:1.19.2
MAINTAINER heino <com.cn.wuhan@gmail.com>

COPY ./nginx/disconf.conf /etc/nginx/conf.d

RUN mkdir -p /static/disconf /logs/disconf

COPY ./build/war/html /static/disconf
RUN chmod a+xr /static \
    && chmod a+r /etc/nginx/conf.d/disconf.conf

