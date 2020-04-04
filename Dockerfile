FROM node:12.16.1-alpine AS build

RUN mkdir -p /app
ADD . /app

WORKDIR /app/client
RUN yarn install
RUN yarn build

FROM openjdk:8-jdk-slim

COPY --from=build /app/server /app/server
WORKDIR /app/server
RUN mv ./gradlew ./gradlew.tmp
RUN sed 's/\r$//' ./gradlew.tmp > ./gradlew
RUN chmod 755 ./gradlew
RUN ./gradlew bootJar

WORKDIR /app/server/build/libs

EXPOSE 8080

CMD java -jar server-0.0.1-SNAPSHOT.jar