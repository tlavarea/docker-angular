# Builder phase to build the app
FROM node:18-alpine AS builder

WORKDIR /app

COPY *.json .
COPY karma.conf.js .

RUN npm i

COPY src/ ./src/

RUN npm run build

# Create nginx container
FROM nginx:latest

COPY --from=builder /app/dist/frontend /usr/share/nginx/html
