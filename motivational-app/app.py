import os
from flask import Flask, render_template_string, request, jsonify
from pymongo import MongoClient

app = Flask(__name__)
MONGO_URI = os.getenv("MONGO_URI")

DEFAULT_MESSAGES = {
    "1": "The best way to predict the future is to create it. 🏗️",
    "2": "Consistency is the key to mastering DevOps. 🗝️",
    "3": "Your only limit is your cloud quota. 🚀",
    "4": "Don't stop until you are proud. 💻"
}

HTML_TEMPLATE = """
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Alaa's Hub</title>
    <style>
        body { font-family: sans-serif; background: #f0f4ff; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .card { background: white; padding: 2rem; border-radius: 20px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; max-width: 400px; }
        h1 { color: #6366f1; }
        .status { margin-bottom: 1rem; font-weight: bold; }
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 20px; }
        button { background: #6366f1; color: white; border: none; padding: 15px; border-radius: 10px; cursor: pointer; font-size: 1.1rem; }
        #display { min-height: 50px; color: #333; margin-bottom: 20px; font-style: italic; }
        .input-group { display: flex; gap: 5px; }
        input { flex: 1; padding: 8px; border: 1px solid #ccc; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Alaa's Hub ✨</h1>
        <div class="status" style="color: {{ 'green' if connected else 'orange' }}">
            {{ "Database Live 🟢" if connected else "Running Local 🟠" }}
        </div>
        <div class="grid">
            {% for id in ["1", "2", "3", "4"] %}
            <button onclick="show('{{ id }}')">{{ id }}</button>
            {% endfor %}
        </div>
        <div id="display">Select a goal...</div>
        <div class="input-group">
            <select id="u-id"><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>
            <input type="text" id="u-msg" placeholder="New text...">
            <button onclick="update()" style="padding: 8px; background: #10b981;">Upd</button>
        </div>
    </div>
    <script>
        const msgs = {{ messages | tojson }};
        function show(id) { document.getElementById('display').innerText = msgs[id] || "No msg"; }
        async function update() {
            const id = document.getElementById('u-id').value;
            const text = document.getElementById('u-msg').value;
            if(!text) return;
            const res = await fetch('/update', {
                method: 'POST', headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({id, text})
            });
            if(res.ok) { msgs[id] = text; show(id); alert("Synced!"); }
        }
    </script>
</body>
</html>
"""

def get_db():
    if not MONGO_URI: return None
    try:
        client = MongoClient(MONGO_URI, serverSelectionTimeoutMS=3000)
        client.server_info()
        return client.get_database()
    except: return None

@app.route('/')
def index():
    msgs = DEFAULT_MESSAGES.copy()
    connected = False
    db = get_db()
    if db:
        try:
            if db.messages.count_documents({}) == 0:
                db.messages.insert_many([{"_id": k, "text": v} for k, v in DEFAULT_MESSAGES.items()])
            for doc in db.messages.find(): msgs[doc["_id"]] = doc["text"]
            connected = True
        except: pass
    return render_template_string(HTML_TEMPLATE, messages=msgs, connected=connected)

@app.route('/update', methods=['POST'])
def update():
    db = get_db()
    if db:
        data = request.json
        db.messages.update_one({"_id": data['id']}, {"$set": {"text": data['text']}}, upsert=True)
        return jsonify({"status": "ok"})
    return jsonify({"status": "err"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)