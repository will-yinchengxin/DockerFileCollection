### Docker 镜像加速
近期在国内，由于不明原因，国内的 Docker 镜像加速站出现了不能正常使用的情况

直接上干货

```shell
vi /etc/docker/daemon.json
````
南京大学镜像站（https://docker.nju.edu.cn）和上海交大镜像站（https://docker.mirrors.sjtug.sjtu.edu.cn），这两个站点比较稳定
````
{
  "registry-mirrors": [
	"https://docker.nju.edu.cn",
	"https://docker.mirrors.sjtug.sjtu.edu.cn",
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
    ]
}
````
重启docker即可

