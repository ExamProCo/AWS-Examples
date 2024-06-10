# List existing buckets
Write-Host "List of existing buckets:"
$buckets = Get-S3Bucket | Select-Object -ExpandProperty BucketName

# Check if there are any buckets
if (-not $buckets) {
    Write-Host "No buckets found."
    exit 0
}

# Print each bucket name with index
Write-Host "Available buckets:"
for ($i = 0; $i -lt $buckets.Count; $i++) {
    Write-Host "$($i + 1). $($buckets[$i])"
}

# Prompt user to select a bucket by index
do {
    $index = Read-Host "Enter the number corresponding to the bucket you want to delete"
} while (-not ($index -ge 1 -and $index -le $buckets.Count))

$selectedBucket = $buckets[$index - 1]

# Prompt user for confirmation before deleting the bucket
$confirmation = Read-Host "Are you sure you want to delete bucket '$selectedBucket'? (yes/no)"
if ($confirmation -ne "yes") {
    Write-Host "Bucket deletion canceled."
    exit 0
}

# Delete the specified bucket
try {
    Remove-S3Bucket -BucketName $selectedBucket -Force -Confirm:$false
    Write-Host "Bucket '$selectedBucket' deleted successfully."
} catch {
    Write-Host "Failed to delete bucket '$selectedBucket'."
}
