# TP Kafka Ansible 

Ce repository à pour but de créer l'image d'un environnement de travail dans le cadre d'un TP autour de Kafka. 

## Roles ansible

- zookeeper-kafka-server : Rôle installant Zookepeer et Kafka. Puis les démarre en tant que service.
- kafka-topic : Créer un premier Topic "first_topic"
- Docker : Installe docker et déploie [un conteneur](https://hub.docker.com/repository/docker/jimilibilibob/tp-jupynotebook-git) avec Jupyter Noteebook et un [repo git](https://github.com/jimilibilibob/tp_kafka_notebook) comprenant le code Pykafka du TP 

## Packer

Création d'une image et déploiement de celle-ci sur une Shared Gallery Azure 

## Terraform 

Coming soon 
      


### To Do 

- Ansible : Gestion user, gestion des logs et ajout des tags 
- Packer : Définir process (authent azure, déploiement image shared gallery et image definition)
- Terraform : ... 
- TP : Code PyKafka 
- TP suite : Nginx, Node, Mongo et librairies D3JS et Io Socket pour Dashboard stream 
