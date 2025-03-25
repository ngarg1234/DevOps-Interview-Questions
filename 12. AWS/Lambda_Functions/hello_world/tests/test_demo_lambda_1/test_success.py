from tests.test_demo_lambda_1 import DemoLambda1LambdaTestCase


class TestSuccess(DemoLambda1LambdaTestCase):

    def test_success(self):
        self.assertEqual(self.HANDLER.handle_request(dict(), dict()), 200)

