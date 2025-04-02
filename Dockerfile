FROM nginx:latest

WORKDIR /app

COPY ./nuget-packages .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
