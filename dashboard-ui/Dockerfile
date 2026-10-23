FROM node:16-alpine as build
WORKDIR /app
COPY dashboard-ui/ ./
RUN yarn install --frozen-lockfile
RUN yarn build
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY dashboard-ui/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
