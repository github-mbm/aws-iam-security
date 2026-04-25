import boto3
from flask import Flask

app = Flask(__name__)

def get_secret():
    client = boto3.client('secretsmanager', region_name='us-east-1')
    return client.get_secret_value(SecretId='db_password')['SecretString']

def get_param():
    ssm = boto3.client('ssm')
    return ssm.get_parameter(Name='/app/dev/db-url')['Parameter']['Value']

@app.route('/')
def home():
    return f"Secret: {get_secret()} | Config: {get_param()}"

app.run(host='0.0.0.0', port=5000)