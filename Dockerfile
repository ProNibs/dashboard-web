FROM node:lts-slim as build

WORKDIR /app

# If we just copy package.json
# Won't need to do a re-build all the time
COPY package.json .
RUN yarn install

COPY . .
RUN yarn build

EXPOSE 3000
#ENTRYPOINT [ "/bin/sh", "npm"]
# If running standalone in a dev-way
CMD ["yarn", "run", "start"]

FROM nginx:alpine
WORKDIR /app
# Copy to nginx default serving area
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80