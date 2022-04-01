#!/bin/bash

nowDir=$(pwd)

if [ ! -f "./Open-IM-Server.tar.gz" ];then

rm -rf Open-IM-Server;
rm -rf Open-IM*.tar.gz;
git clone https://github.com/OpenIMSDK/Open-IM-Server.git --recursive --depth=1 && \
cd Open-IM-Server/cmd/Open-IM-SDK-Core && git pull && \
cd internal/sdk_advanced_function && \
git pull && \
cd ${nowDir} && \
tar -zcvf Open-IM-Server.tar.gz Open-IM-Server && \
rm -rf Open-IM-Server;

fi