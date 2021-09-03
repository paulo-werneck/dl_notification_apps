from abc import ABC, abstractmethod
import os


class BaseClient(ABC):

    def __init__(self, payload_sns):
        self.payload_sns = payload_sns

    def __parse_message(self):
        return self.payload_sns.get("Records")[0].get("Sns")

    @property
    def subject(self):
        return self.__parse_message().get("Subject")

    @property
    def message(self):
        return self.__parse_message().get("Message")

    @abstractmethod
    def push_client_notification(self):
        pass
