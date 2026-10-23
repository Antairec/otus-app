FROM node:20.19-alpine as build
WORKDIR /app
COPY users-api/ ./
RUN npm install && npm run build
FROM node:20.19-alpine
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package*.json /app/.env ./
EXPOSE 3000
CMD ["npm", "run", "start:prod"]
