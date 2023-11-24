# Use a base image
FROM ubuntu:latest

# Set the working directory to /app
WORKDIR /app

# Download the binary file from Nexus (assuming /app is the working directory)
ARG NEXUS_URL=http://13.51.237.201:8081
ARG NEXUS_REPOSITORY=app-web
ARG BINARY_FILE_PATH=in%2Fjavahome%2Fchatbot%2F1.0-SNAPSHOT
RUN curl -O "${NEXUS_URL}/${NEXUS_REPOSITORY}/${BINARY_FILE_PATH}"

# (Optional) Other Dockerfile instructions

# Define any environment variables if needed
ENV MY_VARIABLE=value

# (Optional) Expose ports or define other configuration

# (Optional) Define the command to run your application
CMD ["./your-binary-file"]
