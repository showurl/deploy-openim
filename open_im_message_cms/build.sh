#!/bin/bash
source ../setting.env
VERSION_TAG_SERVER="2.0.6"
IMAGE_TAG="${DOCKER_REGISTRY_ADDR}open_im_message_cms:v$VERSION_TAG_SERVER"


bash ../download.sh
echo  "下载完成" && \
docker build . -t $IMAGE_TAG --no-cache && \
echo "构建完成" && \
echo "构建完成" && \
echo "构建完成" && \
echo "构建完成" && \
echo "构建完成" && \
echo "构建完成" && \
echo "构建完成" && \
echo "构建完成" && \
echo "构建完成" && \
echo "构建完成" && \
docker push $IMAGE_TAG && \
cp development.tmp.yaml development.yaml

if [[ `uname` == 'Darwin' ]]; then
    sed -i "" "s#IMAGE_TAG#${IMAGE_TAG}#g" ./development.yaml
    sed -i "" "s#NODE_PORT_API#${NODE_PORT_API}#g" development.yaml
    sed -i "" "s#NODE_PORT_MSG_GATEWAY#${NODE_PORT_MSG_GATEWAY}#g" development.yaml
    sed -i "" "s#NODE_PORT_SDK_SERVER#${NODE_PORT_SDK_SERVER}#g" development.yaml
    sed -i "" "s#NODE_PORT_DEMO#${NODE_PORT_DEMO}#g" development.yaml
elif [[ `uname` == 'Linux' ]]; then
  sed -i "s#IMAGE_TAG#${IMAGE_TAG}#g" development.yaml
  sed -i "s#NODE_PORT_API#${NODE_PORT_API}#g" development.yaml
  sed -i "s#NODE_PORT_MSG_GATEWAY#${NODE_PORT_MSG_GATEWAY}#g" development.yaml
  sed -i "s#NODE_PORT_SDK_SERVER#${NODE_PORT_SDK_SERVER}#g" development.yaml
  sed -i "s#NODE_PORT_DEMO#${NODE_PORT_DEMO}#g" development.yaml
fi
echo "推送镜像完成" && kubectl -n ${K8S_NAMESPACE} delete -f development.yaml
kubectl -n ${K8S_NAMESPACE} apply -f development.yaml
