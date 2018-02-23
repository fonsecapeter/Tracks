from django.urls import reverse
from .helpers import TrackTestCase


class TestIndex(TrackTestCase):
    def test_it_works(self) -> None:
        response = self.client.get(reverse('index'))
        assert response.status_code == 200
