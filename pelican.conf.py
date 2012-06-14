#!/usr/bin/env python
# -*- coding: utf-8 -*- #

AUTHOR = u"theBunnyMan"
SITENAME = u"BunnyMan.Info"
SITEURL = 'http://bunnyman.info'
TIMEZONE = 'US/Pacific'
DEFAULT_LANG='en'
DEFAULT_PAGINATION = 5
DELETE_OUTPUT_DIRECTORY = False

## I want my URLs to mimic a dynamic site; ie, they all point to a / with an index
# Article
ARTICLE_URL = 'post/{date:%Y}/{date:%b}/{date:%d}/{slug}/'
ARTICLE_SAVE_AS = 'post/{date:%Y}/{date:%b}/{date:%d}/{slug}/index.html'
ARTICLE_LANG_URL = 'post/{date:%Y}/{date:%b}/{date:%d}/{slug}-{lang}/'
ARTICLE_LANG_SAVE_AS = '/post/{date:%Y}/{date:%b}/{date:%d}/{slug}-{lang}/index.html'
# Page
PAGE_URL = '{slug}/'
PAGE_SAVE_AS = '{slug}/index.html'
PAGE_LANG_URL = '{slug}-{lang}/'
PAGE_LANG_SAVE_AS = '{slug}-{lang}/index.html'
# Category
AUTHOR_URL = 'author/{name}/'
AUTHOR_SAVE_AS = 'author/{name}/index.html'
CATEGORY_URL = 'category/{name}/'
CATEGORY_SAVE_AS = 'category/{name}/index.html'
TAG_URL = 'tag/{name}/'
TAG_SAVE_AS = 'tag/{name}/index.html'

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