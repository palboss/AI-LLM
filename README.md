# AI-LLM

## docker-compose 一键部署 postgresql/new-api/openwebui/nextchat


### 数据路径设置

项目文件路径： 		/home/ai
psql数据路径： 		/var/ai/psql/data
newapi数据路径：		/var/ai/newapi/data
openwebui数据路径：	/var/ai/openwebui/data

"""
cd /home
mkdir -p ./ai ./ai/newapi ./ai/openwebui
mkdir -p /var/ai/psql/data
mkdir -p /var/ai/newapi/data  
mkdir -p /var/ai/openwebui/data
"""

### docker-compose.yml 文件
因为open-webui 是部署在国内服务器上，所以在拉镜像时，加了国内源和环境
psql的数据库用户名和密码，要修改成自已的，不要用yml文件的密码。

