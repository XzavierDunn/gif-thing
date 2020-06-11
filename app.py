from flask import Flask, render_template
from flask_cors import CORS
import json
import requests

app = Flask(__name__)
CORS = CORS(app)

api_key = "rz64jDItYN6FFbSLQxspAHipWXh8D48R"

@app.route('/')
def get_gif():
    url = f"http://api.giphy.com/v1/gifs/random?q=burrito&api_key={api_key}&limit=1"
    r = requests.get(url)

    data = r.json()

    with open("file.txt", "w") as file:
        file.write(data['data']['embed_url'])

    return "Success"


@app.route('/get')
def get_url():
    with open("file.txt", "r") as file:
        for i in file.readlines():
            return i


if __name__ == "__main__":
    app.run(host="0.0.0.0")
