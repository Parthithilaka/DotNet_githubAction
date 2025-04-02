# Stage 1: Extract the .nupkg Package
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copy the package from the GitHub repository
COPY build-packages/dotnet-demoapp.1.5.0.nupkg .

# Extract the .nupkg package (assuming it contains a .NET Core app)
RUN mkdir -p /publish && \
    dotnet nuget locals all --clear && \
    dotnet tool install --global NuGetPackageExplorer && \
    NuGetPackageExplorer extract dotnet-demoapp.1.5.0.nupkg -OutputDirectory /publish

# Stage 2: Use NGINX to Serve the Application
FROM nginx:latest
WORKDIR /usr/share/nginx/html

# Copy the extracted application from the previous stage
COPY --from=build /publish/ .

# Copy custom NGINX configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
