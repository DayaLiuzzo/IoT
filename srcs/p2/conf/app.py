from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def index():
    return f"""
        <p><b>Hello From App:</b> {os.getenv("APP_NAME", "Unknown")}</p>
        <p><b>Pod:</b> {os.getenv("POD_NAME", "Unknown")}</p>
        <p><b>Node:</b> {os.getenv("NODE_NAME", "Unknown")}</p>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
