docker build -t api .
docker tag api:latest $TF_VAR_docker_repo/api:latest
docker push $TF_VAR_docker_repo/api:latest