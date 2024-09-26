# List existing S3 buckets
Write-Host "== Delete S3 Objects =="

# Get list of S3 buckets
$buckets = Get-S3Bucket

# Check if there are any buckets
if ($buckets.Count -eq 0) {
    Write-Host "No buckets found."
    exit
}

# Print each bucket name with index
Write-Host "Available buckets:"
for ($i = 0; $i -lt $buckets.Count; $i++) {
    Write-Host "$($i + 1). $($buckets[$i].BucketName)"
}

# Prompt user to choose a bucket
$bucketIndex = Read-Host "Enter the index of the bucket you want to delete objects from (or '0' to cancel)"
if ($bucketIndex -eq 0) {
    Write-Host "Deletion canceled."
    exit
}

# Get the selected bucket name
$selectedBucket = $buckets[$bucketIndex - 1].BucketName

# List objects in the selected bucket
$objects = Get-S3Object -BucketName $selectedBucket

# Check if there are any objects
if ($objects.Count -eq 0) {
    Write-Host "No objects found in bucket '$selectedBucket'."
    exit
}

# Print objects in the selected bucket with index
Write-Host "Objects in bucket '$selectedBucket':"
for ($i = 0; $i -lt $objects.Count; $i++) {
    Write-Host "$($i + 1). $($objects[$i].Key)"
}

# Prompt user to choose to delete all objects or specific ones
$deleteAll = Read-Host "Do you want to delete all objects? (yes/no)"
if ($deleteAll.ToLower() -eq "yes") {
    # Confirm with user before deleting all objects
    $confirm = Read-Host "Are you sure you want to delete all objects from bucket '$selectedBucket'? (yes/no)"
    if ($confirm.ToLower() -eq "yes") {
        Remove-S3Object -BucketName $selectedBucket -Force
        Write-Host "All objects deleted successfully from bucket '$selectedBucket'."
    } else {
        Write-Host "Deletion canceled."
    }
} else {
    # Prompt user to enter the index of the object to delete
    $objectIndex = Read-Host "Enter the index of the object you want to delete (or '0' to cancel)"
    if ($objectIndex -eq 0) {
        Write-Host "Deletion canceled."
        exit
    }

    # Get the selected object key
    $selectedObject = $objects[$objectIndex - 1].Key

    # Confirm with user before deleting the object
    $confirm = Read-Host "Are you sure you want to delete object '$selectedObject' from bucket '$selectedBucket'? (yes/no)"
    if ($confirm.ToLower() -eq "yes") {
        Remove-S3Object -BucketName $selectedBucket -Key $selectedObject -Force
        Write-Host "Object '$selectedObject' deleted successfully from bucket '$selectedBucket'."
    } else {
        Write-Host "Deletion canceled."
    }
}
