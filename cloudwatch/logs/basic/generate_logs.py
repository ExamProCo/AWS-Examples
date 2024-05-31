import os
import random
import time
from datetime import datetime, timedelta

number_of_entries = int(os.environ["NENTRIES"]) or 100

# Generate a random IP address
def generate_ip():
    return ".".join(map(str, (random.randint(0, 255) for _ in range(4))))

# Generate a random user agent
def generate_user_agent():
    user_agents = [
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Safari/605.1.15",
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0",
        "Mozilla/5.0 (iPhone; CPU iPhone OS 13_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Mobile/15E148 Safari/604.1"
    ]
    return random.choice(user_agents)

# Generate a random HTTP method
def generate_method():
    return random.choice(["GET", "POST", "DELETE", "PUT"])

# Generate a random HTTP status code
def generate_status():
    return random.choice([200, 201, 301, 302, 404, 500])

# Generate a random request path
def generate_path():
    paths = [
        "/home",
        "/about",
        "/contact",
        "/products",
        "/products/item",
        "/login",
        "/signup"
    ]
    return random.choice(paths)

# Initialize the last_time outside of the function
last_time = datetime.now() - timedelta(minutes=1000)

# Generate a random timestamp
def generate_timestamp():
    global last_time
    # Increase time by a random number of minutes (for example, between 1 and 10)
    increment = random.randint(1, 10)
    last_time += timedelta(minutes=increment)
    return last_time.strftime("%d/%b/%Y:%H:%M:%S +0000")

# Generate the log entry in ELF format
def generate_log_entry():
    ip = generate_ip()
    user_identifier = "-"  # Common placeholder for missing data
    user_id = "-"  # Common placeholder for missing data
    timestamp = generate_timestamp()
    method = generate_method()
    path = generate_path()
    protocol = "HTTP/1.1"
    status = generate_status()
    bytes_transferred = random.randint(500, 5000)
    referrer = "-"  # Common placeholder for missing data
    user_agent = generate_user_agent()

    log_entry = (
        f'{ip} {user_identifier} {user_id} [{timestamp}] "{method} {path} {protocol}" '
        f'{status} {bytes_transferred} "{referrer}" "{user_agent}"'
    )
    return log_entry

# Generate 100 log entries
log_entries = [generate_log_entry() for _ in range(number_of_entries)]

# Print the log entries
for entry in log_entries:
    print(entry)