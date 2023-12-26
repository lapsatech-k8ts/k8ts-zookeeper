#!/usr/bin/env bash
CLIENT_PORT=${DEPLOYMENT_CLIENT_PORT:-2181}

echo mntr | nc localhost ${CLIENT_PORT} >& 1