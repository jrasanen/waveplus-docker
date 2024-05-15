#!/bin/bash

echo "Starting dbus"
service dbus start

echo "Starting bluetoothd"
bluetoothd &

