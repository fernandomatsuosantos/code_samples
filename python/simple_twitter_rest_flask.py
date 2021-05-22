# ----------------------------------
# This sample shows how to connect to twitter Rest API using OAuth 1
# Python and Flask framework
# Code by Fernando Matsuo Santos
# Date: 2016/04/11
# ----------------------------------
import requests, json, unicodedata, re
import logging
from logging.handlers import RotatingFileHandler
from flask import Flask
from flask import g, session, request, url_for, flash
from flask import redirect, render_template
from flask_oauthlib.client import OAuth
from flask.ext.mysqldb import MySQL

# Begin the app with Flask Framework
app = Flask(__name__)
app.debug = True
app.secret_key = 'development'
mysql = MySQL()
app.config['MYSQL_USER'] = 'magazine'
app.config['MYSQL_PASSWORD'] = 'XXX'
app.config['MYSQL_DB'] = 'fcamaramagazine'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_PORT'] = 4417
mysql.init_app(app)

# Uses Twitter OAuth 1 endpoint
oauth = OAuth(app)

twitter = oauth.remote_app(
    'twitter',
    consumer_key='XXX',
    consumer_secret='XXX',
    base_url='https://api.twitter.com/1.1/',
    request_token_url='https://api.twitter.com/oauth/request_token',
    access_token_url='https://api.twitter.com/oauth/access_token',
    authorize_url='https://api.twitter.com/oauth/authenticate',
)

# Get Twitter token
@twitter.tokengetter
def get_twitter_token():
    if 'twitter_oauth' in session:
        response = session['twitter_oauth']
        return response['oauth_token'], response['oauth_token_secret']

# Verify user session
@app.before_request
def before_request():
    g.user = None
    if 'twitter_oauth' in session:
        g.user = session['twitter_oauth']

# Default home route
@app.route('/')
def index():
    tweets = None
    if g.user is not None:
        response = twitter.request('statuses/home_timeline.json?count=5')
        if response.status == 200:
            tweets = response.data
        else:
            flash('Erro ao carregar Tweets da timeline.')
    return render_template('index.html', tweets=tweets)

# Search CEP information
@app.route('/cep', methods=['POST'])
def search_cep():
	if g.user is None:
		return redirect(url_for('login', next=request.url))

	cep = request.form['cep']

    #verify CEP with regular expression
	if ((not cep) or (not re.match('^(\d{8})?$',cep))):
		flash('Informe um CEP com 8 digitos numericos para continuar')
		return redirect(url_for('index'))

	#search city from CEP
	cep = request.form['cep']
	url = 'https://viacep.com.br/ws/' + cep + '/json/'
	response = requests.get(url)
	json_data = json.loads(response.text)
	city = (json_data['localidade'])

	#remove accents and space from city
	city = strip_accents(city)
	city = city.replace(" ", "")

	#search hashtag at Twitter
	results = None
	response = twitter.request('search/tweets.json?q=%23' + city)
	if response.status == 200:
		flash('Buscando no Tweeter por: ' + city)
		results = response.data
	else:
		flash('Falha ao buscar a cidade no Twitter.')

	#insert city hashtag into database protecting injection
	cursor = mysql.connection.cursor()
	query = "insert into cities (city) values (%s)"
	cursor.execute(query,[city])
	mysql.connection.commit()

	return render_template('index.html', results=results, city=city)

@app.route('/api', methods=['GET', 'POST', 'PUT', 'DELETE'])
def city_search():
    cursor = mysql.connection.cursor()
    query = "select distinct city, %s as method from cities order by city"
    cursor.execute(query,[request.method])

    screen_json = jsonify(cities=cursor.fetchall())
    screen_json.status_code = 200
    return screen_json

# Login at Twitter
@app.route('/login')
def login():
    callback_url = url_for('oauthorized', next=request.args.get('next'))
    return twitter.authorize(callback=callback_url or request.referrer or None)

# Logout from twitter
@app.route('/logout')
def logout():
    session.pop('twitter_oauth', None)
    return redirect(url_for('index'))

# Get sign in status
@app.route('/oauthorized')
def oauthorized():
    response = twitter.authorized_response()
    if response is None:
        flash('O acesso ao Twitter foi negado.')
    else:
        session['twitter_oauth'] = response
    return redirect(url_for('index'))

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

# Remove accents from strings
def strip_accents(s):
   return ''.join(c for c in unicodedata.normalize('NFD', s)
                  if unicodedata.category(c) != 'Mn')

if __name__ == '__main__':
    handler = RotatingFileHandler('simple_twitter_rest_flask.log', maxBytes=10000, backupCount=1)
    handler.setLevel(logging.INFO)
    app.logger.addHandler(handler)
    app.run(port=8085, debug=True)