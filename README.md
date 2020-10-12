# my_docker_disconf
disconf的docker环境，包含定制的mysql、定制的nginx、定制的tomcat的dockerfile以及基于这3个定制镜像的docker-compose

# 前置条件
主机已经安装了git、maven、docker、docker-compose，且主机能够联网直接从docker hub拉取镜像

# 文件说明
docker-compose.yaml：在该文件所在的目录直接运行`docker-compose up -d`命令将会从docker hub拉取相关镜像并启动disconf

build_disconf_env.sh、mysql目录、tomcat目录、nginx目录：用来构建disconf运行所需的mysql镜像、tomcat镜像、nginx镜像。构建方式，在build_disconf_env.sh所在目录下运行该shell脚本即会自动构建并启动disocnf
