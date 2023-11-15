# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory to /rates
WORKDIR /rates

# Copy the current directory contents into the container at /rates
COPY . /

# Install gunicorn
RUN pip install -U gunicorn

# Install any needed packages specified in requirements.txt
RUN pip install -Ur requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV FLASK_APP=rates.py

# Run app.py when the container launches
CMD ["gunicorn", "-b", "0.0.0.0:5000", "wsgi"]