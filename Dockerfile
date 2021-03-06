FROM node:alpine as builder
WORKDIR /app
COPY . ./
RUN npm install
RUN npm install web-vitals
RUN npm run build

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]