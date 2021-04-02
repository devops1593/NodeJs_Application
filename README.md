
![image](https://user-images.githubusercontent.com/44673510/113386411-d3f80380-93a7-11eb-997e-f4a0415ac187.png)

A simple CI/CD pipeline using Jenkins
We are going to use Jenkins (https://jenkins.io) as our automation server.  When using Jenkins, the central document is the Jenkinsfile, which will contain the definition of the pipeline with its multiple stages.

A simple Jenkinsfile with the Build, Test, Deploy to Staging, and Deploy to Production dev/stag/prod could look like this:



# Simple DevOps Project CI CD Using Node JS 


##### Steps 1 - Install Node Js on Ubuntu Machine 

``` sh 

sudo apt update

sudo apt install nodejs

sudo apt install npm

nodejs -v  // To check the node JS version 

```

##### Step 2 -  Download the Publish Over SSH plugins 

``` sh

Key -- define the private Key ( you will get from .pem while when you will open as text file)

ssh Server - 

Name - define the name of the server.
HostName - Provide the IP address of your server.
UserName - Provide the user name here ex. if we are using Ubuntu ec2 instance then username is ubuntu

Click Save and Apply 

```

##### Step 3 -  Create the Free Style Node JS project .

``` sh 

Git URL - https://github.com/devops1593/NodeJs_Application.git

WebHook Connection URL - http://IPADDRESS/github-webhook/ (push)

BUILD - npm install  // to download all the dependecines 
      - npm test  // to perform test case execution 

tar czf Node.tar.gz node_modules index.js package.json public app.json     
```

##### Step 4 - Post Build Action Define below details.
``` sh 

Source file : **/*.gz 

Exec Command 

mv ./home/ubuntu/one/node-js-sample/Node.tar.gz /home/ubuntu/test/Node.tar.gz;
cd /home/ubuntu/test/
tar -xf Node.tar.gz ;
docker rmi nodeimage;
docker stop nodecontainer;
docker rm nodecontainer;
docker build -t nodeimage .;
docker run -d --name nodecontainer -p 3000:3000 nodeimage;

```

##### Step 5 - Docker File in Node Js server 

``` sh 
FROM node:latest
MAINTAINER  prathibha
RUN echo "Build Node Js application"
WORKDIR /app
ADD . /app
RUN npm install
EXPOSE 3000
CMD npm start
```


By using JenkinsFile:
====================
Pre-requistes
1. Jenkins is up and running
2. Docker installed on Jenkins instance and configured.
3. Docker plug-in installed in Jenkins
4. user account setup in https://cloud.docker.com
5. Required port is opened up in firewall rules.

![image](https://user-images.githubusercontent.com/44673510/113387253-94321b80-93a9-11eb-976a-29057d1bae61.png)


1. Developer pushes a commit to GitHub
2. GitHub uses a webhook to notify Jenkins of the update
3. Jenkins pulls the GitHub repository, including the Dockerfile describing the image, as well as the application and test code.
4. Jenkins builds a Docker image on the Jenkins slave node
5. Jenkins instantiates the Docker container on the slave node, and executes the appropriate tests
6. If the tests are successful the image is then pushed up to Dockerhub or Docker Trusted Registry.

AWS CICD NodeJs :
===============
![image](https://user-images.githubusercontent.com/44673510/113387630-4f5ab480-93aa-11eb-89d5-0ad6cce8a777.png)

![Uploading image.png…]()


1.Developers commit code to an AWS CodeCommit repository and create pull requests to review proposed changes to the production code. When the pull request is merged into the master branch in the AWS CodeCommit repository, AWS CodePipeline automatically detects the changes to the branch and starts processing the code changes through the pipeline.

2.AWS CodeBuild packages the code changes as well as any dependencies and builds a Docker image. Optionally, another pipeline stage tests the code and the package, also using AWS CodeBuild.

3.The Docker image is pushed to Amazon ECR after a successful build and/or test stage.

4.AWS CodePipeline invokes an AWS Lambda function that includes the Kubernetes Python client as part of the function’s resources. The Lambda function performs a string replacement on the tag used for the Docker image in the Kubernetes deployment file to match the Docker image tag applied in the build, one that matches the image in Amazon ECR.

5.After the deployment manifest update is completed, AWS Lambda invokes the Kubernetes API to update the image in the Kubernetes application deployment.

6.Kubernetes performs a rolling update of the pods in the application deployment to match the docker image specified in Amazon ECR.
The pipeline is now live and responds to changes to the master branch of the CodeCommit repository. This pipeline is also fully extensible, you can add steps for performing testing or adding a step to deploy into a staging environment before the code ships into the production cluster.

