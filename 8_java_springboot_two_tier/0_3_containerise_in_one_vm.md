# Stage 4 - Containerise app and db and automate vm
- [Stage 4 - Containerise app and db and automate vm](#stage-4---containerise-app-and-db-and-automate-vm)
  - [Instruction overview and deliverables](#instruction-overview-and-deliverables)
  - [Phase 1: Develop and Test Docker Setup Locally or on VM](#phase-1-develop-and-test-docker-setup-locally-or-on-vm)
  - [phase 2: Dockerize and Publish](#phase-2-dockerize-and-publish)
  - [Phase 2: Integrate with a Database](#phase-2-integrate-with-a-database)
  - [Phase 3: Prepare and check VM Deployment](#phase-3-prepare-and-check-vm-deployment)
  - [Phase 4: Automate with provision script](#phase-4-automate-with-provision-script)

## Instruction overview and deliverables

1. Deploy the app and database on AWS or Azure using containers running on a Virtual Machine (Docker Compose). Automate it via Bash provision scripts that work in user data. (1-2 days)
2. For Stage 4 above:
   - Bash provision script for a single VM that runs in user data but deploys the app and database using containers on the one machine. The containers run by the script should use Docker images already uploaded to Docker Hub.
   - Docker-related files
     * Dockerfile files
     * Docker-compose YAML file
     * Dockerised application images built and ready for deployment

## Phase 1: Develop and Test Docker Setup Locally or on VM
* We want to build a docker image for the java app in this step.
* To run java application stand alone with just the JRE(java runtime engine) and not the JDK(java developer kit) we need a JAR file of the app thats executable.
  
1. Edit the spring boot Environment variables in the `LibraryProject2/src/main/resources/application.properties` file with new variables that docker-compose will replace later in the steps during build time using `docker-compose`. 

- find application.properties:
``` yml
spring.jpa.show-sql=true
spring.datasource.url=jdbc:mysql://localhost:3306/library
spring.datasource.username=root
spring.datasource.password=root
server.port=8008
spring.jpa.hibernate.ddl-auto=update
```
- Replace with these values application.properties
``` yml
# Show SQL queries in logs for debugging
spring.jpa.show-sql=true

# Configure the database connection using the Docker Compose service name if docker-compose environments not used then default values will be used after the colon like this format SPRING_ENV:default_value
spring.datasource.url=${SPRING_DATASOURCE_URL:jdbc:mysql://localhost:3306/library}
spring.datasource.username=${SPRING_DATASOURCE_USERNAME:root}
spring.datasource.password=${SPRING_DATASOURCE_PASSWORD:root}

# Spring Boot application server port
server.port=8008

# Enable Hibernate auto schema updates
spring.jpa.hibernate.ddl-auto=update

# Connection timeout in milliseconds to allow time for mysql to set up before java app tries to connect
spring.datasource.hikari.connection-timeout=20000
spring.datasource.hikari.initialization-fail-timeout=30000
```
2. (Optional) Update Maven `LibraryProject2/pom.xml` to add a profile at the bottom of the file, this helped me during debugging you may not need it  
``` xml
</project>
    ...
    <build>
    ...
    </build>
    <profiles>
        <profile>
            <id>docker</id>
            <activation>
                <activeByDefault>false</activeByDefault>
            </activation>
            <properties>
                <spring.datasource.url>jdbc:mysql://database:3306/library</spring.datasource.url>
                <spring.datasource.username>root</spring.datasource.username>
                <spring.datasource.password>root</spring.datasource.password>
            </properties>
        </profile>
    </profiles>

</project>
```
3. Create JAR file with this command inside `LibraryProject2` folder
``` bash
cd LibraryProject2
mvn clean package -Pdocker -DskipTests
```
   - If you skipped step 2 you don't need `-Pdocker` flag 
   -  `-DskipTests` Don't try to fix the tests, you will still have errors because a MySQL db won't exist during build time

## phase 2: Dockerize and Publish
4. Create Dockerfile, Up to you where you leave it but i left it in base of project file. `/library-java17-mysql-app/Dockerfile` 
``` dockerfile
FROM openjdk:24-slim-bullseye

WORKDIR /usr/app

COPY LibraryProject2/target/LibraryProject2-0.0.1-SNAPSHOT.jar library-app.jar

EXPOSE 8008

ENTRYPOINT ["java", "-jar", "library-app.jar"]
```
   - Used a slim version of java, didnt want alpine incase of missing dependencies
   - since my dockerfile is located outside project my path to jar file i had to make sure path was correct
   - `ENTRYPOINT` used instead of `CMD` because we don't need it overridden and we have the option to add additional arguements like a single purpose app
  
5. Build Docker Image. inside `library-java17-mysql-app` folder
``` bash
   cd ..
   docker build -t raiyans/library-app:v2 .
``` 

6. Push Docker image. (If your super confident it will work straight away)
``` bash 
docker push raiyans/library-app:v2
```

7. Test the Docker Image Locally:
   * Like mentioned before if you try to run the image without a database currently you will have an error the way app is built.
``` bash 
docker run -p 8008:8008 library-app:v2
```


## Phase 2: Integrate with a Database

1. Created a `docker-compose.yml` File in the same place as where your `Dockerfile` is.
``` yml
services:
  database:  # Define a service named "database"
    image: mysql:8.0  # Use the MySQL image from Docker Hub
    container_name: database  # Set the container name to "database"
    environment:  # Environment variables for the MySQL container
      MYSQL_ROOT_PASSWORD: root  # Set the root user password for MySQL
      MYSQL_DATABASE: library    # Automatically create a database named "library"
    ports:
      - "3306:3306"  # Map the container's MySQL port (3306) to the host's port 3306
    volumes:
      - db_data:/var/lib/mysql  # Use a named volume "db_data" to persist MySQL data
      - ./library.sql:/docker-entrypoint-initdb.d/library.sql  # Mount the local `library.sql` file to seed the database on container initialization first time

  app:  # Define a service named "app"
    image: raiyans/library-app:v2  # Use the Docker image for your Spring Boot application
    container_name: spring-app  # Set the container name to "spring-app"
    environment:  # Environment variables for the Spring Boot application
      SPRING_DATASOURCE_URL: jdbc:mysql://database:3306/library  # Database URL pointing to the "database" service
      SPRING_DATASOURCE_USERNAME: root  # MySQL username
      SPRING_DATASOURCE_PASSWORD: root  # MySQL password
    ports:
      - "8008:8008"  # Map the container's application port (8008) to the host's port 8008
    depends_on:
      - database  # Ensure the "database" service starts before this service but won't be enough time still

volumes:
  db_data:  # Define a named volume to persist MySQL data
```
2. Run docker-compose file:
``` bash
docker compose down  # Use `-v` if you made mistakes and need to retest without pre-existing volumes
docker compose up # `--build` if you want to Build images before starting containers. `-d` run container in background.

```
3. You should see on your localhost the webpage and a persistant db on restarts
* Terminal of successful launch on local machine
![terminal](/images/java-docker-compose-term-1.png)
![terminal](/images/java-docker-compose-term-2.png)
<br>

## Phase 3: Prepare and check VM Deployment

1. Get github repo ready all you need is project files (Dockerfile, docker-compose.yml, library.sql) on the vm. But I am conveniently just keeping it in the same repo as the app.
![files](/images/java-docker-files.png)
<br>

2. Create a EC2 instance with  **Ubuntu Server 22.04 LTS (HVM), SSD Volume Type**,  **t2.micro**, whatever Key pair you need, Create Security group allowing inbound **SSH** & **Http**.
3. Connect to EC2
4. Do a `apt update and upgrade` 
5. install docker 
``` bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
6. get the files you need `git clone https://github.com/raiyans/library-java17-mysql-app.git repo` 
7. run the compose command
``` bash
sudo docker compose down
sudo docker compose up --build -d
```
8. check if it works on the public ip and don't forget the port number 8008 cause we didnt use reverse proxy

## Phase 4: Automate with provision script
- [bash script](/script_reference/8_3_docker_compose_app_db.sh)
```bash 
#!/bin/bash
TOKEN="insert github pat token"

# Define variables
REPO_URL="https://raiyans:$TOKEN@github.com/raiyans/library-java17-mysql-app.git"
APP_DIR="repo"

# Update and install prerequisites
echo "Updating system and installing prerequisites..."
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git curl apt-transport-https ca-certificates software-properties-common

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Start and enable Docker service
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version

# Clone the repository
echo "Cloning the repository..."
git clone "$REPO_URL" "$APP_DIR"
cd "$APP_DIR"

# Start the application with Docker Compose
echo "Starting the application with Docker Compose..."
sudo docker compose down
sudo docker compose up --build -d

# Verify that containers are running
echo "Verifying running containers..."
docker ps

```