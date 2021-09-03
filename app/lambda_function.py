from app.src.notify.send_message import SendMessage
from importlib import import_module
import os


def lambda_handler(event, context):
    
    env = os.getenv("CLIENT")
    client = import_module(f"app.src.clients.{env}").__dict__[f"{env.capitalize()}Client"]

    s = SendMessage(
        client(payload_sns=event)
    ) 
    s.send()
