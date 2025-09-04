# Use the official Node.js Alpine image
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if exists)
COPY package*.json ./

# Install dependencies (only production if needed)
RUN npm install --only=production

# Copy the rest of the application code
COPY . .

# Expose the app port (default for Node apps)
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
