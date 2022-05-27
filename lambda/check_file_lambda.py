import logging
import boto3

s3_client = boto3.client('s3')
bucket = "s3-lambda-copy-src-bucket1"
key = "file2.txt"


LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)


def handler(event, context):
    LOGGER.info(f'Event Object: {event}')
    LOGGER.info(f'Context Object: {context}')
    LOGGER.info("Check File")
    response = s3_client.head_object(
            Bucket=bucket,
            Key=key,
        )
    
    #response = s3_client.get_object(Bucket=bucket, Key=key)  
    # data = response['Body'].read() 
    event['key'] = 'value'
    return event