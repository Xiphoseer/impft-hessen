#!/bin/sh

echo $0
DIR=$(dirname $0)
echo $DIR
OUT=$DIR/static/impfzentren.json

curl "https://api.airtable.com/v0/appmMM8VAv6vMQOPe/Impfzentren?view=Grid%20view" \
  -H "Authorization: Bearer $AIRTABLE_API_KEY" > $OUT