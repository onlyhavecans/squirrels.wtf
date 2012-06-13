PELICAN=pelican
PELICANOPTS=

BASEDIR=$(PWD)
INPUTDIR=$(BASEDIR)/src
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelican.conf.py

SSH_HOST=locahost
SSH_USER=root
SSH_TARGET_DIR=/var/www

DROPBOX_DIR=~/Dropbox/Public/

help:
	@echo 'Makefile for a pelican Web site                                        '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        (re)generate the web site          '
	@echo '   make clean                       remove the generated files         '
	@echo '   ssh_upload                       upload the web site using SSH      '
	@echo '   dropbox_upload                   upload the web site using Dropbox  '
	@echo '   rsync_upload                     upload the web site using rsync/ssh'
	@echo '                                                                       '


html: clean $(OUTPUTDIR)/index.html
	@echo 'Done'

$(OUTPUTDIR)/%.html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

clean:
	rm -fr $(OUTPUTDIR)/*

dropbox_upload: $(OUTPUTDIR)/index.html
	cp -r $(OUTPUTDIR)/* $(DROPBOX_DIR)

ssh_upload: $(OUTPUTDIR)/index.html
	scp -r $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

rsync_upload: $(OUTPUTDIR)/index.html
	rsync -e ssh -P -rvz --delete $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

github: $(OUTPUTDIR)/index.html
	ghp-import $(OUTPUTDIR)
	git push origin gh-pages

.PHONY: html help clean ssh_upload rsync_upload dropbox_upload github
