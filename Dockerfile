FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
RUN dotnet tool install --global haveibeenpwned-downloader

FROM mcr.microsoft.com/dotnet/aspnet:6.0
RUN mkdir -p /data /root/.dotnet/tools
WORKDIR /data
COPY --from=build /root/.dotnet/tools /root/.dotnet/tools
ENV PATH=$PATH:/root/.dotnet/tools
ENTRYPOINT ["haveibeenpwned-downloader"]
CMD ["-o $(date +%F)_pwnedpasswords.txt"]
