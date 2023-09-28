FROM python:3.6-alpine

WORKDIR /usr/src/app
ENV REDIS_HOST=redis_queue \
    REDIS_PORT=6379 \
    ZIPKIN_URL=http://zipkin:9411/api/v2/spans  \
    REDIS_CHANNEL=log_channel
RUN apk add --no-cache build-base
COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY main.py .

CMD ["python3","-u","main.py"]