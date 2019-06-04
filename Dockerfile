


FROM continuumio/anaconda3:4.4.0
RUN conda install nomkl numpy scipy scikit-learn numexpr
RUN conda remove mkl mkl-service
MAINTAINER UNP, https://unp.education
EXPOSE 8000
RUN echo "deb http://deb.debian.org/debian jessie main" > /etc/apt/sources.list
RUN apt-get update && apt-get install -y apache2 \
    apache2-dev \   
    vim \
 && apt-get clean \
 && apt-get autoremove \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /var/www/text_cluster_api/
COPY ./text_cluster_api.wsgi /var/www/text_cluster_api/text_cluster_api.wsgi
COPY ./flask_demo /var/www/text_cluster_api/
RUN pip install -r requirements.txt
RUN /opt/conda/bin/mod_wsgi-express install-module
RUN mod_wsgi-express setup-server text_cluster_api.wsgi --port=8000 \
    --user www-data --group www-data \
    --server-root=/etc/mod_wsgi-express-80
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    locales-all 
CMD /etc/mod_wsgi-express-80/apachectl start -D FOREGROUND
