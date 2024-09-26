# Prompt user to enter the bucket name
$bucketName = Read-Host "Enter the bucket name"

# Check if bucket name is empty
if (-not $bucketName) {
    Write-Host "Bucket name must be provided."
    exit 1
}

# List objects in the specified bucket
Get-S3Object -BucketName $bucketName
