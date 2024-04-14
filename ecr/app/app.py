from flask import Flask
from flask import request
import os

app = Flask(__name__)

@app.route("/api/hello", methods=['GET'])
def hello():
    model = {'errors': None}
    name = request.args.get('name')
    if not name:
        model['errors'] = [{"msg": "Name not provided"}]
    else:
        model['data'] = {"msg": f"Hello {name}!"}

    if 'errors' in model and model['errors'] is not None:
        return model['errors'], 422
    else:
        return model['data'], 200

if __name__ == "__main__":
    app.run(debug=True)