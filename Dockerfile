FROM maven:3.8.3-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim

COPY --from=build /target/easybackend-0.0.1-SNAPSHOT.jar easybackend.jar
EXPOSE 9999

ENV MONGODB_URI=mongodb+srv://admin:admin%403%24@easy-backend.wezdv6j.mongodb.net/?retryWrites\\=true&w\\=majority
ENV REDIS_HOST=redis-15241.c264.ap-south-1-1.ec2.redns.redis-cloud.com
ENV REDIS_PASSWORD=DvitSeB2aw3ydjqMdx7mxAQBmp5PF9Nq
ENV REDIS_PORT=15241

ENTRYPOINT ["java","-jar","app.jar"]
