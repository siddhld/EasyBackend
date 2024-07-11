# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/easybackend-0.0.1-SNAPSHOT.jar app.jar

# Expose the port the app runs on
EXPOSE 9999

ENV MONGODB_URI=mongodb+srv://admin:admin%403%24@easy-backend.wezdv6j.mongodb.net/?retryWrites\=true&w\=majority
ENV REDIS_HOST=redis-15241.c264.ap-south-1-1.ec2.redns.redis-cloud.com
ENV REDIS_PASSWORD=DvitSeB2aw3ydjqMdx7mxAQBmp5PF9Nq
ENV REDIS_PORT=15241

# Run the JAR file
ENTRYPOINT ["java","-jar","app.jar"]