from src.notify.send_message import SendMessage
from importlib import import_module


if __name__ == '__main__':
    env = "slack"
    client = import_module(f"app.src.clients.{env}").__dict__[f"{env.capitalize()}Client"]

    url = "https://hooks.slack.com/services/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"
    payload_sns = {"Records": [{"Sns": {"Subject": "xxxxxxxxx", "Message": "olá sou a msg"}}]}

    s = SendMessage(client(payload_sns=payload_sns, url=url))
    s.send()
    print(s)