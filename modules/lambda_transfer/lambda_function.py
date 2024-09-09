import boto3
import hashlib
import os

s3_client = boto3.client('s3')

def get_md5_checksum(bucket, key):
    """ Calculate MD5 checksum of an S3 object """
    response = s3_client.get_object(Bucket=bucket, Key=key)
    file_data = response['Body'].read()
    return hashlib.md5(file_data).hexdigest()

def lambda_handler(event, context):
    # Source S3 Bucket and File Key
    source_bucket = os.environ['SOURCE_BUCKET']
    source_key = os.environ['SOURCE_KEY']
    
    # Destination S3 Bucket and File Key
    dest_bucket = os.environ['DEST_BUCKET']
    dest_key = source_key  # Copy the file with the same key in the destination bucket
    
    # Calculate checksum before transfer
    pre_transfer_checksum = get_md5_checksum(source_bucket, source_key)
    print(f"Pre-transfer MD5 checksum: {pre_transfer_checksum}")
    
    # Copy the object to the destination bucket
    copy_source = {'Bucket': source_bucket, 'Key': source_key}
    s3_client.copy_object(CopySource=copy_source, Bucket=dest_bucket, Key=dest_key)
    print(f"File transferred from {source_bucket}/{source_key} to {dest_bucket}/{dest_key}")
    
    # Calculate checksum after transfer
    post_transfer_checksum = get_md5_checksum(dest_bucket, dest_key)
    print(f"Post-transfer MD5 checksum: {post_transfer_checksum}")
    
    # Compare checksums to verify integrity
    if pre_transfer_checksum == post_transfer_checksum:
        return {
            'statusCode': 200,
            'body': f'Success: File transferred and integrity verified. Checksum: {pre_transfer_checksum}'
        }
    else:
        return {
            'statusCode': 500,
            'body': f'Error: Data integrity check failed. Pre-transfer checksum: {pre_transfer_checksum}, Post-transfer checksum: {post_transfer_checksum}'
        }
