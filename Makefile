# DEFAULT_GOAL: compose
# .PHONY: compose clean re

# NAME			= -p inception
# COMPOSE_FILE	= -f ./src/docker-compose.yml

# run:
# 	sudo docker-compose $(NAME) $(COMPOSE_FILE) up

# compose:
# 	sudo docker-compose $(NAME) $(COMPOSE_FILE) up --build

# clean:
# 	sudo docker system prune -f
# 	sudo docker volume prune -f

# stop:
# 	sudo docker stop $$(sudo docker ps -a -q)

# attach-wp:
# 	sudo docker exec -it wordpress sh

# attach-maria:
# 	sudo docker exec -it mariadb sh

# attach-nginx:
# 	sudo docker exec -it nginx sh

# re: clean compose

.DEFAULT_GOAL := compose
.PHONY: compose clean re create-directories configure-hosts

NAME            = -p inception
COMPOSE_FILE    = -f ./src/docker-compose.yml
DIRS            = /home/inception/mariand /home/inception/wordpress
HOSTS_FILE      = /etc/hosts
DOMAIN_NAME     = jpilotte.42.fr

run:
    sudo docker-compose $(NAME) $(COMPOSE_FILE) up

create-directories:
    @for dir in $(DIRS); do \
        if [ ! -d $$dir ]; then \
            echo "Creating volumes: $$dir"; \
            mkdir -p $$dir; \
        fi; \
    done

configure-hosts:
    @if ! grep -q "$(DOMAIN_NAME)" "$(HOSTS_FILE)"; then \
        echo "Configuring hosts file for $(DOMAIN_NAME)"; \
        sudo sh -c 'echo "127.0.0.1 $(DOMAIN_NAME)" >> $(HOSTS_FILE)'; \
    fi

compose: create-directories configure-hosts
    @echo "Starting docker-compose"
    @sudo docker-compose $(NAME) $(COMPOSE_FILE) up --build


clean:
	echo "Cleaning docker images"
    sudo docker system prune -f
    sudo docker volume prune -f
	echo "Done"

stop:
	echo "Stopping docker containers"
    sudo docker stop $$(sudo docker ps -a -q)
	echo "Done"

attach-wp:
	echo "Attaching to wordpress container"
    sudo docker exec -it wordpress sh
	echo "Done"

attach-maria:
	echo "Attaching to mariadb container"
    sudo docker exec -it mariadb sh
	echo "Done"

attach-nginx:
	echo "Attaching to nginx container"
    sudo docker exec -it nginx sh
	echo "Done"

re: clean compose
