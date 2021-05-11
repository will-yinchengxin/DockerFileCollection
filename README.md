# php-nginx DockerFile
用于快速部署php-nginx开发环境
    - nginx 1.16
    - php 7.3
        - redis 5.2
        - phalcon 3.4
        - swoole 4.4
        - mogodb 1.7
### 使用方式    
执行命令 
- Windows下 `docker run -d -p 8060:80 -v %cd%:/var/www/html  --name  Test 镜像名称`  
- Linux下 `docker run -d -p 8070:80 -v 项目地址:/var/www/html  --name  Test 镜像名称`  
    
