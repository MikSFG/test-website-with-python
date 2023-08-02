FROM nginx:1.25.0-alpine
RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf /usr/share/nginx/html/*
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/
EXPOSE 80
EXPOSE 8080