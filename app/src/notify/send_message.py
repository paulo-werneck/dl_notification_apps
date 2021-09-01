from app.src.clients.base import BaseClient


class SendMessage:

    def __init__(self, client_message: BaseClient):
        self._client_message = client_message

    @property
    def client_message(self):
        return self._client_message

    @client_message.setter
    def client_message(self, value):
        self._client_message = value

    def send(self):
        return self._client_message.push_client_notification()
