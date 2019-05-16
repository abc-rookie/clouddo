#!/bin/sh

# mvn clean compile package  install -DskipTests=true

LOGDIR=/tmp/logs/clouddo
JAVA_OPTS="-Dfile.encoding=UTF-8 -Dio.netty.leakDetectionLevel=advanced -Djava.security.egd=file:/dev/./urandom -Dsun.jun.encoding=UTF-8"
echo "====== LOGDIR: $LOGDIR, JAVA_OPTS: $JAVA_OPTS"

if [ ! -d "$LOGDIR" ]; then
    mkdir -p "$LOGDIR"
fi

if [ ! -f "$LOGDIR/pid.txt" ]; then
    touch "$LOGDIR/pid.txt"
fi

if [ ! -f "$LOGDIR/console.log" ]; then
    touch "$LOGDIR/console.log"
fi

cat /dev/null > $LOGDIR/pid.txt

echo "[1] 启动clouddo-server 注册中心..."

nohup java -Dname=clouddoServer $JAVA_OPTS -jar clouddo-server/target/clouddo-server-0.0.1.jar >> $LOGDIR/console.log 2>&1 &
echo $! >> $LOGDIR/pid.txt

echo "[2] 启动clouddo-zuul 网关..."

java -Dname=clouddoZuul $JAVA_OPTS -jar clouddo-zuul/target/clouddo-zuul-0.0.1.jar >> $LOGDIR/console.log 2>&1 &
echo $! >> $LOGDIR/pid.txt

echo "[3] 启动clouddo-base 基础微服..."

java -Dname=clouddoBase $JAVA_OPTS -jar clouddo-base/target/clouddo-base-0.0.1-SNAPSHOT.jar >> $LOGDIR/console.log 2>&1 &
echo $! >> $LOGDIR/pid.txt

echo "[4] 启动clouddo-admin 权限微服..."

java -Dname=clouddoAdmin $JAVA_OPTS -jar clouddo-admin/target/clouddo-admin-0.0.1-SNAPSHOT.jar >> $LOGDIR/console.log 2>&1 &
echo $! >> $LOGDIR/pid.txt

echo "[5] 启动clouddo-cms 内容管理微服务..."

java -Dname=clouddoCms $JAVA_OPTS -jar clouddo-cms/target/clouddo-cms-0.0.1-SNAPSHOT.jar >> $LOGDIR/console.log 2>&1 &
echo $! >> $LOGDIR/pid.txt

echo "启动完成"