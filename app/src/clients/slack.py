from app.src.clients.base import BaseClient
import requests
import json


class SlackClient(BaseClient):

    def __init__(self, payload_sns, **kwargs):
        super().__init__(payload_sns)
        self.url = kwargs.get("url")

    def push_client_notification(self):
        headers = {"Content-type": "application/json"}
        payload = json.dumps({"text": f"<!here>, :disappointed: \n {self.subject} \n {self.message}"})
        response = requests.post(url=self.url, data=payload, headers=headers)
        return response
