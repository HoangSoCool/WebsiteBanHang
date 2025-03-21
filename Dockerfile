# Sử dụng hình ảnh .NET SDK để xây dựng ứng dụng
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Sao chép tệp dự án và khôi phục các phụ thuộc
COPY *.csproj ./
RUN dotnet restore

# Sao chép toàn bộ mã nguồn và xây dựng ứng dụng
COPY . ./
RUN dotnet publish -c Release -o /publish

# Sử dụng hình ảnh .NET Runtime để chạy ứng dụng
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /publish .
ENTRYPOINT ["dotnet", "WebsiteBanHang.dll"]
