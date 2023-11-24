# Use a base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Download the binary file from Nexus
ARG NEXUS_URL
ARG NEXUS_REPOSITORY
ARG BINARY_FILE_PATH
RUN curl -O ${NEXUS_URL}/${NEXUS_REPOSITORY}/${BINARY_FILE_PATH}

# (Optional) Other Dockerfile instructions

# Define any environment variables if needed
ENV MY_VARIABLE=value

# (Optional) Expose ports or define other configuration

# (Optional) Define the command to run your application
CMD ["./your-binary-file"]
