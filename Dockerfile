FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY ./target/*.war /chatbot.war

CMD ["java", "-jar", "chatbot.war"]
