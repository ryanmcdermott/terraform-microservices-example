docker build -t fe .
docker tag fe:latest $TF_VAR_docker_repo/fe:latest
docker push $TF_VAR_docker_repo/fe:latest
