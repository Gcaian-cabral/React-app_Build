FROM node:13-alpine as builder
RUN mkdir /client
COPY ./react-app /client
WORKDIR /client
RUN npm install
RUN npm audit fix
RUN npm run build

FROM nginx:stable
COPY --from=builder /client/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY --from=builder /client/nginx.default.conf /etc/nginx/conf.d