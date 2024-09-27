#!/bin/bash

# 设置数据目录和项目文件目录
PROJECT_DIR="/home/ai"
PSQL_DATA_DIR="/var/ai/psql/data"
NEWAPI_DATA_DIR="/var/ai/newapi/data"
OPENWEBUI_DATA_DIR="/var/ai/openwebui/data"

# 创建所需的目录
mkdir -p $PROJECT_DIR/newapi
mkdir -p $PROJECT_DIR/openwebui
mkdir -p $PSQL_DATA_DIR
mkdir -p $NEWAPI_DATA_DIR
mkdir -p $OPENWEBUI_DATA_DIR

# 创建 docker-compose.yml 文件
cat <<EOF > $PROJECT_DIR/docker-compose.yml
version: '3.8'

services:

  ai_db:
    container_name: ai_db_cn
    image: postgres:latest
    environment:
      TZ: Asia/Shanghai
      POSTGRES_USER: root
      POSTGRES_PASSWORD: your_password_here   # 修改为你的数据库密码
      POSTGRES_DB: oneapi
      PGDATA: /var/lib/postgresql/data/pgdata
    ports:
      - "5432:5432"
    networks:
      - lan
    volumes: 
      - $PSQL_DATA_DIR:/var/lib/postgresql/data/pgdata
    restart: always
    logging:
      driver: "json-file"
      options:
        max-size: "200k"
        max-file: "10"
        
  ai_newapi:
    container_name: ai_newapi_cn
    image: calciumion/new-api:latest
    networks: 
      - lan
    depends_on:
      - ai_db
    ports:
      - "3008:3000"
    environment:
      TZ: Asia/Shanghai
      SQL_DSN: postgres://root:your_password_here@ai_db:5432/oneapi   # 使用与上面一致的数据库密码
    volumes:
      - $NEWAPI_DATA_DIR:/data
    restart: unless-stopped
    logging:
      driver: "json-file"
      options:
        max-size: "200k"
        max-file: "10"

  ai_openwebui: 
    container_name: ai_openwebui_cn
    image: ghcr.nju.edu.cn/open-webui/open-webui:main
    volumes: 
      - $OPENWEBUI_DATA_DIR:/app/backend/data
    ports:
      - "3001:8080"
    environment:
      - HF_ENDPOINT=https://hf-mirror.com/
    restart: always
    logging:
      driver: "json-file"
      options:
        max-size: "200k"
        max-file: "10"

  ai_nextchat:
    container_name: ai_nextchat_cn
    image: yidadaa/chatgpt-next-web
    ports:
      - "3002:3000"
    restart: unless-stopped
    logging:
      driver: "json-file"
      options:
        max-size: "200k"
        max-file: "10"
        
networks:
  lan:
EOF

echo "Docker Compose 文件已创建在 $PROJECT_DIR/docker-compose.yml。请确保数据库密码已更新。"

# 提示用户运行 Docker Compose
echo "请运行以下命令启动服务:"
echo "cd $PROJECT_DIR && docker-compose up -d"