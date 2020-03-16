FROM node:12.14.0-alpine
RUN apk add --no-cache git

WORKDIR /court-backend

# copy root package and lerna json files
COPY ./package.json /court-backend/package.json
COPY ./lerna.json /court-backend/lerna.json

# copy app package json
RUN mkdir -p /packages/app
COPY ./packages/app/package.json /court-backend/packages/app/package.json

# copy cli package json
RUN mkdir -p /packages/cli
COPY ./packages/cli/package.json /court-backend/packages/cli/package.json

# copy server package json
RUN mkdir -p /packages/server
COPY ./packages/server/package.json /court-backend/packages/server/package.json

# copy services package json
RUN mkdir -p /packages/services
COPY ./packages/services/package.json /court-backend/packages/services/package.json

# install dependencies
RUN npm install
RUN npx lerna bootstrap

COPY . .

CMD ["echo", "starting..."]
