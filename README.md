# openim开源项目k8s集群部署
    当前server版本2.0.6
    当前core版本2.0.5
    历史版本请查看 git tag
## 需要的环境
    MacOS OR Linux
## 需要安装的软件
- wget
- docker
- kubectl
## k8s配置
    编辑 setting.env
```shell
#docker镜像tag前缀
DOCKER_REGISTRY_ADDR="k3d-registry.local:5001/"
#nodePort暴露端口号 api
NODE_PORT_API="10100"
#nodePort暴露端口号 msg_gateway
NODE_PORT_MSG_GATEWAY="10101"
#nodePort暴露端口号 sdk_server
NODE_PORT_SDK_SERVER="10102"
#nodePort暴露端口号 demo
NODE_PORT_DEMO="10103"
#部署在哪个命名空间
K8S_NAMESPACE="openim"
```
## 单个服务部署
```shell
cd $服务路径 && \
bash build.sh
```
## 全部部署
```shell
go run .
```

## Ingress 负载均衡
    这里只说一下msg_gateway和sdk_server的Ingress配置
    nginx-ingress-controller支持websocket
```yaml
#增加ingress注解
nginx.ingress.kubernetes.io/proxy-http-version: "1.1"
nginx.ingress.kubernetes.io/proxy-read-timeout: "3600"
nginx.ingress.kubernetes.io/proxy-send-timeout: "3600"
```
### yaml示例
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/proxy-http-version: "1.1"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "3600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "3600"
  name: sdk-server.xxx.com
spec:
  rules:
  - host: sdk-server.xxx.com
    http:
      paths:
      - backend:
          service:
            name: sdk-server
            port:
              number: 30000
        path: /
        pathType: Prefix
```