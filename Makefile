TERRAFORM = terraform
BASH = bash

PREPARE = $(TERRAFORM) init
APPLY = $(TERRAFORM) apply
UPDATE = $(PREPARE) -upgrade
DESTROY = $(TERRAFORM) destroy

OUTPUT_ANSIBLE = instance_ip
OUTPUT_VARS = output_vars

OUTPUT_FILE_DEL_VARS = ansible/source/del_vars.sh

all: start

start:
	$(PREPARE) && $(APPLY) -auto-approve

update:
	$(UPDATE) && $(APPLY) -auto-approve

stop: outdel
	$(DESTROY) -auto-approve

outdel:
	$(BASH) $(OUTPUT_FILE_DEL_VARS)

re: stop start

.PHONY: all start stop output update update-apply re