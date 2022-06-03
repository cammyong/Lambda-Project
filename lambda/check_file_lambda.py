"""
This lambda python would check the s3 bucket if an object exist and would output success.
"""

import logging
import boto3


s3_client = boto3.client('s3')
bucket = "s3-lambda-copy-src-bucket2"
key = "file5.txt"  # file in s3 bucket that would be verified


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
    event['key'] = 'value'
    return event









