# List existing S3 buckets
Write-Host "== Listing S3 Buckets =="

# Get list of S3 buckets with creation dates
$buckets = Get-S3Bucket

# Check if there are any buckets
if ($buckets.Count -eq 0) {
    Write-Host "No buckets found."
    exit
}

# Sort buckets by creation date (newest first)
$sortedBuckets = $buckets | Sort-Object -Property CreationDate -Descending

# Print each bucket name (newest first)
Write-Host "Found bucket or buckets (newest first):"
foreach ($bucket in $sortedBuckets) {
    Write-Host $bucket.BucketName
}
