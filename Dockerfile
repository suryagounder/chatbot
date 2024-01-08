FROM adoptopenjdk:11-jre-hotspot

COPY target/chatbot.war /app.war

CMD ["java", "-jar", "/app.war"]
