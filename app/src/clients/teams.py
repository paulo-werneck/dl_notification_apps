from app.src.clients.base import BaseClient


class TeamsClient(BaseClient):

    def __init__(self, payload_sns, ):
        super().__init__(payload_sns)

    def push_client_notification(self):
        pass