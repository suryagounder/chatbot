# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the WAR file from the target directory to the container
COPY target/chatbot.war ./app.war

# Command to run your application
CMD ["java", "-jar", "app.war"]
