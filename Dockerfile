FROM python:3.9-slim

RUN adduser -D microblog

WORKDIR /home/myblog
COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn pymsql 
COPY app app
COPY migrations migrations
COPY microblog.py config.py boot.sh ./
RUN chmod +x boot.sh
ENV FLASK_APP microblog.py
RUN chown -R myblog:myblog ./
USER myblog
EXPOSE 5000
ENTRYPOINT ["./boot.sh"]