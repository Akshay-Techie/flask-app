from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return "Hello Genexis! This is AWS-DevOps Project for testing purpose"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)