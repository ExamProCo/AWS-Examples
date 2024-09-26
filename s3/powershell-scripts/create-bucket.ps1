# Prompt user to enter the bucket name
$BucketName = Read-Host "Enter the name for the new S3 bucket"

# Prompt user to enter the region
$Region = Read-Host "Enter the region for the new S3 bucket"

# Create a new S3 bucket
New-S3Bucket -BucketName $BucketName -Region $Region -ProfileName "MyProfile"

# Check if the bucket was created successfully
if ($?) {
    Write-Host "Bucket '$BucketName' created successfully."
} else {
    Write-Host "Failed to create bucket '$BucketName'."
}
