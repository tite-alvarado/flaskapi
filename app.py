from flask import Flask, request
from flask import json, jsonify
from codecs import decode,encode
import uu
app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health():
    if request.method == 'GET':
        return jsonify(Status='Healhty')

@app.route('/encrypt', methods=['POST'])
def encrypt():
    if request.method == 'POST':
        req_data = request.get_json()
        try:
            input = req_data['Input']
            encrypted = encode(input, 'base-64').rstrip('\r\n')
            return jsonify(Input=input, Output=encrypted, Status='success', Message='')
        except:
            return jsonify(Status='error', Message='Unexpected object', Input=req_data), 400

@app.route('/decrypt', methods=['POST'])
def decrypt():
    if request.method == 'POST':
        req_data = request.get_json()
        try:
            input = req_data['Input']
            decrypted = decode(input, 'base-64').rstrip('\r\n')
            return jsonify(Input=input, Output=decrypted, Status='success', Message='')
        except:
            return jsonify(Status='error', Message='Unexpected object', Input=req_data), 400

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
