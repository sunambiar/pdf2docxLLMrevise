
# Use an official Python runtime as a parent image
FROM python:3.9-slim

RUN apt-get update
RUN apt-get install -y python3 python3-pip



# Set working directory in the container
WORKDIR /app

# Copy requirements file to the container
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
#COPY . .
COPY . /app
#COPY ./templates  /app

ENV PYTHONUNBUFFERED=1
ENV ENVIRONMENT=production
ENV LOG_FILE=app.log
ENV TIME_LOG_FILE=conversion_time.log


#ADD fonts /usr/share/fonts/

#RUN /bin/sh -c soffice --headless


ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8


# Make port 5000 available to the world outside this container
EXPOSE 5000  5566
#EXPOSE map[5000/tcp:{}]


# Set environment variables for PDF and DOCX folders
ENV PDF_FOLDER=uploads
ENV DOCX_FOLDER=docs

# Run app.py when the container launches
#CMD ["python", "app_Vivekachudamani.py"]
CMD ["python", "-X", "faulthandler", "-u", "app_Vivekachudamani.py"]



