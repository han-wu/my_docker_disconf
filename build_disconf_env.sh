#!/bin/bash

# 获取shell脚本所在的目录
current_path=$( cd "$( dirname "$0"  )" && pwd  )

cd $current_path

# 删除disconf目录
echo "移除 $current_path 下的disconf与build目录"
rm -rf ./disconf
rm -rf ./build

# 克隆disconf源码
echo "开始克隆disconf的源码到 $current_path ……"
git clone https://github.com/knightliao/disconf.git

# 为disconf源码打成war包新建配置目录与war包存放目录
echo "克隆disconf的源码完毕，开始初始化disconf构建war包环境 ……"
mkdir -p build/{config,war}

# 设置运行disconf源码的deploy.sh所需的环境变量
export ONLINE_CONFIG_PATH=$current_path/build/config
export WAR_ROOT_PATH=$current_path/build/war

# 复制disconf源码中的配置文件到指定目录
cp ./disconf/disconf-web/profile/rd/* $ONLINE_CONFIG_PATH

# 修改文件名
mv $ONLINE_CONFIG_PATH/application-demo.properties $ONLINE_CONFIG_PATH/application.properties

# 修改数据库连接配置中的ip与用户名密码
sed -i -e "s/127.0.0.1/mysqlhost/g" -e "s/123456/Heino@123/g" $ONLINE_CONFIG_PATH/jdbc-mysql.properties
# sed -i "s/123456/Heino@123/g" $ONLINE_CONFIG_PATH/jdbc-mysql.properties

# 修改redis的client.host名称
sed -i "s/redis.group1.client1.host=127.0.0.1/redis.group1.client1.host=redishost01/g" $ONLINE_CONFIG_PATH/redis-config.properties
sed -i "s/redis.group1.client2.host=127.0.0.1/redis.group1.client2.host=redishost02/g" $ONLINE_CONFIG_PATH/redis-config.properties

# 修改zookeeper的host名称
sed -i "s/hosts=127.0.0.1:8581,127.0.0.1:8582,127.0.0.1:8583/hosts=zkhost:2181/g" $ONLINE_CONFIG_PATH/zoo.properties

cd ./disconf/disconf-web

# 修改disconf-web的打包脚本，是maven打包跳过javadoc
sed -i "s/maven.test.skip=true/& -Dmaven.javadoc.skip=true/" deploy/build_java.sh
echo "初始化disconf构建环境完毕，开始构建disconf的war包……"
sh deploy/deploy.sh

echo "构建war包完成，开始制作disconf的tomcat镜像……"
docker build -t 244699181/disconf_tomcat:1.0.0 -f $current_path/tomcat/Dockerfile $current_path
echo "制作disconf的tomcat镜像完成！"

echo "开始制作disconf的mysql镜像……"
docker build -t 244699181/disconf_mysql:1.0.0 -f $current_path/mysql/Dockerfile $current_path
echo "制作disconf的mysql镜像完成！"

echo "开始制作disconf的nginx镜像……"
docker build -t 244699181/disconf_nginx:1.0.0 -f $current_path/nginx/Dockerfile $current_path
echo "制作disconf的nginx镜像完成！"

rm -rf build disconf

echo "开始启动disconf……"
docker-compose up -d
echo "启动disconf完成, 访问端口 80"
