FROM node:lts-slim as build

WORKDIR /app

# If we just copy package.json
# Won't need to do a re-build all the time
COPY package.json .
RUN yarn install

COPY . .
RUN yarn build

EXPOSE 3000
# If running standalone in a dev-way
#ENTRYPOINT [ "/bin/sh", "npm"]
CMD ["yarn", "run", "start"]

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
# Copy to nginx default serving area
COPY --from=build /app/build .

# Set environment variables via script that runs on startup
WORKDIR /docker-entrypoint.d/
COPY set_environment_variables.sh .

RUN chmod +x set_environment_variables.sh
EXPOSE 80

# Back to default in case we ever need to debug stuff
WORKDIR /usr/share/nginx/html