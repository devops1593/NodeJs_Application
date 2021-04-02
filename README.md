
![image](https://user-images.githubusercontent.com/44673510/113385341-92feef80-93a5-11eb-8156-88a50759445d.png)


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

