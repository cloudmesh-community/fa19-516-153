

class CloudConsumer:

    class AbstractConsumer:
        current_instances = []

        def __init__(self):
            raise NotImplementedError

        def get():
            raise NotImplementedError

        def post():
            raise NotImplementedError

    def aws_manager(self):
        import boto3
        class AWSConsumer(boto3.EC2.Client):
            name = "AWS"
            current_instances = []
            client = boto3.client('ec2')

        aws = AWSConsumer()
        return aws
        

    