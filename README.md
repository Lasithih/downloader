
# Vortex - Download Manager

Vortex is a download manager with a interactive web interface.

## Quick start with docker compose

    version: '3'
		services:
		  download-manager:
		    container_name: Download_Manager
		    image: 'lasithih/vortex'
		    restart: always
		    volumes:
		      - ~/Downloads:/app/downloader/downloads
		      - /etc/localtime:/etc/localtime:ro
		      - ~/Downloads/DownloadManager/data:/app/downloader/data
		      - ~/Downloads/DownloadManager/logs:/app/downloader/logs
		    environment:
		      - SECRET_KEY=33KNxu84ZzNu
		      - DASHBOARD_USERNAME=admin
		      - DASHBOARD_PASSWORD=password
		    ports:
		      - "5000:5000"
http://localhost:5000
<br>
![Capture7](https://user-images.githubusercontent.com/12048316/119863586-57ad1700-bf37-11eb-83f4-b67c7fe9457d.PNG)
## How to use this image
```
docker run --name vortex-downloader -d lasithih/vortex
```

### Exposing web interface port
```
docker run \
 --name vortex-downloader \
 -p 5000:5000 \
 -d lasithih/vortex
```
Go to http://localhost:5000 on your browser to access the web interface. <br>
Default username: admin<br>
Default password: admin<br>
To change default credentials, see  Environment Variables

<br>

### Mounting download/data/log directories<br>
**/app/downloader/downloads** - Vortex stores downloads in this directory<br>
**/app/downloader/data** - Directory that stores the database with the download jobs<br>
**/app/downloader/logs** - Keeps logs<br>
**/etc/localtime:/etc/localtime:ro** - Important to sync time with the host (for off-peak downloads)
```
docker run \
 --name vortex-downloader \
 -p 5000:5000 \
 -v your/path/to/downloads:/app/downloader/downloads \
 -v your/path/to/data:/app/downloader/data \
 -v your/path/to/logs:/app/downloader/logs\
 -d lasithih/vortex
```

### Environment Variables
```
docker run \
 --name vortex-downloader \
 -p 5000:5000 \
 -v your/path/to/downloads:/app/downloader/downloads \
 -v your/path/to/data:/app/downloader/data \
 -v your/path/to/logs:/app/downloader/logs\
 -e SECRET_KEY=my-secret-key
 -d lasithih/vortex
```
<br>

### Environment Variables List

| Variable name | Description |
|--|--|
| SECRET_KEY | (Required) A key for sqlite database |
| DASHBOARD_USERNAME | (Optional) Username to login to web interface (Default: admin) |
| DASHBOARD_PASSWORD | (Optional) Password to login to web interface (Default: admin) |

