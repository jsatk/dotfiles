function jesus_fucking_christ_docker --description 'When Docker is just insistent on being a complete asshole'
  docker stop (docker ps -aq); and docker rm (docker ps -aq); and docker rmi -f (docker images -q); and docker volume rm (docker volume ls -q)
end
