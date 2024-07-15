# Easybackend-Remote DB

## Build & Run Commands

- To Build Jar file
### ./mvnw clean package -DskipTests

- To build and start a Docker container with the services defined in a Dockerfile.
### docker build -t easybackend . && docker run -p 9999:9999 easybackend
