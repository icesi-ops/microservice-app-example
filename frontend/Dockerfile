# Use the official Node.js image as base
FROM node:8.17.0

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Set environment variables
ENV PORT=8080
ENV AUTH_API_ADDRESS=http://auth-api:8000
ENV TODOS_API_ADDRESS=http://todos-api:8082

# Expose the port on which the application will run
EXPOSE $PORT

# Command to start the application
CMD ["npm", "start"]
