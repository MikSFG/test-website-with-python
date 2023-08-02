#from sql import write_userpass, get_userpass
from flask import Flask, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)



@app.route('/backend', methods=["POST"])
def call_db():
    data = request.form
    username = list(data.values())[0]
    password = list(data.values())[1]
    if "newUsername" in data and "newPassword" in data:
        #write_userpass(username=username, password=password)
        print("Successful registration")
        return "Successful registration1"
    if "username" in data and "password" in data:
        #get_userpass(username=username, password=password)
        print("Successful sign-in")
        return "Successful sign-in1"





