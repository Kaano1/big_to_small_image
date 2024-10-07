TERRAFORM = terraform
BASH = bash

PREPARE = $(TERRAFORM) init
APPLY = $(TERRAFORM) apply
UPDATE = $(PREPARE) -upgrade
DESTROY = $(TERRAFORM) destroy

OUTPUT_ANSIBLE = instance_ip
OUTPUT_VARS = output_vars

OUTPUT_FILE_ANSIBLE = ansible/inventory.ini
OUTPUT_FILE_ADD_VARS = ansible/source/add_vars.sh
OUTPUT_FILE_DEL_VARS = ansible/source/del_vars.sh

all: start output

update: update-apply output

outputr: outdel output

start:
	$(PREPARE) && $(APPLY) -auto-approve

update-apply:
	$(UPDATE) && $(APPLY) -auto-approve

stop: outdel
	$(DESTROY) -auto-approve

output:
	$(TERRAFORM) output -raw $(OUTPUT_ANSIBLE) > $(OUTPUT_FILE_ANSIBLE) && \
	$(TERRAFORM) output -raw $(OUTPUT_VARS) > $(OUTPUT_FILE_ADD_VARS) && \
	$(BASH) $(OUTPUT_FILE_ADD_VARS)

outdel:
	$(BASH) $(OUTPUT_FILE_DEL_VARS)

re: stop start

.PHONY: all start stop output update update-apply re