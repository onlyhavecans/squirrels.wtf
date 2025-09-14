---
date: '{{ .Date }}'
title: '{{ replace .File.ContentBaseName `-` ` ` | title }}'
description: A post
draft: false
tags:
  - news
---
