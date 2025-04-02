FROM nginx:latest

WORKDIR /app

COPY build-packages/dotnet-demoapp.1.5.0.nupkg .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
