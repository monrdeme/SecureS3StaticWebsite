# This script automates file uploads to S3 and enforces bucket policies

# Import required libraries
import boto3
import os
import mimetypes
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
        content_type, _ = mimetypes.guess_type(file)
        if content_type is None:
            content_type = "binary/octet-stream"  # default fallback

        print(f"Uploading {file.name} with Content-Type: {content_type}...")
        try:
            s3.upload_file(
                Filename=str(file),
                Bucket=BUCKET_NAME,
                Key=file.name,
                ExtraArgs={
                    "ContentType": content_type,
                    "ACL": "public-read"  # Read-only access for everyone
                }
            )
            print(f"[OK] Uploaded {file.name}")
        except ClientError as e:
            print(f"[ERROR] Failed to upload {file.name}: {e}")

# Main execution
if __name__ == "__main__":
    upload_files()
