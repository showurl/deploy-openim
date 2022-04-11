FROM golang as build

# go mod Installation source, container environment variable addition will override the default variable value
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct

# Set up the working directory
#WORKDIR /Open-IM-Server
# add all files to the container
#COPY . .

COPY Open-IM-Server.tar.gz /


WORKDIR /
RUN tar -zxvf Open-IM-Server.tar.gz && \
    rm -rf Open-IM-Server.tar.gz && \
    rm -rf /Open-IM-Server/internal/api/third/ali_oss_credential.go && \
    rm -rf /Open-IM-Server/pkg/base_info/oss_api_struct.go

COPY build-open_im_api.sh /Open-IM-Server/script
COPY ali_oss_credential.go.txt /Open-IM-Server/internal/api/third/ali_oss_credential.go
COPY oss_api_struct.go.txt /Open-IM-Server/pkg/base_info/oss_api_struct.go

WORKDIR /Open-IM-Server/script
RUN chmod +x *.sh && \
    cd /Open-IM-Server/cmd && sed -i "s#GOARCH=amd64##g" `grep "amd64" -rl .` && \
    cd /Open-IM-Server/script && \
    /bin/sh -c ./build-open_im_api.sh

#Blank image Multi-Stage Build
FROM showurl/openim-base:v2.0.5

#set directory to map logs,config file,script file.
VOLUME ["/Open-IM-Server/logs","/Open-IM-Server/script","/Open-IM-Server/db/sdk"]

#Copy scripts files and binary files to the blank image
COPY --from=build /Open-IM-Server/script /Open-IM-Server/script
COPY --from=build /Open-IM-Server/bin /Open-IM-Server/bin
COPY start-open_im_api.sh /Open-IM-Server/script

WORKDIR /Open-IM-Server/script

CMD ["bash", "start-open_im_api.sh"]
