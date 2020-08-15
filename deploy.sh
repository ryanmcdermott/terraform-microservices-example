# Deploy API docker image
cd ./api &&
./deploy_api.sh &&

# Deploy Frontend docker image
cd ../frontend &&
./deploy_frontend.sh &&

# Deploy to cloud host (default AWS)
cd ../devops/aws &&
terraform apply