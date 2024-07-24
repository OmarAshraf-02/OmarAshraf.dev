# First stage: build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# Copy solution and project files to the build container
COPY OmarAshraf.dev.sln .
COPY OmarAshraf.dev.csproj ./

# Restore dependencies
RUN dotnet restore

# Copy the remaining source code and build the application
COPY . .
RUN dotnet publish -c release -o /app --no-restore

# Final stage: runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "OmarAshraf.dev.dll"]
