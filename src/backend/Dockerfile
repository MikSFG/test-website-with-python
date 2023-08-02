FROM python:3.9-alpine

COPY . /app

WORKDIR /app

RUN python3 -m pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD python main.py
