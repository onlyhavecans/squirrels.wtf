PELICAN=pelican
PELICANOPTS=

BASEDIR=$(PWD)
INPUTDIR=$(BASEDIR)/src
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelican.conf.py

SSH_HOST=bounce
SSH_TARGET_DIR=www

DROPBOX_DIR=~/Dropbox/Public/

help:
	@echo 'Makefile for a pelican Web site                                        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        (re)generate the web site          '
	@echo '   make clean                       remove the generated files         '
	@echo '   make update                      pup update pelican from github     '
	@echo '   ssh_up                           upload the web site using SSH      '
	@echo '   dropbox_upload                   upload the web site using Dropbox  '
	@echo '   rsync_upload                     upload the web site using rsync/ssh'
	@echo '                                                                       '


html: clean $(OUTPUTDIR)/index.html
	@echo 'Done'

$(OUTPUTDIR)/%.html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
	cp -r extras/* $(OUTPUTDIR)/

clean:
	rm -fr $(OUTPUTDIR)/*

update:
	pip install --upgrade -e 'git://github.com/ametaireau/pelican#egg=pelican'

dropbox_upload: $(OUTPUTDIR)/index.html
	cp -r $(OUTPUTDIR)/* $(DROPBOX_DIR)

ssh_up: $(OUTPUTDIR)/index.html
	scp -r $(OUTPUTDIR)/* $(SSH_HOST):$(SSH_TARGET_DIR)

rsync_upload: $(OUTPUTDIR)/index.html
	rsync -e ssh -P -rvz --delete $(OUTPUTDIR)/* $(SSH_HOST):$(SSH_TARGET_DIR)

github: $(OUTPUTDIR)/index.html
	ghp-import $(OUTPUTDIR)
	git push origin gh-pages

.PHONY: html help clean update ssh_up rsync_upload dropbox_upload github
