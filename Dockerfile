FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY target/chatbot*.war /app/app.war
RUN ln -s /app/app.war /app/chatbot.war

EXPOSE 80

ENTRYPOINT ["java", "-jar", "/app/chatbot.war"]
