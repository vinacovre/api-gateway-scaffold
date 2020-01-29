FROM node:12.13.1 AS base

WORKDIR /usr/src/app

COPY package*.json ./

FROM base AS development
RUN npm ci
COPY . .

FROM base AS production
RUN npm ci --production
COPY . .

EXPOSE 3000

CMD [ "npm", "start" ]
