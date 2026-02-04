from flask import Flask, render_template_string

app = Flask(__name__)

MESSAGES = {
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
    return render_template_string(HTML_TEMPLATE, messages=MESSAGES)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)