# src/page_tracker/app.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def index():
    return "Hello from Docker!"
