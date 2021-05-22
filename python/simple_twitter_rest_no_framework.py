# ----------------------------------
# This is a small sample showing how to connect to twitter Rest API using OAuth 2
# Error handling implemented only on Flask Framework version
# Code by Fernando Matsuo Santos
# Date: 2016/04/11
# ----------------------------------

# ----------------------------------
# Note: this is a small sample. No error handling implemented in this file.
# ----------------------------------

import urllib3, json, base64

CONSUMER_KEY='XXX'
CONSUMER_SECRET='XXX'

# Create a HTTP connection pool_manager
pool_manager = urllib3.PoolManager(timeout=5.0) # Set timeout for 5 seconds (optional)

# Since this is only a sample, so I'll disable SSL warnings
# Never do it on production servers!
urllib3.disable_warnings()

# To use a SSL cert and remove SSL warnings we should use the following code
#ca_certs = "/etc/ssl/certs/ca-certificates.crt"  # Or wherever it lives.
#pool_manager = urllib3.PoolManager(
#    cert_reqs='CERT_REQUIRED', # Force certificate check.
#    ca_certs=ca_certs,         # Path to certificate
#	 timeout=5.0,				# Set timeout for 5 seconds (optional)
#)

# Set the variable to Twitter OAuth 2 endpoint
oauth_url = 'https://api.twitter.com/oauth2/token' 

# Set the HTTP request headers, including twitter consumer key and secret
http_headers={'Authorization': "Basic %s" % base64.b64encode("%s:%s" % (CONSUMER_KEY,CONSUMER_SECRET)), 'Content-Type': 'application/x-www-form-urlencoded'} 

# Set the payload and get client credentials
request_body="grant_type=client_credentials" 

# Send the request
response = pool_manager.urlopen("POST", oauth_url, headers=http_headers, body=request_body)

# Read the response as JSON
app_token = json.loads(response.data)

# print app_token
print 'Answer from twitter Restful API - client credentials'
print 'http_response_code: ' + str(response.status) # this should be http 200 OK
print 'token_type: ' + app_token['token_type']
print 'access_token: ' + app_token['access_token']
