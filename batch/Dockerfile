FROM python:3.8

# Set the working directory
WORKDIR /app

# Copy the Python script into the container
COPY app/square.py /app

ENV PYTHONUNBUFFERED=1

# Run the Python script when the container starts
CMD ["python", "-u", "square.py", "3"]