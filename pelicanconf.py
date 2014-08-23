#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u"tBunnyMan"
SITENAME = u"BunnyMan.Info"
SITESUBTITLE = u"Because life is too awesome not to share"
SITEURL = ''
TIMEZONE = 'US/Pacific'

DEFAULT_LANG = 'en'

DEFAULT_PAGINATION = 3

# Use RSS
FEED_DOMAIN = SITEURL
FEED_RSS = 'feeds/rss'
CATEGORY_FEED_RSS = 'feeds/category.%s.rss'
TAG_FEED_RSS = None
FEED_MAX_ITEMS = 30

# Theme
THEME = './theme/chunk'
SINGLE_AUTHOR = False
DISPLAY_CATEGORIES_ON_MENU = True
DEFAULT_DATE_FORMAT = ('%b %d %Y')
# TYPOGRIFY = True

# Blogroll
LINKS = (
    ('GitHub', 'https://github.com/tbunnyman'),
)

# Cleaner page links
PAGE_URL = '{slug}.html'
PAGE_SAVE_AS = '{slug}.html'
PAGE_LANG_URL = '{slug}-{lang}.html'
PAGE_LANG_SAVE_AS = '{slug}-{lang}.html'

# Cleaner Articles
ARTICLE_URL = 'posts/{date:%Y}/{date:%b}/{date:%d}/{slug}/'
ARTICLE_SAVE_AS = 'posts/{date:%Y}/{date:%b}/{date:%d}/{slug}/index.html'
