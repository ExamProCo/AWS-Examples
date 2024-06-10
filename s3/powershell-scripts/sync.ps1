param (
    [string]$BUCKET_NAME = $(Read-Host -Prompt "Enter the bucket name"),
    [string]$FILENAME_PREFIX = $(Read-Host -Prompt "Enter the filename prefix")
)

Write-Host "== Sync"

# Set the output directory
$outputDir = "C:\Temp\s3-powershell-scripts"

# Remove existing directory if present
if (Test-Path -Path $outputDir -PathType Container) {
    Remove-Item -Path $outputDir -Recurse -Force
}

# Create the directory
New-Item -ItemType Directory -Path $outputDir | Out-Null

# Generate random number to determine number of files to create
$NumFiles = Get-Random -Minimum 5 -Maximum 10

# Generate and sync files
for ($i = 1; $i -le $NumFiles; $i++) {
    $Filename = "$outputDir\$($FILENAME_PREFIX)_$i.txt"
    # Generate random content
    $Content = [Convert]::ToBase64String((Get-Random -Count 1024 -InputObject (0..255) | ForEach-Object { [byte]$_ }))
    # Write content to file
    Set-Content -Path $Filename -Value $Content -Encoding Byte
    Write-Host "Created file: $Filename"
}

# Display directory tree
Write-Host "Directory Tree:"
Get-ChildItem -Path $outputDir -Recurse | Format-Table -AutoSize

# Sync the files to the specified S3 bucket
Write-Host "Syncing files to bucket '$BUCKET_NAME'..."
aws s3 sync $outputDir "s3://$BUCKET_NAME/files"

# Check if synchronization was successful
if ($LASTEXITCODE -eq 0) {
    Write-Host "Synchronization to bucket '$BUCKET_NAME' successful."
} else {
    Write-Host "Failed to synchronize files to bucket '$BUCKET_NAME'."
}
