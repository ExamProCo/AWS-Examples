## Create a new folder

```sh
aws s3 mb s3://object-lock-fun-ab-1241
```

## Turn on S3 Versioning

aws s3api put-bucket-versioning --bucket object-lock-fun-ab-1241 --versioning-configuration Status=Enabled

## Turn on Object Locking

aws s3api put-object-lock-configuration \
    --bucket object-lock-fun-ab-1241\
    --object-lock-configuration '{ "ObjectLockEnabled": "Enabled", "Rule": { "DefaultRetention": { "Mode": "GOVERNANCE", "Days": 1 }}}'

## New file and upload

echo "This is the gov2" > gov.txt
aws s3 cp gov.txt s3://object-lock-fun-ab-1241

## delete the file

aws s3 rm s3://object-lock-fun-ab-1241/gov.txt

## delete the versioned file

aws s3api delete-object --bucket="object-lock-fun-ab-1241" --key "gov.txt" --version-id="MnfcXt3xoAq1Ke1W9gTqbWg2RF7QObtA" --bypass-governance-retention 

## use compliance mode for s3 object

aws s3api put-object --bucket="object-lock-fun-ab-1241" --key "gov.txt" --body="compliance.txt" --object-lock-mode COMPLIANCE --object-lock-retain-until-date="2023-12-16T00:00:00Z"

## try and delete specific version


aws s3api delete-object --bucket="object-lock-fun-ab-1241" --key "gov.txt" --version-id="a2Zz9ePHlrkAI1piVt066uCmMo9gzF9_"

### Legal Holds

touch legal.txt

aws s3 cp legal.txt s3://object-lock-fun-ab-1241/legal.txt

aws s3api put-object-legal-hold --bucket "object-lock-fun-ab-1241" --key "legal.txt" --legal-hold Status=ON

aws s3 rm s3://object-lock-fun-ab-1241/legal.txt

aws s3api list-object-versions --bucket  object-lock-fun-ab-1241

aws s3api delete-object --bucket="object-lock-fun-ab-1241" --key "legal.txt" --version-id="limcmf.jxcW.z__vZELviwr3_vvQzK5p"


aws s3api put-object-legal-hold --bucket "object-lock-fun-ab-1241" --version-id="limcmf.jxcW.z__vZELviwr3_vvQzK5p" --key "legal.txt" --legal-hold Status=OFF

aws s3api delete-object --bucket="object-lock-fun-ab-1241" --key "legal.txt" --version-id="limcmf.jxcW.z__vZELviwr3_vvQzK5p"

aws s3api delete-object --bucket="object-lock-fun-ab-1241" --key "legal.txt" --version-id="KTD_YBuWo.MeXUoS4r51CaGZ5c7wsiOY" --bypass-governance-retention 

