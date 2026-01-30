
#RUN apt-get update
#RUN apt-get install -y python3 python3-pip

# Use an official Python runtime as a parent image
#FROM python:3.9-slim

FROM python:3.11-slim
#FROM python:3.11

# Set working directory in the container
WORKDIR /app

#RUN apt-get install -y fonts-dejavu 
#RUN apt-get install -y build-essential 
#RUN apt-get install -y libssl-dev libffi-dev 
#RUN apt-get install -y python-dev-is-python3
#RUN apt-get install -y libreoffice


ENV HTTPS_PROXY="http://ioc%5c00023569:321%402026Jan@mdproxy.ds.indianoil.in:8080"
ENV HTTP_PROXY="http://ioc%5c00023569:321%402026Jan@mdproxy.ds.indianoil.in:8080"
RUN export HTTPS_PROXY HTTP_PROXY

#---------------------------- JAVA --------------------
#FROM debian:stretch
#FROM debian:desktop-linux

#RUN apt-get install -y yum 
#RUN yum-config-manager --save --setopt=sslverify=false

#ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/

#  Install java as required by Language-Tools
#RUN apt update -y && apt-get install -y software-properties-common && \
#    apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main' && apt update -y && \
#    apt-get install -y openjdk-8-jdk-headless && \
#    pip install --no-cache-dir -r requirements.txt && \
#    export JAVA_HOME && \
#    apt-get clean

#RUN apt update -y 
#RUN apt-get install -y  default-jre  
#RUN pip install --no-cache-dir -r requirements.txt 
#RUN export JAVA_HOME 
#RUN apt-get clean

#    && apt-get install -y --no-install-recommends openjdk-17-jre-headless \


RUN apt-get update \
    && apt-get install -y --no-install-recommends default-jre-headless \
    && apt-get install -y ant  \
    && rm -rf /var/lib/apt/lists/*  \
	&& export JAVA_HOME  \
	&& apt-get clean
   
RUN export JAVA_HOME
#CMD ["java", "-version"]
RUN echo ${JAVA_HOME}
RUN echo `java -version`
 
# Fix certificate issues
#RUN apt-get update && \
#    apt-get install -y ca-certificates-java && \ 
#    apt-get clean && \
#    update-ca-certificates -f


#RUN apt update -y && \
#    apt-get install -y openjdk-8-jdk-headless && \
#    pip install --no-cache-dir -r requirements.txt && \
#    export JAVA_HOME && \
#	 apt-get clean
#---------------------------- JAVA --------------------


# Copy requirements file to the container
COPY requirements.txt .

RUN apt-get update
RUN apt-get install -y python3 python3-pip

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



