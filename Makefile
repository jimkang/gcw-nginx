include config.mk

SSHCMD = ssh $(USER)@$(SERVER)

update-remote: push-up-nginx-config restart-nginx

install-nginx:
	$(SSHCMD) "sudo apt-get update"
	$(SSHCMD) "sudo apt-get install nginx"
	$(SSHCMD) "sudo chmod a+rwx /usr/share/nginx/html"
	$(SSHCMD) "sudo chown -R $(USER):bot /usr/share/nginx/html/"

pull-down-nginx-config:
	scp $(USER)@$(SERVER):/etc/nginx/sites-enabled/default default.nginx.conf

push-up-nginx-config:
	scp default.nginx.conf $(USER)@$(SERVER):/tmp
	$(SSHCMD) "cp /tmp/default.nginx.conf /etc/nginx/sites-enabled/default"
	$(SSHCMD) "rm /tmp/default.nginx.conf"

restart-nginx:
	$(SSHCMD) "sudo service nginx restart"

check-nginx-errors:
	$(SSHCMD) "cat /var/log/nginx/"

pushall: update-remote update-robots-txt
	git push origin main

update-only-nginx-config:
	scp default.nginx.conf $(USER)@$(SERVER):/tmp
	$(SSHCMD) "sudo cp /tmp/default.nginx.conf /etc/nginx/sites-enabled/default"
	$(SSHCMD) "sudo service nginx restart"

update-robots-txt:
	scp robots.txt $(USER)@$(SERVER):/usr/share/nginx/html/smidgeo.com
