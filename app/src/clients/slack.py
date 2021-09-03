from app.src.clients.base import BaseClient
import json
import os
import requests


class SlackClient(BaseClient):

    def __init__(self, payload_sns, **kwargs):
        super().__init__(payload_sns)
        self.url = os.getenv("ENDPOINT_URL")

    def push_client_notification(self):
        headers = {"Content-type": "application/json"}
        payload = json.dumps({"text": f"<!here>, :disappointed: \n {self.subject} \n {self.message}"})
        response = requests.post(url=self.url, data=payload, headers=headers)
        return response
