### 项目介绍

   clouddo是基于springcloud和vue微服务，前后端分离的后台管理框架，可以作为springcloud和vue的入门学习框架，亦可以作为一个基础脚手架进行二次开发

### 使用说明


1.执行数据库脚本init.sql,

数据库中增加用户clouddo, 拥有数据库clouddo的增删改查权限

`grant select,insert,update,delete on clouddo.* to clouddo@'%' Identified by "clouddo";`

修改clouddo-admin的数据库用户密码

2.启动clouddo-server 注册中心

3.启动clouddo-zuul 网关

4.启动clouddo-base 基础微服务

5.启动clouddo-admin 权限微服务

6.启动clouddo-cms 内容管理微服务

> 2-6的步骤可以直接通过sh start.sh启动全部, 
终止项目运行执行sh stop.sh

7.启动前端项目 https://gitee.com/lcg0124/clouddo-view.git
### 系统截图
![输入图片说明](https://gitee.com/uploads/images/2018/0525/154945_23b93b75_1204498.png "屏幕截图.png")
