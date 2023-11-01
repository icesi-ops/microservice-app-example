FROM python:3.6

WORKDIR  /usr/src/app

COPY . /usr/src/app

ENV REDIS_PORT=6379 \
    REDIS_CHANNEL=log_channel \
    REDIS_HOST=redis_queue

RUN pip3 install -r requirements.txt
CMD python3 main.py
