from flask import Flask,request,jsonify
from flask_cors import CORS
from flask import Flask,render_template,url_for,request
from flask_bootstrap import Bootstrap 
from werkzeug import secure_filename

#from bert import Ner

app = Flask(__name__)
#CORS(app)
Bootstrap(app)

@app.route('/')
def index():
	return render_template('index.html')


@app.route('/predict', methods=['POST', 'GET'])
def predict():
    if request.method == 'POST':
        #model = Ner("/deploy/app/model")
        #text = request.json["query"]
        text =request.form["query"]
        try:
            #out = model.predict(text)
            #return jsonify({"result":out})
            #return render_template("results.html", prediction =out ,name =text)
            #return render_template("results.html", prediction =jsonify(out) ,name =text)
            return render_template("results.html", prediction =out ,name =text)
        except Exception as e:
            print(e)
            return jsonify({"result":"Model Failed"})

if __name__ == "__main__":
    app.run('0.0.0.0',port=8000,debug=True)
	#app.run(debug=True)