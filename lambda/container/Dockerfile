# Use AWS python base image
FROM public.ecr.aws/lambda/python:3.12

# Copy over function specific code
COPY function/function.py function/requirements.txt /var/task/

# Install requirements
RUN python3.12 -m pip install -r /var/task/requirements.txt

# Set the file function.py and the function handler as the lambda function.
CMD ["function.handler"]