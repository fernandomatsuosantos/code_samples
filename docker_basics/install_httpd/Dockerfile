FROM ubuntu:20.04

ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y apache2 && apt-get clean
 
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
