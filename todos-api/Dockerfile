# Use the official NodeJS image as base
FROM node:8.17.0

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the application code
COPY . .

# Expose the port the service listens on
ENV TODO_API_PORT=8082
EXPOSE $TODO_API_PORT

# Command to run the application
CMD ["npm", "start"]
