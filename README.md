# terraform-microservices-example

This project is a simple example of using Terraform to deploy two microservices to AWS (GCP coming soon!) that can communicate with each other via service discovery. The two microservices are a frontend webserver (using Next.js) and a backend API server (using Flask). You can use any framework/libraries you want for these microservices, what's provided here is just a starting point!

## Installation

### AWS

- Ensure you have installed: Terraform, Docker, and Docker Compose.
- Clone this repo.
- Sign up for AWS if you haven't already.
- Create a repository called `fe` in ECR repository console: `https://[YOUR-REGION].console.aws.amazon.com/ecr/create-repository`
- Create a repository called `api` in ECR repository console: `https://[YOUR-REGION].console.aws.amazon.com/ecr/create-repository`
- Copy repository hostname: `[YOUR_DOCKER_REPO_ID].dkr.ecr.[YOUR-REGION].amazonaws.com`
- Set the copied repository hostname to `TF_VAR_docker_repo` in your terminal.
- In your terminal, run: `export TF_VAR_docker_repo=[YOUR_DOCKER_REPO_ID]`
- In your terminal, run: `aws ecr get-login-password --region [YOUR-REGION] | docker login --username AWS --password-stdin [YOUR_DOCKER_REPO_ID].dkr.ecr.us-west-2.amazonaws.com`

## Usage

### Deploy

`./deploy.sh`

Terraform will show you a load balancer URL when it has finished deploying. **Wait about 60 seconds** before visiting this as it can take time for all of the resources to come online. When it does, you should see "`Data from API server route /api/foo: bar`" in your browser.

### Undeploy

`./destroy.sh`

### Local Development

`./dev.sh`

Visit `http://localhost:3000` to see the frontend server running!

## Architecture Diagram

Coming soon!

## Credits

Basic Terraform setup:
https://github.com/bradford-hamilton/terraform-ecs-fargate
