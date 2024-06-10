# Set the script to exit immediately if any command fails
$ErrorActionPreference = "Stop"

# Heading
Write-Host "Creating 5 Random Files and Displaying Directory Tree"

# Define the output directory
$outputDir = "$env:TEMP\s3-temp-powershell-scripts"

# Remove the directory if it already exists
if (Test-Path $outputDir -PathType Container) {
    Write-Host "Removing existing directory: $outputDir"
    Remove-Item $outputDir -Recurse -Force
}

# Create the directory
New-Item -ItemType Directory -Path $outputDir | Out-Null

# Generate 5 random files
for ($i = 1; $i -le 5; $i++) {
    # Generate a random filename
    $filename = Join-Path $outputDir "file$i.txt"
    # Generate random content
    $content = [Convert]::ToBase64String((Get-Random -Count 32 -InputObject (0..255)))
    # Write content to file
    $content | Out-File -FilePath $filename
    Write-Host "Created file: $filename"
}

# Display directory tree
Write-Host "Directory Tree:"
Get-ChildItem $outputDir -Recurse | Format-Wide -Property FullName
