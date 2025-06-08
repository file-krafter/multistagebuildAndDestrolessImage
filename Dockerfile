# File: Dockerfiles
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY target/first-sbwebapp-on-docker-2-1.0-SNAPSHOT.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]
