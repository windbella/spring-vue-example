FROM node:12.16.1-alpine AS build

RUN mkdir -p /app
ADD . /app

WORKDIR /app/client
RUN yarn install
RUN yarn build

FROM openjdk:8-jdk-slim

COPY --from=build /app /app
WORKDIR /app/server
RUN sed $'s/\r$//' ./gradlew > ./gradlew
RUN ./gradlew bootJar

WORKDIR /app/server/build/libs

EXPOSE 8080

CMD java -jar server-0.0.1-SNAPSHOT.jar