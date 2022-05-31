import logging
import boto3

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)


def handler(event, context):
    LOGGER.info(f'Event Object: {event}')
    LOGGER.info(f'Context Object: {context}')
    LOGGER.info("Report Error")
    event['key'] = 'value'


# Send a notification in case the file doesn't exist.
    client = boto3.client('sns')
    snsArn = 'arn:aws:sns:eu-central-1:636969640232:s3-Data-check-topic'
    message = "This is a notification that the file doesn't exists in the bucket."
    
    response = client.publish(
        TopicArn = snsArn,
        Message = message ,
        Subject='s3 file check Alert!!!!!!!!!!'
    )
    return event