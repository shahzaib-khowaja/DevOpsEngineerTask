# 📦 Stage 1: Build the apps
FROM node:10-alpine AS builder
WORKDIR /app

COPY package*.json ./
# Install dependencies
RUN npm install --quiet

# Copy the full source code
COPY . ./

# Build the React app
RUN npm run build:prod

# 🚀 Stage 2: Serve the app
FROM node:10-alpine AS runtime
WORKDIR /app

# add user and group
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001 -G nodejs

#create directory and give permission
RUN mkdir -p /app/uploads && chown -R nodejs:nodejs /app/uploads

# Copy the build files only
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/build ./build

USER nodejs

# Expose the port
EXPOSE 8000

# Start application
ENTRYPOINT ["node", "build/index.js"]

