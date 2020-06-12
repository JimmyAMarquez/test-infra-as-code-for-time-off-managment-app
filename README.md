# DevOps test

The following image illustrates the solution implemented for this challenge we have use docker as the main unit of services along with docker compose to orchestrate the containers.

The following containers runs on our infrastructure:
  - Jenkins build server, this server is already configured with all plugings and components necessary to seamleslly run the required pipeline to continuously deploy the changes done by a developer in the organization 
  - Git server Gogs, this is the main repository which contains the code and also the the required githooks to trigger a build whenever we push the code to master branch
  - Nexus artifactory, this is the artifactory repository which is the one the saves all the Docker images that are generated in master so it is very easy to go back to a previous version if anything fails, in the future a new job can be created in jenkins to achive this taks.
  - Node app container runs a alpine type image which makes it very light and contains all the required dependencies to run the app.

![alt text](https://github.com/JimmyAMarquez/test-infra-as-code-for-time-off-managment-app/blob/master/images/DevOps2.jpg?raw=true)
 
### The following Operating System and docker/docker-compose was used to develop this solution.

* Linux debian10 4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11) x86_64 GNU/Linux
* Docker version 19.03.9, build 9d988398e7
* docker-compose version 1.25.5, build 8a1c60f6

### Installation

Please run the following commands to clone repository

```sh
$ git clone https://github.com/JimmyAMarquez/test-infra-as-code-for-time-off-managment-app.git
```

Then go to folder:

```sh
$ cd test-infra-as-code-for-time-off-managment-app
```

Run the following command to set some env variables that are used for the docker-compose file this is only run once:

```sh
$ source ./setup_env.sh
```

After that you need to run the docker-compose command to be able to run the containers:
```sh
$ docker-compose up -d
```
Then after that we will have to wait the compose file to orchestrate everything needed to download the specific images as well as to spin the containers this may take 5 to 8 minutes.

### Exploring the containers

Please go to the following url in your browser:
```sh
http://localhost:10080/
```
and use the following credentials: root/password

You will be able to see this repository already setup in the gogs git container, please clone the timeoff-management-application repository anywhere you want in your system and proceed to push a change to trigger a build.

![alt text](https://github.com/JimmyAMarquez/test-infra-as-code-for-time-off-managment-app/blob/master/images/gogs.png?raw=true)

Please go to the following url in your browser to see your jenkins server running:
```sh
http://localhost:8080/
```
and use the following credentials: admin/password

In here you will find the jenkins server with the timeoff-management-application-job as following:

![alt text](https://github.com/JimmyAMarquez/test-infra-as-code-for-time-off-managment-app/blob/master/images/pipelinefinished.png?raw=true)

After you clone the timeoff-management-application using 
```sh
git clone http://localhost:10080/root/timeoff-management-application.git
```
and push a change you will be able to see the pipeline progress like this! 

![alt text](https://github.com/JimmyAMarquez/test-infra-as-code-for-time-off-managment-app/blob/master/images/pipelineprogress.png?raw=true)

The pipeline has 4 stages:
* Fetching, pull the changes from our gogs repository
* Build image, creates an ephimeral container to build our image.
* Push image, pushes an image to our nexus repository.
* Deploy, it deploys our image to our docker deamon.

If you want to see the nexus docker images that are being archived please go to:
```sh
http://localhost:8081/
```
and use the following credentials: admin/password

![alt text](https://github.com/JimmyAMarquez/test-infra-as-code-for-time-off-managment-app/blob/master/images/nexusartifacts.png?raw=true)

And this is the site running:

![alt text](https://github.com/JimmyAMarquez/test-infra-as-code-for-time-off-managment-app/blob/master/images/site.png?raw=true)


