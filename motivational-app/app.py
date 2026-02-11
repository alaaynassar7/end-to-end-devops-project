from flask import Flask, render_template_string

app = Flask(__name__)

MESSAGES = {
    "1": "The best way to predict the future is to create it. 🏗️",
    "2": "Don't stop until you are proud of your infrastructure. 💻",
    "3": "Your only limit is your mind, not your cloud quota. 🚀",
    "4": "Consistency is the key to mastering DevOps. 🗝️"
}

HTML_TEMPLATE = """
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Alaa's Cloud Hub</title>
    <style>
        :root { 
            --grad: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            --bg: #f0f4ff; 
        }
        body { 
            font-family: 'Poppins', sans-serif; 
            background: var(--bg); 
            display: flex; justify-content: center; align-items: center; 
            min-height: 100vh; margin: 0; 
        }
        .app-card { 
            background: white; padding: 40px; border-radius: 30px; 
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.1); 
            text-align: center; max-width: 450px; width: 90%; 
            border: 2px solid #e0e7ff;
        }
        h1 { 
            background: var(--grad);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 2.5rem; margin-bottom: 20px; 
        }
        .grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; margin-bottom: 30px; }
        button { 
            background: var(--grad); color: white; border: none; 
            padding: 20px; border-radius: 15px; font-weight: bold; 
            font-size: 1.2rem; cursor: pointer; transition: 0.3s;
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.2);
        }
        button:hover { transform: scale(1.05); box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3); }
        #display { 
            font-size: 1.2rem; color: #4338ca; min-height: 80px; 
            padding: 20px; background: #eef2ff; border-radius: 20px;
            display: flex; align-items: center; justify-content: center;
            border: 1px dashed #6366f1; line-height: 1.5;
        }
        .footer { margin-top: 25px; font-size: 0.8rem; color: #818cf8; font-weight: 500; }
    </style>
</head>
<body>
    <div class="app-card">
        <h1>Alaa's Hub ✨</h1>
        <div class="grid">
            <button onclick="show('1')">Goal 1</button>
            <button onclick="show('2')">Goal 2</button>
            <button onclick="show('3')">Goal 3</button>
            <button onclick="show('4')">Goal 4</button>
        </div>
        <div id="display">Tap a goal for inspiration! 🚀</div>
        <p class="footer">Cloud-Native App • ArgoCD Ready • 2026</p>
    </div>
    <script>
        const msgs = {{ messages | tojson }};
        function show(id) { 
            const box = document.getElementById('display');
            box.style.opacity = 0;
            setTimeout(() => {
                box.innerText = msgs[id];
                box.style.opacity = 1;
            }, 150);
        }
    </script>
</body>
</html>
"""

@app.route('/')
def index():
    return render_template_string(HTML_TEMPLATE, messages=MESSAGES)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)