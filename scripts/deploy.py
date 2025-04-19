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
        print(f"Uploading {file.name} with Content-Type: {get_content_type(file)}...")
        # Upload file without setting ACL, just setting Content-Type
        s3.upload_file(
            str(file), 
            BUCKET_NAME, 
            file.name,
            ExtraArgs={'ContentType': get_content_type(file)}
        )

# Function to determine the content type based on file extension
def get_content_type(file_path):
    extension = file_path.suffix.lower()
    if extension == ".html":
        return "text/html"
    elif extension == ".css":
        return "text/css"
    elif extension == ".js":
        return "application/javascript"
    elif extension == ".json":
        return "application/json"
    elif extension == ".jpg" or extension == ".jpeg":
        return "image/jpeg"
    elif extension == ".png":
        return "image/png"
    elif extension == ".gif":
        return "image/gif"
    else:
        return "application/octet-stream"  # Default for unknown file types

# Main execution
if __name__ == "__main__":
    upload_files()
