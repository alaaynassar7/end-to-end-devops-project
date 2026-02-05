import os
from flask import Flask, render_template_string
from pymongo import MongoClient

app = Flask(__name__)

# 1. Connect to MongoDB using the Secret
# If no URI is provided, use a dummy local one to prevent crashing
MONGO_URI = os.getenv("MONGO_URI", "mongodb://localhost:27017/testdb")
client = MongoClient(MONGO_URI)
db = client.get_database() # Connect to the default database in the URI
collection = db.messages

# 2. Define Default Messages (Seeds)
DEFAULT_MESSAGES = [
    {"_id": "1", "text": "You are amazing! Keep pushing forward 💪"},
    {"_id": "2", "text": "Believe in your journey, stars take time to shine 🌟"},
    {"_id": "3", "text": "Every small step leads to a big success 🌈"},
    {"_id": "4", "text": "Innovation distinguishes between a leader and a follower 🚀"}
]

# 3. Auto-Seed Logic (If database is empty, fill it)
try:
    if collection.count_documents({}) == 0:
        print("Database is empty. Seeding default messages...")
        collection.insert_many(DEFAULT_MESSAGES)
    else:
        print("Database already has data. Connected successfully!")
except Exception as e:
    print(f"Error connecting to DB: {e}")

HTML_TEMPLATE = """
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Take Your Message</title>
    <style>
        :root { --primary: #2563eb; --bg: #f8fafc; --card-bg: #ffffff; --text: #1e293b; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--bg); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .app-card { background: var(--card-bg); padding: 40px; border-radius: 20px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; max-width: 400px; }
        h1 { color: var(--primary); margin-bottom: 25px; }
        .grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; }
        button { padding: 20px; font-size: 18px; border: 1px solid #e2e8f0; border-radius: 12px; cursor: pointer; background: white; transition: 0.3s; font-weight: bold; color: var(--primary); }
        button:hover { background: var(--primary); color: white; transform: translateY(-3px); }
        #message-display { margin-top: 25px; min-height: 50px; font-style: italic; color: #64748b; }
    </style>
</head>
<body>
    <div class="app-card">
        <h1>Take Your Message</h1>
        <p style="font-size: 12px; color: green;">🟢 Connected to MongoDB</p>
        <div class="grid">
            <button onclick="display('1')">01</button>
            <button onclick="display('2')">02</button>
            <button onclick="display('3')">03</button>
            <button onclick="display('4')">04</button>
        </div>
        <div id="message-display">Choose a number for inspiration...</div>
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
    # Fetch messages directly from MongoDB
    messages_from_db = {}
    try:
        for doc in collection.find():
            messages_from_db[doc["_id"]] = doc["text"]
    except:
        # Fallback if DB fails
        messages_from_db = {m["_id"]: m["text"] for m in DEFAULT_MESSAGES}
        
    return render_template_string(HTML_TEMPLATE, messages=messages_from_db)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)