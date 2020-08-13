docker build -t api .
docker tag api:latest [FILL_IN].dkr.ecr.us-west-2.amazonaws.com/api:latest
docker push [FILL_IN].dkr.ecr.us-west-2.amazonaws.com/api:latest