import boto3
from datetime import datetime

sessao = boto3.Session(profile_name="cog-dev", region_name="us-west-1")
cli = sessao.client("sns")


def get_message_text():
    return """Airflow task execution failed. 
    *Time*: {time}  
    *Task*: nome-da-task-do-airflow  
    *Dag*: nome-da-dag-do-airflow 
    *Execution Time*: 2021-08-05T00:00:00+00:00  
    *Log Url*: localhost:8080 
    """.format(
        time=datetime.now(),
        )


def send_message_sns():
    subject = "{company}: [WARN] - Airflow task execution failed".format(
        company="Cognitivo"
    )
    message = get_message_text()
    response = cli.publish(
        TopicArn="arn:aws:sns:us-west-1:633076115486:paulo-cognitivo-teste-alarms",
        Subject=subject,
        Message=message
    )
    return response


if __name__ == '__main__':
    k = send_message_sns()
    print(k)
