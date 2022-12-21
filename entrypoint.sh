#!/bin/sh
python3 manage.py migrate
python3 manage.py runserver 0.0.0.0:8000
# python3 manage.py runsslserver --certificate /cert/cert.pem --key /cert/key.pem 0.0.0.0:9001
