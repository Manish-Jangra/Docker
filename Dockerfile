# Pulling Windows10 v1809
FROM mcr.microsoft.com/windows:1809
LABEL Description="PATHWAVE" Vendor="Microsoft" Version="1"

# Changing PowerShell Execution Policy and Installing Chocolatey
RUN powershell -Command Set-ExecutionPolicy Bypass -Force
RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN powershell -Command choco --version

# Installing Google Chrome
RUN powershell -Command choco feature enable -n allowGlobalConfirmation
RUN powershell -Command choco install googlechrome -y

# Installing JAVA
RUN powershell -Command choco install jre8

# Installing Node JS
RUN powershell -Command choco install nodejs

# Installing Git
RUN powershell -Command choco install git
