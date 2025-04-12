import boto3
import os
from pathlib import Path
from botocore.exceptions import ClientError

BUCKET = "secure-static-site-bucket"
LOCAL_DIR = "../website"

s3 = boto3.client("s3")

#Defines function to check s3 acl to see if the object is public or private
def check_acl(key):
    acl = s3.get_object_acl(Bucket=BUCKET, Key=key)
    for grant in acl['Grants']:
        if 'AllUsers' in grant['Grantee'].get('URI', ''):
            print(f"[!] Public access found on: {key}")
        else:
            print(f"[OK] {key} is private.")

def upload_files():
    for file in Path(LOCAL_DIR).glob("*"):
        print(f"Uploading {file.name}...")
        s3.upload_file(str(file), BUCKET, file.name)
        check_acl(file.name)

if __name__ == "__main__":
    upload_files()
