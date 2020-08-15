from flask import Flask
from flask_restful import Resource, Api
import os


app = Flask(__name__)
api = Api(app)


class Foo(Resource):
    def get(self):
        return {'foo': 'bar'}


api.add_resource(Foo, '/api/foo')


class Main(Resource):
    """
    Health check route.
    """

    def get(self):
        return {'health_check': 'passed!'}


api.add_resource(Main, '/api/')


if __name__ == '__main__':
    app.run('0.0.0.0', port=8080)
