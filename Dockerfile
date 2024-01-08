FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY ./target/*.war /app.war
CMD ["java", "-jar", "/app.war"]
