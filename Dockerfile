FROM python:3.7.4

EXPOSE 8000

RUN apt-get update && \
    apt-get install -y nginx supervisor;

# Setup flask application
RUN mkdir -p /deploy/app
COPY ./ /deploy/app
RUN pip install gunicorn
RUN pip install -r /deploy/app/requirements.txt

# Setup nginx
RUN rm /etc/nginx/sites-enabled/default && \
	cp /deploy/app/flask.conf /etc/nginx/sites-available/ && \
	ln -s /etc/nginx/sites-available/flask.conf /etc/nginx/sites-enabled/flask.conf && \
	echo "daemon off;" >> /etc/nginx/nginx.conf;

# Setup supervisord
RUN mkdir -p /var/log/supervisor && \
	cp /deploy/app/supervisord.conf /etc/supervisor/conf.d/supervisord.conf && \
	cp /deploy/app/gunicorn.conf /etc/supervisor/conf.d/gunicorn.conf;


RUN apt-get clean;

WORKDIR /deploy/app

# run the application
CMD ["python", "/deploy/app/app.py"]
