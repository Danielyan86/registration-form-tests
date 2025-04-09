FROM debian:bullseye

USER root

RUN apt-get update && \
    apt-get install -y python3 python3-pip firefox-esr wget unzip && \
    wget https://github.com/mozilla/geckodriver/releases/download/v0.36.0/geckodriver-v0.36.0-linux64.tar.gz && \
    tar -xvzf geckodriver-v0.36.0-linux64.tar.gz && \
    mv geckodriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/geckodriver && \
    rm geckodriver-v0.36.0-linux64.tar.gz

WORKDIR /app

COPY requirements.txt .
RUN pip install  --no-cache-dir -r requirements.txt

COPY . .

ENV PYTHONPATH=/app \
    HEADLESS=true

CMD ["robot", "-d", "results", "tests/robot_test_cases"]