#!/bin/sh

# Need to create tun0 for sockd to start
ip tuntap add mode tun tun0
ip address add 127.0.0.1 dev tun0

tinyproxy
sockd &

sleep 2

# Need to delete tun0 so openconnect can use it
ip tuntap del mode tun tun0

# If not set, interactively ask for password
if [ -z "$OPENCONNECT_PASSWORD" ]; then
  openconnect -u "$OPENCONNECT_USER" $OPENCONNECT_OPTIONS "$OPENCONNECT_URL"

# Multi factor authentication (MFA)
elif [ -n "$OPENCONNECT_PASSWORD" ] && [ -n "$OPENCONNECT_MFA_CODE" ]; then
  (echo "$OPENCONNECT_PASSWORD"; echo "$OPENCONNECT_MFA_CODE") | openconnect -u "$OPENCONNECT_USER" $OPENCONNECT_OPTIONS --passwd-on-stdin "$OPENCONNECT_URL"

# Standard authentication
elif [ -n "${OPENCONNECT_PASSWORD}" ]; then
  echo "$OPENCONNECT_PASSWORD" | openconnect -u "$OPENCONNECT_USER" $OPENCONNECT_OPTIONS --passwd-on-stdin "$OPENCONNECT_URL"
fi
