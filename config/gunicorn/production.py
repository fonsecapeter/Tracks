import os
import multiprocessing

max_requests = 50000
max_requests_jitter = 500
preload_app = True
proc_name = 'app'
workers = multiprocessing.cpu_count() * 2 + 1
threads = 5
bind = '0.0.0.0:8000'
worker_class = 'gthread'
log_file = '-'
