import os
import io
import boto3
import json
import csv

# grab environment variables
ENDPOINT_NAME = os.environ['ENDPOINT_NAME']
runtime= boto3.client('runtime.sagemaker')

def lambda_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    data = json.loads(event['body'])
    payload = data['data']
    response = runtime.invoke_endpoint(EndpointName=ENDPOINT_NAME,ContentType='text/csv',Body=payload)
    result = json.loads(response['Body'].read().decode())

    return {
        'statusCode': 200,
        'headers': { 'Content-Type': 'application/json' },
        'body': json.dumps({"isApproved": result})
    };


