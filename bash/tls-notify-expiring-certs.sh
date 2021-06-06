#!/bin/bash

######################################################################
# Script Name    : tls-notify-expiring-certs.sh
# Description    : Used to send notification regarding certificates that will expire in 20 days
# Args           : WEBSITE DD_CLIENT_API_KEY
######################################################################

# Temporary file used to store the certificate
CERT_FILE=$(mktemp)

# Delete temporary file on exit
trap "unlink $CERT_FILE" EXIT

# Check if correct parameters were passed
if [ "$#" -lt "2" ]; then
    echo "ERROR: Missing or invalid parameters!"
    echo "Usage example: ./tls-notify-expiring-certs.sh WEBSITE DD_CLIENT_API_KEY"
else
    # Declare variables
    WEBSITE=$1
    DD_CLIENT_API_KEY=$2

    # Check whether the address of the website can be resolved
    host "$WEBSITE" >&-
    if [ "$?" -eq "0" ]; then
        echo -n | timeout 5 openssl s_client -servername "$WEBSITE" -connect "$WEBSITE":443 2>/dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > "$CERT_FILE"
        CERTIFICATE_SIZE=$(stat -c "%s" "$CERT_FILE")
        if [ "$CERTIFICATE_SIZE" -gt "1" ]; then
            # Get the certificate expiration date
            CERT_EXPIRY_DATE=$(openssl x509 -in "$CERT_FILE" -enddate -noout | sed "s/.*=\(.*\)/\1/")

            # Convert the certificate expiration date into seconds
            CERT_EXPIRY_DATE_SECS=$(date -d "$CERT_EXPIRY_DATE" +%s)

            # Convert the current date into seconds
            CURRENT_DATE_SECS=$(date -d now +%s)

            # Calculate how many days are left for the certificate to expire
            DATE_DIFF=$((($CERT_EXPIRY_DATE_SECS - $CURRENT_DATE_SECS) / 86400))

            # Check if the certificate will expire in 20 days or earlier
            if [ 21 -gt "$DATE_DIFF" ]; then
                echo "WARNING: Oops! Certificate will expire in $DATE_DIFF days."

                # Send alert to DATADOG
                curl -X POST "https://api.datadoghq.eu/api/v1/events?api_key=$DD_CLIENT_API_KEY" \
                -H "Content-type: application/json" \
                -d @- <<-EOF
					{
						"title": "TLS certificate about to expire!",
						"text": "The TLS certificate of the URL $WEBSITE will expire in $DATE_DIFF days.",
						"priority": "normal",
						"alert_type": "warning",
						"tags": ["scope:infrastructure","type:maintenance","website:$WEBSITE","date_diff:$DATE_DIFF"]
					}
				EOF
            else
                echo "INFO: Nothing to worry about. TLS certificate will expire only in $DATE_DIFF days from now."
            fi
        else
            echo "ERROR: Could not read the expiration date of the certificate. Please check the TLS settings of the website."
        fi
    else
        echo "ERROR: Website could not be resolved. Please ensure the correct address is passed."
    fi
fi
