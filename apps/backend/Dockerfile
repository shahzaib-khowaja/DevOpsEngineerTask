FROM node:10-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install --quiet

COPY . ./
RUN npm run build:prod

FROM node:10-alpine AS runtime
WORKDIR /app

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001 -G nodejs

RUN mkdir -p /app/uploads && chown -R nodejs:nodejs /app/uploads

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/build ./build

USER nodejs

EXPOSE 8000
ENTRYPOINT ["node", "build/index.js"]

