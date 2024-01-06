FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY ./target/*.war /chatbot.war

EXPOSE 80

CMD ["java", "-jar", "chatbot.war"]
