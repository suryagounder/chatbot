FROM openjdk:11-jre-alpine

COPY target/chatbot.war /app.war

CMD ["java", "-jar", "/app.war"]
