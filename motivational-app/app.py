import os
from flask import Flask, render_template_string
from pymongo import MongoClient

app = Flask(__name__)

# Fetch URI from Environment Secret
MONGO_URI = os.getenv("MONGO_URI")

def get_db_connection():
    # Adding connectTimeoutMS and serverSelectionTimeoutMS to prevent long hangs
    client = MongoClient(MONGO_URI, connectTimeoutMS=30000, serverSelectionTimeoutMS=30000)
    return client.get_database()

DEFAULT_MESSAGES = {
    "1": "You are amazing! Keep pushing forward 💪",
    "2": "Believe in your journey, stars take time to shine 🌟",
    "3": "Every small step leads to a big success 🌈",
    "4": "Innovation distinguishes between a leader and a follower 🚀"
}

HTML_TEMPLATE = """
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Take Your Message</title>
    <style>
        :root { --primary: #2563eb; --bg: #f8fafc; --card-bg: #ffffff; }
        body { font-family: sans-serif; background: var(--bg); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .app-card { background: var(--card-bg); padding: 40px; border-radius: 20px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; }
        button { padding: 15px; margin: 5px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="app-card">
        <h1>Take Your Message</h1>
        <p style="color: {{ 'green' if connected else 'red' }};">
            {{ "● Connected to MongoDB" if connected else "● Running in Offline Mode (Check Atlas IP Access)" }}
        </p>
        <div class="grid">
            {% for id in ["1", "2", "3", "4"] %}
            <button onclick="display('{{ id }}')">{{ id }}</button>
            {% endfor %}
        </div>
        <div id="message-display" style="margin-top: 20px;">Choose a number...</div>
    </div>
    <script>
        const msgs = {{ messages | tojson }};
        function display(id) { document.getElementById('message-display').innerText = msgs[id]; }
    </script>
</body>
</html>
"""

@app.route('/')
def index():
    messages_to_show = DEFAULT_MESSAGES
    is_connected = False
    
    if MONGO_URI:
        try:
            db = get_db_connection()
            # Try a quick ping to check connection
            db.command('ping')
            is_connected = True
            
            # Try to fetch messages
            collection = db.messages
            db_data = list(collection.find())
            if db_data:
                messages_to_show = {doc["_id"]: doc["text"] for doc in db_data}
            elif is_connected:
                # Seed database if empty
                collection.insert_many([{"_id": k, "text": v} for k, v in DEFAULT_MESSAGES.items()])
        except Exception as e:
            print(f"Connection failed: {e}")
            is_connected = False

    return render_template_string(HTML_TEMPLATE, messages=messages_to_show, connected=is_connected)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)