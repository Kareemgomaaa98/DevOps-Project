# Use the official Python image as the base image
FROM python:3.8-slim-buster
USER root

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application files into the container
COPY web.py .
COPY index.html .

# Expose port 3030 for the Flask app
EXPOSE 3030

# Start the Flask application
CMD ["python", "web.py"]
