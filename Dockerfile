## File: Dockerfiles
#FROM openjdk:21-jdk-slim
#WORKDIR /app
#COPY target/first-sbwebapp-on-docker-2-1.0-SNAPSHOT.war app.war
#EXPOSE 8080
#ENTRYPOINT ["java", "-jar", "app.war"]
# Stage 1: Build Java App
FROM maven:3.9.4-eclipse-temurin-21 as builder

WORKDIR /app

# Copy pom and source files
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

# Package the app (will create target/app.jar)
RUN mvn clean package -DskipTests

# Stage 2: Run with distroless image
FROM gcr.io/distroless/java21-debian12:nonroot

# Set working dir
WORKDIR /app

# expose 8080 port 
EXPOSE 8080

# Copy only the fat jar from builder stage
COPY --from=builder /app/target/*.jar app.jar

# Run the app
CMD ["app.jar"]

