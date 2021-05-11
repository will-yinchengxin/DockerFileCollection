library / nginx
---------------

本目录为nginx的构建脚本


#### 镜像信息

* 应用主目录: `/usr/local/nginx`
* 配置目录: `/usr/local/nginx/conf`
* 数据目录: `/var/www`
* 监听端口: `80 / 443`
* 启动命令: `nginx`
* 模块详情:
    * 禁用`select_module`
    * 启用`poll_module`
    * 启用`threads`
    * 启用`http_ssl_module`
    * 启用`http_v2_module`
    * 启用`http_realip_module`
    * 启用`http_addition_module`
    * 启用`http_auth_request_module`
    * 启用`http_dav_module`
    * 启用`http_stub_status_module`
    * 启用`http_gzip_static_module`
    * 启用`pcre-jit`
    * 启用`ipv6`
* 日志目录: `/var/log/nginx`
* PID目录: `/var/run/nginx`

