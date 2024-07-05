# Use Python Slim Docker Image Version
FROM python:3.9-slim

# Set Working Directory to App
WORKDIR /app

# Copy Requierment file to App directory
COPY requirements.txt /app/

# Install all requierments and dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Add Traceroute to the docker
RUN apt-get update && apt-get install -y traceroute && rm -rf /var/lib/apt/lists/*

# Copy code into app directory
COPY . /app

# Expose port 5000
EXPOSE 5000

# Define Flask_APP env variable as main flask app 
ENV FLASK_APP=main.py

# Run the Flask app
CMD ["flask", "run", "--host=0.0.0.0"]
