import os
from flask import Flask, render_template_string
from pymongo import MongoClient

app = Flask(__name__)

# Fetch URI from Environment Secret
MONGO_URI = os.getenv("MONGO_URI")

def get_db_connection():
    # Adding timeouts and direct database access to ensure green status
    client = MongoClient(MONGO_URI, connectTimeoutMS=10000, serverSelectionTimeoutMS=10000)
    # This will try to get 'Project0' or fallback to the URI default
    return client.get_database()

DEFAULT_MESSAGES = {
    "1": "You are a DevOps Star! Your potential is infinite ✨",
    "2": "Every line of code you write is a step toward greatness 🚀",
    "3": "Success is a journey, and you are leading the way 🌈",
    "4": "Keep shining, Alaa! The world needs your brilliance 🌟"
}

HTML_TEMPLATE = """
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Alaa's Motivational Hub</title>
    <style>
        :root { --primary: #6366f1; --success: #22c55e; --error: #ef4444; --bg: #f5f3ff; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: var(--bg); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; color: #1f2937; }
        .app-card { background: #ffffff; padding: 50px; border-radius: 30px; box-shadow: 0 20px 50px rgba(99, 102, 241, 0.1); text-align: center; max-width: 500px; width: 90%; border: 2px solid #e0e7ff; }
        h1 { color: var(--primary); font-size: 2.5rem; margin-bottom: 10px; }
        .status-dot { height: 12px; width: 12px; border-radius: 50%; display: inline-block; margin-right: 8px; }
        .status-text { font-size: 0.9rem; font-weight: 600; padding: 8px 16px; border-radius: 20px; display: inline-flex; align-items: center; }
        .connected { background: #dcfce7; color: #166534; }
        .offline { background: #fee2e2; color: #991b1b; }
        .grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; margin-top: 30px; }
        button { background: var(--primary); color: white; border: none; padding: 15px; border-radius: 12px; font-size: 1.2rem; cursor: pointer; transition: transform 0.2s, background 0.2s; }
        button:hover { background: #4f46e5; transform: translateY(-3px); }
        #message-display { margin-top: 40px; font-size: 1.4rem; font-style: italic; min-height: 60px; color: #4b5563; line-height: 1.5; }
        footer { margin-top: 30px; font-size: 0.8rem; color: #9ca3af; }
    </style>
</head>
<body>
    <div class="app-card">
        <h1>Hello, Alaa! ✨</h1>
        <p>Your daily dose of inspiration is one click away.</p>
        
        <div class="status-text {{ 'connected' if connected else 'offline' }}">
            <span class="status-dot" style="background: {{ 'var(--success)' if connected else 'var(--error)' }};"></span>
            {{ "Cloud Database Synced ✅" if connected else "Syncing your dreams... ⏳" }}
        </div>

        <div class="grid">
            {% for id in ["1", "2", "3", "4"] %}
            <button onclick="display('{{ id }}')">{{ id }}</button>
            {% endfor %}
        </div>
        
        <div id="message-display">Pick a number to start your magic...</div>
        
        <footer>DevOps Final Project • 2026</footer>
    </div>

    <script>
        const msgs = {{ messages | tojson }};
        function display(id) {
            const display = document.getElementById('message-display');
            display.style.opacity = 0;
            setTimeout(() => {
                display.innerText = msgs[id];
                display.style.opacity = 1;
                display.style.transition = 'opacity 0.5s';
            }, 200);
        }
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
            db.command('ping')
            is_connected = True
            
            collection = db.messages
            db_data = list(collection.find())
            if db_data:
                messages_to_show = {doc["_id"]: doc["text"] for doc in db_data}
            else:
                collection.insert_many([{"_id": k, "text": v} for k, v in DEFAULT_MESSAGES.items()])
        except Exception as e:
            print(f"Connection update: {e}")
            is_connected = False

    return render_template_string(HTML_TEMPLATE, messages=messages_to_show, connected=is_connected)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)