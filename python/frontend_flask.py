# ----------------------------------
# This sample shows how to connect to twitter Rest API using OAuth 1
# Python and Flask framework
# Code by Fernando Matsuo Santos
# Date: 2016/04/11
# ----------------------------------
import requests, json
import logging
from logging.handlers import RotatingFileHandler
from flask import Flask
from flask import render_template, request
app = Flask(__name__)

# Default home route
@app.route('/')
def index():
    url = 'http://127.0.0.1:8085/api'
    response = requests.get(url)
    json_data = json.loads(response.text)
    cities_get = (json_data['cities'])

    response = requests.put(url)
    json_data = json.loads(response.text)
    cities_put = (json_data['cities'])

    response = requests.delete(url)
    json_data = json.loads(response.text)
    cities_delete = (json_data['cities'])

    return render_template('frontend.html', cities_get=cities_get, cities_put=cities_put, cities_delete=cities_delete)

# handle errors, exceptions and 404 file not found errors
@app.errorhandler(404)
def page_not_found(error):
	app.logger.error('Page not found: %s', (request.path))
	#return '404 Error', 4044
	return render_template('404.html'), 4044

@app.errorhandler(500)
def internal_server_error(error):
    app.logger.error('Server Error: %s', (error))
    return render_template('500.html'), 500

@app.errorhandler(Exception)
def unhandled_exception(e):
    app.logger.error('Unhandled Exception: %s', (e))
    return render_template('500.html'), 500

if __name__ == '__main__':
    handler = RotatingFileHandler('frontend_flask.log', maxBytes=10000, backupCount=1)
    handler.setLevel(logging.INFO)
    app.logger.addHandler(handler)
    app.run(port=8086, debug=True)