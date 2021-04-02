
FROM node:latest
MAINTAINER  prathibha
RUN echo "Build Node Js application"
WORKDIR /app
ADD . /app
RUN npm install
EXPOSE 3000
CMD npm start
