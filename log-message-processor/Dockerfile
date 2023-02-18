FROM python:3.10.2-slim
WORKDIR /usr/src/app
COPY . .
RUN set -xe \
    && apt-get update -y \
    && apt-get install -y python3-pip
RUN pip3 install -r requirements.txt
EXPOSE 6379
CMD ["python","./main.py"]