# Use the official Node.js image from the DockerHub
FROM node:14

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json /app
RUN npm install

# Copy the rest of the application code
COPY . /app

# Expose the port your app runs on (3000)
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]

#docker build -t my-node-app .
#docker run -p 3000:3000 my-node-app

