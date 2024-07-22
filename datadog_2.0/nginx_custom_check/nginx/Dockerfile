FROM nginx:latest


COPY nginx.conf /etc/nginx/nginx.conf
RUN apt-get update && apt-get install -y nginx-extras
CMD ["nginx", "-g", "daemon off;"]
