# syntax=docker/dockerfile:1
FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04
LABEL org.opencontainers.image.source https://github.com/khoj-ai/khoj
RUN apt-get update && \
    apt-get install --no-install-recommends -y build-essential python3-dev python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install System Dependencies
RUN apt update -y && \
    apt -y install python3-pip git

# Install Application
COPY . .
RUN sed -i 's/dynamic = \["version"\]/version = "0.0.0"/' pyproject.toml && \
    pip install --no-cache-dir .

# Run the Application
# There are more arguments required for the application to run,
# but these should be passed in through the docker-compose.yml file.
ARG PORT
EXPOSE ${PORT}
ENTRYPOINT ["khoj"]
