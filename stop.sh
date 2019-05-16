 #!/bin/sh

 # 清除java进程
 jps | grep "clouddo-*" | awk '{print $1}' | xargs kill -9