# Stage 1 & 2 - run app locally

## instruction overview and deliverables

1. Create a private GitHub repository to store the Java app and SQL script to seed the database (check your course’s Teams channel’s file section for it or ask your trainer for the ‘library-java17-mysql-app' zip file of the app code). Use the README.md file included with the app code to understand the app. [download](/script_reference/8_0_library-java17-mysql-app.zip) for full prject to start
2. For Stage 1 above: Private GitHub repo for the storage of the app code and SQL script to seed the database. You will need this to do your `git clone` from.


# Steps to see front page
1. I created my private repo on https://github.com/raiyans/library-java17-mysql-app which stored the zip file on github for creating repo ![github](/images/java-github.png). I will not explain how to setup a github repo.
2. I checked the system requirements to run on my macbook in the readMe to see what i needed to run app and db i had to install. `Maven` `Java 17` for app. `MySQL` for db.
3. Since I know its a java app it can run on any machine that has a JVM so my os didnt matter installing with homebrew package manager for mac
``` bash 
brew install java
# for specific versions
# brew install openjdk@17 
java -version
brew install maven
mvn -version\n
brew install mysql
mysql --version
```
* Just what it looked like when i did it
![terminal](/images/java_app_db_libraries.png)

1. I tried to Go into the folder ProjectLibrary2 (this is the "app" folder) and Run `mvn spring-boot:run` with large errors about no db connections
2. Within the project `LibraryProject2/src/main/resources/application.properties` exists and a template of values with `application.properties.bk`
3. edit `application.properties` with 
``` java
spring.jpa.show-sql=true
spring.datasource.url=jdbc:mysql://localhost:3306/library
spring.datasource.username=root
spring.datasource.password=root
server.port=8008
spring.jpa.hibernate.ddl-auto=update
# logging.level.org.hibernate=DEBUG
# logging.level.com.zaxxer.hikari=DEBUG
```
* make sure `spring.datasource.url` value have ip as `localhost` or `127.0.0.1` for running locally
* you will face issues with errors saying mentioning hikari pool connection not occuring

1. Check your browser with the port number and you should see front page displays 
![front page](/images/java-localhost.png)

## steps to see /web/authors data page
* We need to set up mysql and seed the db

1. MySql was already installed with homebrew in earlier step so i just needed to start it as a background process
```bash 
sudo mysql.server status
sudo mysql.server start
sudo mysql.server status
```
![front page](/images/java-mysql-status.png)

2. You can now check into the MySQL db and should be in the MySQL terminal (if you want to exit the session type `exit`) `mysql -u root  -h 127.0.0.1 -P 3306`
![db](/images/java-mysql-login.png)

3. You can skip the bind ip step since by default your bind ip is set to localhost already in `/etc/mysql/mysql.conf.d/mysqld.cnf` should have `bind-address = 127.0.0.1`

4. While Connected to MySQL locally run 
``` sql
-- Verify the connection and list existing databases:
SHOW DATABASES;
-- Create the library database if it doesn’t already exist:
CREATE DATABASE library;
USE library;
```
5. Exit MySQL CLI `exit`

6. To seed DB use this command in terminal to Import the library.sql file directly into the library database:
``` bash 
# make sure you have the right path to library.sql
mysql -u root -p library < ./library.sql
```

7. to check if db directly if seeded use sql cli again `mysql -u root  -h 127.0.0.1 -P 3306` and run queries:
``` sql 
USE library;
SHOW TABLES;
SELECT * FROM <table_name>;
```
8. Now check the webpage if you see data is being displayed and edited 
![display](/images/java-db-page.png)
