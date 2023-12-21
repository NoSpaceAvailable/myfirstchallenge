from flask import Flask, request, render_template
app = Flask(__name__)

def make_color(s: str) -> str:
    return str(eval(s))

banned = ["attr", "ssti", "file", "eval", "attack", "../", "exec", "_", ";", "import", "subprocess", "os", "global"]

@app.route('/')
def none():
    return render_template("index.html",
                           greeting="Happy New Year, user!",
                           message="Nothing here... Should take a look at /greet")

@app.route('/greet')
def greets():
    c = request.args.get('name')
    greeting = message = ''
    if not c:
        greeting = "Happy New Year, user!"
        message = "Your name should not be null"
    elif any(s in c for s in banned):
        greeting = "Hack!!!!!!!!!!"
        message = "I will call the police"
    else:
        try:
            greeting = "Happy New Year!"
            message = "Your name is: " + make_color(c)
        except:
            greeting = "Happy New Year!"
            message = "Your name is: " + c
    return render_template('index.html', greeting=greeting, message=message)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
