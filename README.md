# AI-LLM

## docker-compose 一键部署 PostgreSQL, New-API, OpenWebUI, NextChat

### 数据路径设置

在开始之前，请确保您已经设置以下数据路径：

- **项目文件路径**: `/home/ai`
- **PostgreSQL 数据路径**: `/var/ai/psql/data`
- **New API 数据路径**: `/var/ai/newapi/data`
- **OpenWebUI 数据路径**: `/var/ai/openwebui/data`

您可以通过以下命令创建所需目录：

```bash

cd /home
mkdir -p ./ai ./ai/newapi ./ai/openwebui
mkdir -p /var/ai/psql/data
mkdir -p /var/ai/newapi/data  
mkdir -p /var/ai/openwebui/data
```

### docker-compose.yml 文件
在部署 open-webui 时，由于其在国内服务器上，因此我们将使用国内源来拉取镜像。
同时，请注意，PostgreSQL 的数据库用户名和密码需要修改为您自己的，以确保安全性。请不要使用示例文件中的密码。