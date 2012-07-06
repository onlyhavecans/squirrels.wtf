PELICAN=pelican
PELICANOPTS=

BASEDIR=$(PWD)
INPUTDIR=$(BASEDIR)/src
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelican.conf.py

SSH_HOST=bounce
SSH_PORT=22
SSH_USER=tbunnyman
SSH_TARGET_DIR=www

help:
	@echo 'Makefile for a pelican Web site                                        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        (re)generate the web site          '
	@echo '   make clean                       remove the generated files         '
	@echo '   make update                      pip update pelican from github     '
	@echo '   ssh_up                           upload the web site using SSH      '
	@echo '   rsync_upload                     upload the web site using rsync/ssh'
	@echo '                                                                       '


html: clean $(OUTPUTDIR)/index.html
	@echo 'Done'

$(OUTPUTDIR)/%.html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
	cp $(BASEDIR)/extras/* $(OUTPUTDIR)/

clean:
	rm -fr $(OUTPUTDIR)/*

update:
	pip install --upgrade -e 'git://github.com/ametaireau/pelican#egg=pelican'

ssh_up: $(OUTPUTDIR)/index.html
	scp -P $(SSH_PORT) -r $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)	

rsync_upload: $(OUTPUTDIR)/index.html
	rsync -e "ssh -p $(SSH_PORT)" -P -rvz --delete $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

commit: $(OUTPUTDIR)/index.html
	git commit
	git push origin

.PHONY: html help clean update ssh_up rsync_upload commit

