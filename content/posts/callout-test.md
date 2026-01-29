---
title: "Callout Test"
date: 2030-01-01
draft: true
description: "Testing Obsidian-compatible callouts"
tags: ['test']
---

This post demonstrates all available callout types.

## Basic Callouts

> [!note]
> This is a **note** callout. Use it for general information.

> [!info]
> This is an **info** callout. Good for supplementary details.

> [!tip]
> This is a **tip** callout. Share helpful advice here.

> [!abstract]
> This is an **abstract** callout. Great for summaries or TL;DR sections.

## Success & Questions

> [!success]
> This is a **success** callout. Celebrate wins!

> [!question]
> This is a **question** callout. Pose questions to readers.

> [!todo]
> This is a **todo** callout. Track tasks or action items.

## Warnings & Errors

> [!warning]
> This is a **warning** callout. Alert readers to potential issues.

> [!caution]
> This is a **caution** callout. Similar to warning, slightly softer.

> [!danger]
> This is a **danger** callout. For serious warnings.

> [!bug]
> This is a **bug** callout. Document known issues.

> [!failure]
> This is a **failure** callout. Note what didn't work.

## Special Types

> [!important]
> This is an **important** callout. Highlight critical information.

> [!example]
> This is an **example** callout. Show practical demonstrations.

> [!quote]
> This is a **quote** callout. For quotations and citations.

## Custom Titles

> [!tip] Pro Tip
> You can add custom titles after the type declaration.

> [!warning] Here Be Dragons
> Custom titles help provide context for the callout content.

## Foldable Callouts

> [!note]- Collapsed by Default
> This callout starts collapsed. Click the header to expand.
>
> You can put longer content here that readers can choose to reveal.

> [!info]+ Expanded by Default
> This foldable callout starts open but can be collapsed.
>
> The `+` means it starts expanded.

## Rich Content

> [!example] Code Example
> Callouts support rich markdown content:
>
> ```python
> def hello():
>     print("Hello from a callout!")
> ```
>
> Including **bold**, *italic*, and [links](https://example.com).

> [!note] Lists Work Too
> - First item
> - Second item
> - Third item
>
> And numbered lists:
> 1. One
> 2. Two
> 3. Three

## Type Aliases

These aliases map to the same styles:

> [!summary]
> Alias for **abstract**

> [!hint]
> Alias for **tip**

> [!check]
> Alias for **success**

> [!error]
> Alias for **danger**

> [!faq]
> Alias for **question**
