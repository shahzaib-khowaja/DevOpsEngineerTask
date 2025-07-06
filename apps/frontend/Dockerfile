# 📦 Stage 1: Build the app
FROM node:16-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install --quiet

# Copy the full source code
COPY . .

# Build the React app
RUN npm run build

# 🚀 Stage 2: Serve the app
FROM node:16-alpine AS runtime

WORKDIR /app

# Install only serve (minimal production deps)
RUN npm install -g serve

# Copy the built static files from the builder
COPY --from=builder /app/build ./build

# Expose the port
EXPOSE 5000

# Serve the static build directory
ENTRYPOINT ["serve", "-s", "build", "-l", "5000"]

