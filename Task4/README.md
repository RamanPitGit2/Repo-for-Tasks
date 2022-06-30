## Task4
Использовал  Always Free arm64 Ubuntu 20.04 в Oracle cloud 24gb RAM, 4 CPU, 47gb root storrage, 200gb /var/lib/containers

### ШАГ 1
установил docker[docker-install.sh](docker-install.sh) 

### ШАГ 2
[custom index.html](index.html#L86)
```
docker run -d -p 80:80 -v /home/roman/Repo-for-Tasks/Task4/index.html:/usr/share/nginx/html/index.html nginxdemos/hello
```
[history](docker-comands.txt)
 
### ШАГ 3
[Dockerfile](Dockerfile)
```
docker build -t mynginx:1 .
docker run --rm -d -e SERVER_NAME=143.47.188.21 -p 80:80 mynginx:1
docker run --rm -d -e DEVOPS="Raman Pitselmakhau 2022;)" -e SERVER_NAME=143.47.188.21 -p 80:80 mynginx:1
```

### ШАГ 4
[GitHub action](https://github.com/RamanPitGit2/Repo-for-Tasks/blob/main/.github/workflows/docker-image.yml)

### ШАГ 5
```
git pull
cd Task4/docker/docker-compose/
bash dependencies.sh
docker compose up -d
docker ps
docker compose down
```
[docker-compose](docker/docker-compose/compose.yaml)
[.env](docker/docker-compose/.env)


P.S [screenshots](screenshot)