#!/bin/bash
set -e

nginx &
python3 manage.py runserver
wait