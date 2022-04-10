FROM mcr.microsoft.com/dotnet/runtime:5.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["LongestIncreasingSequence.csproj", "./"]

RUN dotnet restore "LongestIncreasingSequence.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "LongestIncreasingSequence.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "LongestIncreasingSequence.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "LongestIncreasingSequence.dll"]
