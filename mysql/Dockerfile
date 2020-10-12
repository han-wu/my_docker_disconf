# 基础镜像
FROM	mysql:5.7.31

# 作者
MAINTAINER heino

# 定义工作目录
ENV WORK_PATH /opt/mysql

# 定义会被容器自动执行的目录
ENV AUTO_RUN_DIR /docker-entrypoint-initdb.d

# 定义sql文件名
ENV FILE_0 0-init_table.sql
ENV FILE_1 1-init_data.sql
ENV FILE_2 20151225.sql
ENV FILE_3 20160701.sql

# 定义shell文件名
ENV DISCONF_SQL init_disconf-sql.sh

# 创建文件夹
RUN mkdir -p $WORK_PATH

# 复制disconf的初始化sql到工作目录下
COPY ./disconf/disconf-web/sql/$FILE_0 $WORK_PATH
COPY ./disconf/disconf-web/sql/$FILE_1 $WORK_PATH
COPY ./disconf/disconf-web/sql/201512/$FILE_2 $WORK_PATH
COPY ./disconf/disconf-web/sql/20160701/$FILE_3 $WORK_PATH

# 执行初始化sql的shell脚本
COPY ./mysql/$DISCONF_SQL $AUTO_RUN_DIR

# 给sql脚本执行脚本赋予读取权限
RUN chmod +x $AUTO_RUN_DIR/$DISCONF_SQL
