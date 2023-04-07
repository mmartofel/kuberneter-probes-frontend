
docker stop -t 1 angular
docker rm angular

docker build -t angular/demo:latest .

docker run -d -p 4200:4200 --name angular angular/demo:latest

# docker exec -ti angular /bin/bash

