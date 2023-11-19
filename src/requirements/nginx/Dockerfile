FROM debian:buster

RUN apt -y update && apt install -y nginx && apt install openssl -y

COPY ./tools/execute.sh /

CMD [ "/execute.sh" ]