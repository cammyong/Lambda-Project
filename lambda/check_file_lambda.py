"""
This lambda python would check the s3 bucket if an object exist and would output success.
"""

import logging
import boto3

s3_client = boto3.client('s3')
BUCKET_NAME = "s3-lambda-copy-src-bucket2"
OBJECT_KEY = "file5.txt"  # file in s3 bucket that would be verified

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def is_file_exists(bucket_name, object_key):
    """check if file exists in s3 bucket
    
    Args:
        bucket_name (string): name of s3 bucket
        object_key (string): full path to the file with filename

    Returns:
        result (boolean): true in case file exists
    
    """
    logger.info('check if file exists in s3 bucket')

    result = False
    try:
        response = s3_client.head_object(
            Bucket=bucket_name,
            Key=object_key,
        )
        if response:
            result = True

    except Exception as error:
        logger.error(error)
        raise Exception(error)

    return result


def handler(event, context):
    """ lambda handler and starting point

    Args:
        event (dict): a dictionary with all event information
        context (object): a lambda context object

    Returns:
        response (dict): a dictionary with header, statuscode and result
        information
    """
    logger.debug('start function %s', context and context.invoked_function_arn)

    if is_file_exists(BUCKET_NAME, OBJECT_KEY):
        return {
            'code': '200',
            'msg': 'File exists'
        }
    else:
        raise Exception('File doesn\'t exist')










