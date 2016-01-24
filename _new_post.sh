#!/bin/sh
if [ -z "$1" ]; then
  echo "Usage: provide a title argument"
  exit -1
else
  title="$@"
fi

slug=$(echo "$title" | tr "[:upper:]" "[:lower:]")
slug=$(echo "$slug" | sed "y/āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜĀÁǍÀĒÉĚÈĪÍǏÌŌÓǑÒŪÚǓÙǕǗǙǛ/aaaaeeeeiiiioooouuuuüüüüAAAAEEEEIIIIOOOOUUUUÜÜÜÜ/")
slug=$(echo "$slug" | tr "[:punct:]" " ")
slug=$(echo "$slug" | tr _ " ")
slug=$(echo "$slug" | tr - " ")
slug=$(echo "$slug" | tr -s " ")
slug=$(echo "$slug" | tr "[:space:]" "-")
slug="${slug:0:${#slug}-1}"

y=$(date +"%Y")
m=$(date +"%m")
d=$(date +"%d")

post="./_drafts/$y-$m-$d-$slug.md"

body=""
read -d '' body <<EOF
---
layout: post
title: "$title"
description: "Description: $title"
image: /img/blog/blog-placeholder.jpg
tags:
- NetLicensing
author:
  name: NetLicensing
  url: http://netlicensing.io
canonical:
sitemap:
  images:
---

Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.

EOF

echo "$body" > "$post"

echo Created new draft post: "$post"
