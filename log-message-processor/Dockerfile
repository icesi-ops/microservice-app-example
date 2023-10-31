FROM python:3.6
WORKDIR /app 
COPY . /app

ENV REDIS_HOST=redis-logger
ENV REDIS_PORT=6379
ENV REDIS_CHANNEL=log_channel

RUN pip3 install -r requirements.txt
CMD python3 main.py

#COPY requirements.txt /app/requirements.txt
#ENTRYPOINT ["python", "./launch.py"]