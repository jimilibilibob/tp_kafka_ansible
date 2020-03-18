FROM jupyter/base-notebook 

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

USER jovyan

RUN git clone https://github.com/jimilibilibob/tp_kafka_notebook.git