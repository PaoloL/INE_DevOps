#### Task-1: Configure the AWS CLI

Disable AWS Managed Temporary Credentials on Cloud 9

Execute `aws configure` and put AK and SK related to you Cloudformation stack

#### Task-2: Install Terraform

Install yum-config-manager to manage your repositories.

```
sudo yum install -y yum-utils
```

Use yum-config-manager to add the official HashiCorp Linux repository.

```
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
```

Install Terraform from the new repository

```
sudo yum -y install terraform
```

Verify Terraform installation

```
terraform -help
```
#### Task-3: Install Docker

Set up the repository

```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

Install Docker Engine

```
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Start Docker


```
sudo systemctl start docker
```

Verify that the Docker Engine installation is successful by running the hello-world image.

```
sudo docker run hello-world
```

This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.

#### Task-4: Initialize Terraform

Clone the repository

```
git clone https://github.com/PaoloL/INE_DevOps
```

Initialize Terraform

```
cd INE_DevOps
```

on `terraform.tfvars` set the variable with the following:
- owner = *your name, lowercase without space (ex. paololatella)*
- aws_region = "eu-west-1"

```
terraform init
```

Validate the Terraform template

```
terraform validate
```

Create an execution plan

```
terraform plan
```

Apply the changes

```
terraform apply
```

### Task-5: Build and Push your Docker Image

Retrieve an authentication token and authenticate your Docker client to your registry.

`aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin <your-repository>`

Now you can start to create the microservices

#### Bikes Microservices
Locate Bikes Microservice folder
```
cd INE_DevOps/BikesMicroservices
```

Modify this part of code on `webservice.py` with this header

```
'headers': {
                "x-custom-version" : "1.0"
                "x-custom-owner" : "<your name>"
            }
```

Build your Docker image using the following command.

`docker build -t bikes:latest .`

Tag your image so you can push the image to this repository:

`docker tag bikes:latest 983441761380.dkr.ecr.eu-west-1.amazonaws.com/<yourname>-bikes_repo:latest`

Run the following command to push this image to your newly created AWS repository:

`docker push 983441761380.dkr.ecr.eu-west-1.amazonaws.com/<yourname>-bikes_repo:latest` 

Your microservice is published

#### Cars Microservices
Locate Cars Microservice folder

```
cd INE_DevOps/CarsMicroservices
```

Modify this part of code on `webservice.py` with this header

```
'headers': {
                "x-custom-version" : "1.0"
                "x-custom-owner" : "<your name>"
            }
```

Build your Docker image using the following command.

`docker build -t cars:latest .`

Tag your image so you can push the image to this repository:

`docker tag cars:latest 983441761380.dkr.ecr.eu-west-1.amazonaws.com/<yourname>-cars_repo:latest`

Run the following command to push this image to your newly created AWS repository:

`docker push 983441761380.dkr.ecr.eu-west-1.amazonaws.com/<yourname>-cars_repo:latest` 

Your microservice is published

### Task-6: Try to pull and run image from other

Pull Docker Image

```
docker pull 983441761380.dkr.ecr.eu-west-1.amazonaws.com/<name>-bikes_repo:latest
```

Run Docker Image:

```
docker run -p 5000:5000 983441761380.dkr.ecr.eu-west-1.amazonaws.com/<name>-bikes_repo:latest
```

Test 

By following these instructions, team members can easily pull and run Docker images created by other participants. If there are any specific configurations or ports that need to be exposed, they should be added to the docker run command accordingly.

### Task-7: Install and Configure the kubectl
The Kubernetes command-line tool, kubectl, allows you to run commands against Kubernetes clusters. You can use kubectl to deploy applications, inspect and manage cluster resources, and view logs.

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

Download kubectl

```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

Setting permission and env

```
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
```

Verify installation

```
kubectl version --client
```

Update kubectl config 

Use `<aws_region> = "eu-west-1"`

```
aws eks update-kubeconfig --region <aws_region> --name <your-name>-my-eks-cluster
```

### Task-8: Create your K8s Deployment
Locate the bikes-deployment.yaml and update with the correct image url

```
containers:
  image: <image-url>
```

Deploy the bikes microservice

```
kubectl apply -f bikes-deployment.yaml
```

Locate the cars-deployment.yaml and update with the correct image url

```
containers:
  image: <image-url>
```

Deploy the cars microservice

```
kubectl apply -f cars-deployment.yaml
```
