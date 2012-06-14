#!/usr/bin/env python
# -*- coding: utf-8 -*- #

AUTHOR = u"theBunnyMan"
SITENAME = u"BunnyMan.Info"
SITEURL = 'http://bunnyman.info'
TIMEZONE = 'US/Pacific'
DEFAULT_LANG='en'
DEFAULT_PAGINATION = 5
DELETE_OUTPUT_DIRECTORY = False

FEED_DOMAIN = SITEURL
# Use RSS
FEED_RSS = 'feeds/rss'
CATEGORY_FEED_RSS = 'feeds/category.%s.rss'
TAG_FEED_RSS = None
FEED_MAX_ITEMS = 30

#Theme
THEME = 'notmyidea'
CSS_FILE = 'main.css'

# Blogroll
LINKS = (
	('Pelican', 'http://docs.notmyidea.org/alexis/pelican/'),
	('Python.org', 'http://python.org'),
	('Jinja2', 'http://jinja.pocoo.org'),
	('#Hackerfurs', 'https://sites.google.com/site/hackerfurs/'),
	('VegasFurs', 'http://vegasfurs.net'),
)

# Social widget
SOCIAL = (
	('GitHub', 'https://github.com/tbunnyman'),
	('Twitter', 'https://twitter.com/#!/bunnyman'),
)