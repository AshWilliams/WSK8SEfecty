FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine AS build
WORKDIR /src
COPY ["DemoEfecty.csproj", ""]
RUN dotnet restore "DemoEfecty.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "DemoEfecty.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish -o /app/ -c Release 

FROM base AS final
ENV GitHub=github.com

WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "DemoEfecty.dll"]