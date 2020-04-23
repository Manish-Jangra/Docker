FROM mcr.microsoft.com/windows:1909
LABEL Description="Regression" Target="Windows10" Version=1
VOLUME ["D:"]      # This creates D Drive

# Changing PowerShell Execution Policy and Installing Chocolatey and Installing Other Tools
RUN powershell -Command \
	Set-ExecutionPolicy Bypass -Force ; \
 	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) ; \
 	choco --version ; \
 	choco feature enable -n allowGlobalConfirmation ; \
 	choco install git ; \
 	choco install python2 ; \
  	choco install jre8 ; \
 	choco install googlechrome -y
RUN NET USER regress "QA@123qa" /add ; \
    NET LOCALGROUP Administrators /add regress ; \
    setx /M HOMEPATH "users\regress" ; \
    mkdir -p C:\tmp
SHELL ["powershell"]
ADD .ssh /Users/username/.ssh      # This add .SSH Keys for the user
