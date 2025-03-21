# Sử dụng .NET SDK để build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copy file project và khôi phục dependencies
COPY ./WebsiteBanHang/*.csproj ./
RUN dotnet restore

# Copy toàn bộ source code và build
COPY ./WebsiteBanHang/ ./
RUN dotnet publish -c Release -o /publish

# Sử dụng .NET runtime để chạy ứng dụng
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /publish .
CMD ["dotnet", "WebsiteBanHang.dll"]