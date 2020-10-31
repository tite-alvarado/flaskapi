from flask import Flask, request
from flask import json
# from flask_restful import Resource, Api
# import simplejson as json

app = Flask(__name__)

@app.route('/encrypt', methods=['POST'])
def encrypt():
    if request.method == 'POST':
        return 'Encrypted'

@app.route('/decrypt', methods=['POST'])
def decrypt():
    if request.method == 'POST':
        return 'Decrypted'

@app.route('/health', methods=['GET'])
def health():
    if request.method == 'GET':
        return 'Health'

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
