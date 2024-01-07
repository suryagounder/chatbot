# Use Ubuntu as the base image
FROM ubuntu:latest

# Install OpenJDK 8 and other dependencies
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for Java
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Set the working directory inside the container
WORKDIR /app

# Copy the WAR file from the target directory to the container
COPY target/chatbot.war ./app.war

# Expose the port that your application will run on (adjust if needed)
EXPOSE 8080

# Command to run your application
CMD ["java", "-jar", "app.war"]
