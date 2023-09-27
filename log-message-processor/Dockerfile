# Use the official Python image as base
FROM python:3.6

# Set the working directory in the container
WORKDIR /app

# Copy the application code
COPY . .

# Install application dependencies
RUN pip install -r requirements.txt

# Set environment variables
ENV REDIS_HOST=127.0.0.1
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel

# Command to run the application
CMD ["python3", "main.py"]
