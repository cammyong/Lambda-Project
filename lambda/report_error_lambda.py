import logging
import boto3
import os

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)


def handler(event, context):
    LOGGER.info(f'Event Object: {event}')
    LOGGER.info(f'Context Object: {context}')
    LOGGER.info("Report Error")
    event['key'] = 'value'
    client = boto3.client('sns')  # Send a notification in case the file doesn't exist.
    snsArn = os.environ['sns_arn']
    message = "This is a notification that the file doesn't exists in the bucket."
    
    response = client.publish(
        TopicArn = snsArn,
        Message = message ,
        Subject='s3 file check Alert!!!!!!!!!!'
    )
    return event

