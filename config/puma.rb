# Set the working directory
directory "/home/ubuntu/adcustomers"

# Path to socket
bind "unix:///home/ubuntu/adcustomers/tmp/sockets/puma.sock"

# Logs
stdout_redirect "/home/ubuntu/adcustomers/log/puma.stdout.log",
                "/home/ubuntu/adcustomers/log/puma.stderr.log",
                true

# Environment
environment "production"

# PID file
pidfile "/home/ubuntu/adcustomers/tmp/pids/puma.pid"

# Workers & threads
workers 2
threads 1, 6

preload_app!

