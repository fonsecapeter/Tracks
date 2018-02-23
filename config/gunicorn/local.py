import os
import multiprocessing

max_requests = 50000
max_requests_jitter = 500
reload = True
proc_name = 'market'
workers = multiprocessing.cpu_count() * 2 + 1
threads = 5
bind = '0.0.0.0:8000'
worker_class = 'gthread'
keyfile = 'config/gunicorn/localhost.key'
certfile = 'config/gunicorn/localhost.crt'
log_file = '-'
