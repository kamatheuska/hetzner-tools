-include .env
export

run:
ifndef FIREWALL_NAME
$(error FIREWALL_NAME environment variable is required)
endif
	./infra/firewalls/update-ip-ssh-firewall.sh

