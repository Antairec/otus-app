FROM node:20.19-alpine as build
WORKDIR /app
COPY documents-api/ ./
RUN npm install && npm run build
FROM node:20.19-alpine
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package*.json /app/.env ./
EXPOSE 3002
CMD ["npm", "run", "start:prod"]
