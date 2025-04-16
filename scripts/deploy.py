# This script automates file uploads to S3 and enforces bucket policies

# Import required libraries
import boto3
import os
from pathlib import Path
from botocore.exceptions import ClientError

# Define variables
BUCKET_NAME = "secure-static-site-website"
LOCAL_DIRECTORY = "./website"

# Initialize S3 client
s3 = boto3.client("s3")

# Function to upload files and check ACL
def upload_files():
    for file in Path(LOCAL_DIRECTORY).glob("*"):
        print(f"Uploading {file.name}...")
        s3.upload_file(str(file), BUCKET_NAME, file.name)
        check_acl(file.name)

# Function to check file ACL
def check_acl(file_key):
    acl = s3.get_object_acl(Bucket=BUCKET_NAME, Key=file_key)
    for grant in acl['Grants']:
        if 'AllUsers' in grant['Grantee'].get('URI', ''):
            print(f"[!] Public access found on: {file_key}")
            # Apply stricter policy to make the object private
            s3.put_object_acl(Bucket=BUCKET_NAME, Key=file_key, ACL="private")
            print(f"[Fixed] {file_key} is now private.")
        else:
            print(f"[OK] {file_key} is private.")

# Main execution
if __name__ == "__main__":
    upload_files()
