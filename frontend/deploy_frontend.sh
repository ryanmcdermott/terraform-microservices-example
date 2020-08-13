docker build -t fe .
docker tag fe:latest [FILL_IN].dkr.ecr.us-west-2.amazonaws.com/fe:latest
docker push [FILL_IN].dkr.ecr.us-west-2.amazonaws.com/fe:latest
