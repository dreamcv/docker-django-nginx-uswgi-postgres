FROM python:3.6.2
LABEL maintainer twtrubiks
ENV PYTHONUNBUFFERED 1
RUN mkdir /docker_api
WORKDIR /docker_api
COPY . /docker_api
RUN pip install -r requirements.txt
###RUN python manage.py collectstatic
###RUN python manage.py makemigrations
###RUN python manage.py migrate
# RUN pip install  -i  https://pypi.python.org/simple/  -r requirements.txt