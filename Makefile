DEFAULT_GOAL: compose
.PHONY: compose clean re

NAME			= -p inception
COMPOSE_FILE	= -f ./src/docker-compose.yml

run:
	sudo docker-compose $(NAME) $(COMPOSE_FILE) up

compose:
	sudo docker-compose $(NAME) $(COMPOSE_FILE) up --build

clean:
	sudo docker system prune -f
	sudo docker volume prune -f

attach-wp:
	sudo docker exec -it wordpress sh

attach-maria:
	sudo docker exec -it mariadb sh

attach-nginx:
	sudo docker exec -it nginx sh

re: clean compose