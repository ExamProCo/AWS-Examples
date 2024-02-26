<powershell>
# If this script is not working check what version of PowerShell you have
# You can do this by entering in the $PSVersionTable variable.
# At the time of the script the Windows Servers on AWS was showing PowerShell 5.1 Desktop Edition
# $PSVersionTable


# Define download URL for Apache HTTP Server (Update the URL to the latest version)
# https://www.apachelounge.com/download/
$downloadUrl = "https://www.apachelounge.com/download/VS17/binaries/httpd-2.4.58-240131-win64-VS17.zip"

# Define where to save the downloaded zip
$zipPath = "C:\apache.zip"

# Download Apache HTTP Server zip
# Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath -MaximumRedirection 5

# Invote-WebRequest was getting 308 redirect refuses to work with proper flag
# So we can use the web client to download instead.
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($downloadUrl,$zipPath)

# Define the extraction path
$extractPath = "C:\Apache24"

# Extract the zip file
Expand-Archive -Path $zipPath -DestinationPath $extractPath

# Remove the downloaded zip file to save space
Remove-Item -Path $zipPath

# Apache HTTP Server configuration steps (if necessary)
# For example, editing httpd.conf to adjust server settings

# Path to the Apache Service Monitor executable
$serviceMonitorPath = Join-Path -Path $extractPath -ChildPath "bin\ApacheMonitor.exe"

# Install Apache as a Windows service (using the httpd.exe with the -k install option)
$httpdPath = Join-Path -Path $extractPath -ChildPath "bin\httpd.exe"
Start-Process -FilePath $httpdPath -ArgumentList "-k install" -Wait

# Start the Apache service
Start-Service -Name "Apache2.4"

# Optionally, use ApacheMonitor.exe to manage the Apache service
# Start-Process -FilePath $serviceMonitorPath
</powershell>