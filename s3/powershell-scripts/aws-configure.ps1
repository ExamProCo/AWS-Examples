# Prompt user to enter AWS access key
$AccessKey = Read-Host "Enter your AWS access key"

# Prompt user to enter AWS secret key
$SecretKey = Read-Host "Enter your AWS secret key" -AsSecureString

# Prompt user to enter AWS region
$Region = Read-Host "Enter your AWS region"

# Set AWS credentials using the provided access key and secret key
Set-AWSCredential -AccessKey ($AccessKey) -SecretKey ($SecretKey | ConvertFrom-SecureString) -StoreAs "MyProfile"

# Set default AWS region
Set-DefaultAWSRegion -Region $Region

# Display confirmation message
Write-Host "AWS credentials and region set successfully."
